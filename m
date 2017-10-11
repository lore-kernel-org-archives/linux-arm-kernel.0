From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:36 +0200
Subject: [PATCH 2/7] ARM: dts: imx53-tx53: remove the regulators bus
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not recommended to place the regulator nodes inside 'simple-bus',
so adjust them accordingly.

The motivation for rearranging this is to make it easier to add new
regulator nodes in the future.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 38 +++++++--------
 arch/arm/boot/dts/imx53-tx53-x13x.dts | 38 +++++++--------
 arch/arm/boot/dts/imx53-tx53.dtsi     | 91 +++++++++++++++--------------------
 3 files changed, 74 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 7f0a7dd..aa9ae84 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -203,28 +203,24 @@
 		default-brightness-level = <50>;
 	};
 
-	regulators {
-		reg_lcd_pwr: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "LCD POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-		};
+	reg_lcd_pwr: regulator-lcd-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 
-		reg_lcd_reset: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
-			regulator-name = "LCD RESET";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-		};
+	reg_lcd_reset: regulator-lcd-reset {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD RESET";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 62670e9..0d17c80 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -99,28 +99,24 @@
 		default-brightness-level = <50>;
 	};
 
-	regulators {
-		reg_lcd_pwr0: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "LVDS0 POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-		};
+	reg_lcd_pwr0: regulator-lvds0-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "LVDS0 POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 
-		reg_lcd_pwr1: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
-			regulator-name = "LVDS1 POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-		};
+	reg_lcd_pwr1: regulator-lvds1-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "LVDS1 POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 7577016..a3e7cf9 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -96,61 +96,50 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_2v5: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "2V5";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-		};
+	reg_2v5: regulator-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "2V5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+	};
 
-		reg_3v3: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-		};
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
-		reg_can_xcvr: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "CAN XCVR";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_can_xcvr>;
-			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
-		};
+	reg_can_xcvr: regulator-can-xcvr {
+		compatible = "regulator-fixed";
+		regulator-name = "CAN XCVR";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can_xcvr>;
+		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+	};
 
-		reg_usbh1_vbus: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usbh1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usbh1_vbus>;
-			gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usbh1_vbus: regulator-usbh1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbh1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1_vbus>;
+		gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usbotg_vbus: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "usbotg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usbotg_vbus>;
-			gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usbotg_vbus: regulator-usbotg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbotg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg_vbus>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	sound {
-- 
2.1.4
