From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  9 Sep 2014 13:26:01 +0200
Subject: [PATCH 2/4] ARM: dts: imx28-tx28: use GPIO flags
In-Reply-To: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
References: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1410261963-27956-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 4e790c2..cfe6b31 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -37,7 +37,7 @@
 
 	onewire {
 		compatible = "w1-gpio";
-		gpios = <&gpio2 7 0>;
+		gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
 
@@ -52,7 +52,7 @@
 			regulator-name = "usb0_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio0 18 0>;
+			gpio = <&gpio0 18 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -62,7 +62,7 @@
 			regulator-name = "usb1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 27 0>;
+			gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -90,7 +90,7 @@
 			regulator-name = "CAN XCVR";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 0 0>;
+			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
 		};
@@ -101,7 +101,7 @@
 			regulator-name = "LCD POWER";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 31 0>;
+			gpio = <&gpio1 31 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -111,7 +111,7 @@
 			regulator-name = "LCD RESET";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 30 0>;
+			gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 			startup-delay-us = <300000>;
 			enable-active-high;
 			regulator-always-on;
@@ -143,7 +143,7 @@
 
 		user_led: user {
 			label = "Heartbeat";
-			gpios = <&gpio4 10 0>;
+			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -172,16 +172,16 @@
 	matrix_keypad: matrix-keypad at 0 {
 		compatible = "gpio-matrix-keypad";
 		col-gpios = <
-			&gpio5 0 0
-			&gpio5 1 0
-			&gpio5 2 0
-			&gpio5 3 0
+			&gpio5 0 GPIO_ACTIVE_HIGH
+			&gpio5 1 GPIO_ACTIVE_HIGH
+			&gpio5 2 GPIO_ACTIVE_HIGH
+			&gpio5 3 GPIO_ACTIVE_HIGH
 		>;
 		row-gpios = <
-			&gpio5 4 0
-			&gpio5 5 0
-			&gpio5 6 0
-			&gpio5 7 0
+			&gpio5 4 GPIO_ACTIVE_HIGH
+			&gpio5 5 GPIO_ACTIVE_HIGH
+			&gpio5 6 GPIO_ACTIVE_HIGH
+			&gpio5 7 GPIO_ACTIVE_HIGH
 		>;
 		/* sample keymap */
 		linux,keymap = <
@@ -284,8 +284,8 @@
 		pinctrl-0 = <&tx28_edt_ft5x06_pins>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <5 0>;
-		reset-gpios = <&gpio2 6 1>;
-		wake-gpios = <&gpio4 9 0>;
+		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
 	};
 
 	touchscreen: tsc2007 at 48 {
@@ -295,7 +295,7 @@
 		pinctrl-0 = <&tx28_tsc2007_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <20 0>;
-		pendown-gpio = <&gpio3 20 1>;
+		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = /bits/ 16 <660>;
 	};
 
-- 
1.7.10.4
