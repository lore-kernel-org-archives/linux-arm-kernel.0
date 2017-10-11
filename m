From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:05:37 +0200
Subject: [PATCH 2/4] ARM: dts: imx28-tx28: remove the regulators bus
In-Reply-To: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507719939-27250-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not recommended to place the regulator nodes inside 'simple-bus',
so adjust them accordingly.

The motivation for rearranging this is to make it easier to add new
regulator nodes in the future.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts | 127 ++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 319cf17..211e67d 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -75,82 +75,69 @@
 		status = "disabled";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb0_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb0_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio0 18 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usb1_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_2p5v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "2P5V";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-			regulator-always-on;
-		};
+	reg_2p5v: regulator-2p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P5V";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
 
-		reg_3p3v: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_can_xcvr: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "CAN XCVR";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
-		};
+	reg_can_xcvr: regulator-can-xcvr {
+		compatible = "regulator-fixed";
+		regulator-name = "CAN XCVR";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
+	};
 
-		reg_lcd: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "LCD POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 31 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_lcd: regulator-lcd-power {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_lcd_reset: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
-			regulator-name = "LCD RESET";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
-			startup-delay-us = <300000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-		};
+	reg_lcd_reset: regulator-lcd-reset {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD RESET";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <300000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
 	};
 
 	clocks {
-- 
2.1.4
