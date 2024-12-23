cp-release-properties-template:
	cp android/release.properties.template android/release.properties

flutter-clean:
	fvm flutter clean

flutter-doctor:
	fvm flutter doctor

flutter-pub-get:
	fvm flutter pub get

flutter-run:
	fvm flutter run

COCOAPODS_VERSION := 1.16.2
install-cocoapods:
	@if test "$(shell pod --version 2>/dev/null)" != "$(COCOAPODS_VERSION)"; then \
		echo "Installing CocoaPods ..."; \
		gem uninstall cocoapods -aIx && gem install cocoapods -v $(COCOAPODS_VERSION); \
	else \
		echo "CocoaPods is already installed."; \
	fi

install-fvm:
	@if brew tap | grep -q "leoafarias/fvm" 2>/dev/null; then \
		echo "Tap 'leoafarias/fvm' is already installed."; \
	else \
		echo "Installing tap 'leoafarias/fvm' ..."; \
		brew tap leoafarias/fvm; \
	fi
	@if brew list fvm &>/dev/null; then \
		echo "fvm is already installed."; \
	else \
		echo "Installing fvm ..."; \
		brew install fvm; \
	fi

open-deep-link-on-ios-simulator:
	xcrun simctl openurl booted $(url)

open-deep-link-on-android-emulator:
	adb shell am start -a android.intent.action.VIEW -d $(url)

open-xcode:
	open ios/Runner.xcworkspace

pod-refresh:
	cd ios && rm -rf Pods && pod install

refresh:
	@make flutter-clean
	@make flutter-pub-get
	@make pod-refresh

setup:
	@make install-fvm
	fvm use
	@make install-cocoapods
	@make flutter-pub-get
	@make flutter-doctor
