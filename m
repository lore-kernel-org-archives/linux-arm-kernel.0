From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:25 +0800
Subject: [PATCH 07/22] ARM: ux500: Use correct format for dynamic IRQ
 assignment
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch applies the correct format requested by the irq
domain. For chained IRQs which use GPIO lines as IRQs, we
stipulate that a two cell request is required. The first cell
contains the requested IRQ and the second can contain flags
pertaining to edge detection and level sensitive values. The
zeroth cell specifies the GPIO controller by use of a phandle.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi  |   21 ++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts |   17 ++++++++---------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 7be77df..7070000 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -58,6 +58,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8012e000 0x80>;
 			interrupts = <0 119 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -69,6 +71,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8012e080 0x80>;
 			interrupts = <0 120 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -80,6 +84,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e000 0x80>;
 			interrupts = <0 121 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -91,6 +97,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e080 0x80>;
 			interrupts = <0 122 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -102,6 +110,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e100 0x80>;
 			interrupts = <0 123 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -113,6 +123,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8000e180 0x80>;
 			interrupts = <0 124 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -124,6 +136,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8011e000 0x80>;
 			interrupts = <0 125 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -135,6 +149,8 @@
 				"st,nomadik-gpio";
 			reg =  <0x8011e080 0x80>;
 			interrupts = <0 126 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -146,6 +162,8 @@
 				"st,nomadik-gpio";
 			reg =  <0xa03fe000 0x80>;
 			interrupts = <0 127 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			supports-sleepmode;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -235,7 +253,8 @@
 			status = "disabled";
 
 			// Add one of these for each child device
-			cs-gpios = <&gpio0 31 &gpio4 14 &gpio4 16 &gpio6 22 &gpio7 0>;
+			cs-gpios = <&gpio0 31 0x4 &gpio4 14 0x4 &gpio4 16 0x4
+				    &gpio6 22 0x4 &gpio7 0 0x4>;
 
 		};
 
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index d99dc04..81ff557 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -30,35 +30,35 @@
 			wakeup = <1>;
 			linux,code = <2>;
 			label = "userpb";
-			gpios = <&gpio1 0 0>;
+			gpios = <&gpio1 0 0x4>;
 		};
 		button at 2 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <3>;
 			label = "extkb1";
-			gpios = <&gpio4 23 0>;
+			gpios = <&gpio4 23 0x4>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <4>;
 			label = "extkb2";
-			gpios = <&gpio4 24 0>;
+			gpios = <&gpio4 24 0x4>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <5>;
 			label = "extkb3";
-			gpios = <&gpio5 1 0>;
+			gpios = <&gpio5 1 0x4>;
 		};
 		button at 5 {
 			debounce_interval = <50>;
 			wakeup = <1>;
 			linux,code = <6>;
 			label = "extkb4";
-			gpios = <&gpio5 2 0>;
+			gpios = <&gpio5 2 0x4>;
 		};
 	};
 
@@ -66,12 +66,11 @@
 		compatible = "gpio-leds";
 		used-led {
 			label = "user_led";
-			gpios = <&gpio4 14>;
+			gpios = <&gpio4 14 0x4>;
 		};
 	};
 
 	soc-u9500 {
-
 		external-bus at 50000000 {
 			status = "okay";
 
@@ -91,7 +90,7 @@
 
 		sdi at 80126000 {
 			status = "enabled";
-			cd-gpios = <&gpio6 26>;
+			cd-gpios  = <&gpio6 26 0x4>; // 218
 		};
 
 		sdi at 80114000 {
@@ -114,7 +113,7 @@
 			tc3589x at 42 {
 				//compatible = "tc3589x";
 				reg = <0x42>;
-				interrupts = <25>;
+				gpios = <&gpio6 25 0x4>;
 				interrupt-parent = <&gpio6>;
 			};
 			tps61052 at 33 {
-- 
1.7.9.5
