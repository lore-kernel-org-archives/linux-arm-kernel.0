From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:48 +0200
Subject: [PATCH 13/20] ARM: dts: sun4i: Remove gpio-keys warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <247d527cb833713f487b97a2c95e30545273ac92.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some gpio-keys definitions in our DTs were having buttons defined with a
unit-address and that would generate a DTC warning.

Change the buttons node names to remove the warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 40 ++++++++++-----------
 arch/arm/boot/dts/sun4i-a10-pcduino.dts      |  6 +--
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 7c7f12132ea3..13224f5ac166 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -67,7 +67,7 @@
 		#size-cells = <0>;
 		poll-interval = <20>;
 
-		button at 0 {
+		left-joystick-left {
 			label = "Left Joystick Left";
 			linux,code = <ABS_X>;
 			linux,input-type = <EV_ABS>;
@@ -75,7 +75,7 @@
 			gpios = <&pio 0 6 GPIO_ACTIVE_LOW>; /* PA6 */
 		};
 
-		button at 1 {
+		left-joystick-right {
 			label = "Left Joystick Right";
 			linux,code = <ABS_X>;
 			linux,input-type = <EV_ABS>;
@@ -83,7 +83,7 @@
 			gpios = <&pio 0 5 GPIO_ACTIVE_LOW>; /* PA5 */
 		};
 
-		button at 2 {
+		left-joystick-up {
 			label = "Left Joystick Up";
 			linux,code = <ABS_Y>;
 			linux,input-type = <EV_ABS>;
@@ -91,7 +91,7 @@
 			gpios = <&pio 0 8 GPIO_ACTIVE_LOW>; /* PA8 */
 		};
 
-		button at 3 {
+		left-joystick-down {
 			label = "Left Joystick Down";
 			linux,code = <ABS_Y>;
 			linux,input-type = <EV_ABS>;
@@ -99,7 +99,7 @@
 			gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
 		};
 
-		button at 4 {
+		right-joystick-left {
 			label = "Right Joystick Left";
 			linux,code = <ABS_Z>;
 			linux,input-type = <EV_ABS>;
@@ -107,7 +107,7 @@
 			gpios = <&pio 0 1 GPIO_ACTIVE_LOW>; /* PA1 */
 		};
 
-		button at 5 {
+		right-joystick-right {
 			label = "Right Joystick Right";
 			linux,code = <ABS_Z>;
 			linux,input-type = <EV_ABS>;
@@ -115,7 +115,7 @@
 			gpios = <&pio 0 0 GPIO_ACTIVE_LOW>; /* PA0 */
 		};
 
-		button at 6 {
+		right-joystick-up {
 			label = "Right Joystick Up";
 			linux,code = <ABS_RZ>;
 			linux,input-type = <EV_ABS>;
@@ -123,7 +123,7 @@
 			gpios = <&pio 0 3 GPIO_ACTIVE_LOW>; /* PA3 */
 		};
 
-		button at 7 {
+		right-joystick-down {
 			label = "Right Joystick Down";
 			linux,code = <ABS_RZ>;
 			linux,input-type = <EV_ABS>;
@@ -131,7 +131,7 @@
 			gpios = <&pio 0 4 GPIO_ACTIVE_LOW>; /* PA4 */
 		};
 
-		button at 8 {
+		dpad-left {
 			label = "DPad Left";
 			linux,code = <ABS_HAT0X>;
 			linux,input-type = <EV_ABS>;
@@ -139,7 +139,7 @@
 			gpios = <&pio 7 23 GPIO_ACTIVE_LOW>; /* PH23 */
 		};
 
-		button at 9 {
+		dpad-right {
 			label = "DPad Right";
 			linux,code = <ABS_HAT0X>;
 			linux,input-type = <EV_ABS>;
@@ -147,7 +147,7 @@
 			gpios = <&pio 7 24 GPIO_ACTIVE_LOW>; /* PH24 */
 		};
 
-		button at 10 {
+		dpad-up {
 			label = "DPad Up";
 			linux,code = <ABS_HAT0Y>;
 			linux,input-type = <EV_ABS>;
@@ -155,7 +155,7 @@
 			gpios = <&pio 7 25 GPIO_ACTIVE_LOW>; /* PH25 */
 		};
 
-		button at 11 {
+		dpad-down {
 			label = "DPad Down";
 			linux,code = <ABS_HAT0Y>;
 			linux,input-type = <EV_ABS>;
@@ -163,49 +163,49 @@
 			gpios = <&pio 7 26 GPIO_ACTIVE_LOW>; /* PH26 */
 		};
 
-		button at 12 {
+		x {
 			label = "Button X";
 			linux,code = <BTN_X>;
 			gpios = <&pio 0 16 GPIO_ACTIVE_LOW>; /* PA16 */
 		};
 
-		button at 13 {
+		y {
 			label = "Button Y";
 			linux,code = <BTN_Y>;
 			gpios = <&pio 0 14 GPIO_ACTIVE_LOW>; /* PA14 */
 		};
 
-		button at 14 {
+		a {
 			label = "Button A";
 			linux,code = <BTN_A>;
 			gpios = <&pio 0 17 GPIO_ACTIVE_LOW>; /* PA17 */
 		};
 
-		button at 15 {
+		b {
 			label = "Button B";
 			linux,code = <BTN_B>;
 			gpios = <&pio 0 15 GPIO_ACTIVE_LOW>; /* PA15 */
 		};
 
-		button at 16 {
+		select {
 			label = "Select Button";
 			linux,code = <BTN_SELECT>;
 			gpios = <&pio 0 11 GPIO_ACTIVE_LOW>; /* PA11 */
 		};
 
-		button at 17 {
+		start {
 			label = "Start Button";
 			linux,code = <BTN_START>;
 			gpios = <&pio 0 12 GPIO_ACTIVE_LOW>; /* PA12 */
 		};
 
-		button at 18 {
+		top-left {
 			label = "Top Left Button";
 			linux,code = <BTN_TL>;
 			gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 */
 		};
 
-		button at 19 {
+		top-right {
 			label = "Top Right Button";
 			linux,code = <BTN_TR>;
 			gpios = <&pio 0 13 GPIO_ACTIVE_LOW>; /* PA13 */
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index be7508cecd2e..6e140547b638 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -79,19 +79,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		button at 0 {
+		back {
 			label = "Key Back";
 			linux,code = <KEY_BACK>;
 			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
 		};
 
-		button at 1 {
+		home {
 			label = "Key Home";
 			linux,code = <KEY_HOME>;
 			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
 		};
 
-		button at 2 {
+		menu {
 			label = "Key Menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
-- 
git-series 0.9.1
