From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 31 Mar 2016 14:33:41 +0200
Subject: [PATCHv3 1/5] ARM: dts: imx6-tx6: remove regulator bus
In-Reply-To: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
References: <1459427625-15568-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1459427625-15568-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT maintainers don't like the 'simple-bus' container around the
regulator nodes. So remove it.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 166 +++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index afc6022..a3e37a7 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -93,104 +93,88 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3v3_etn: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3V3_ETN";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_etnphy_power>;
-			gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_3v3_etn: regulator-3v3-etn {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3_ETN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_etnphy_power>;
+		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_2v5: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "2V5";
-			regulator-min-microvolt = <2500000>;
-			regulator-max-microvolt = <2500000>;
-			regulator-always-on;
-		};
+	reg_2v5: regulator-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "2V5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
 
-		reg_3v3: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_can_xcvr: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "CAN XCVR";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_flexcan_xcvr>;
-			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
-			enable-active-low;
-		};
+	reg_can_xcvr: regulator-can-xcvr {
+		compatible = "regulator-fixed";
+		regulator-name = "CAN XCVR";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_xcvr>;
+		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+		enable-active-low;
+	};
 
-		reg_lcd0_pwr: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "LCD0 POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd0_pwr>;
-			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-			regulator-always-on;
-		};
+	reg_lcd0_pwr: regulator-lcd0-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD0 POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 
-		reg_lcd1_pwr: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "LCD1 POWER";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd1_pwr>;
-			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-boot-on;
-			regulator-always-on;
-		};
+	reg_lcd1_pwr: regulator-lcd1-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD1 POWER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd1_pwr>;
+		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 
-		reg_usbh1_vbus: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
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
 
-		reg_usbotg_vbus: regulator at 7 {
-			compatible = "regulator-fixed";
-			reg = <7>;
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
