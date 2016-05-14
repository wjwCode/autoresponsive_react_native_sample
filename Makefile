current_version = $$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
npm_bin= $$(npm bin)

all: test
install:
	@npm install
start:
	@npm run start
clean:
	find ~/Library/Developer/Xcode -name autoresponsive_react_native_sample.app | xargs rm -rf
test: clean build
	APP_PATH=${shell find ~/Library/Developer/Xcode -name autoresponsive_react_native_sample.app} ${npm_bin}/macaca run --verbose -d ./test
build:
	xcodebuild clean build -scheme autoresponsive_react_native_sample CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY=""
test-android: install build-android
	platform=android APP_PATH=./android/app/build/outputs/apk/app-debug.apk ${npm_bin}/macaca run --verbose -d ./test
build-android:
	cd android && ./gradlew clean assembleDebug
lint:
	@${npm_bin}/eslint
.PHONY: all test build
