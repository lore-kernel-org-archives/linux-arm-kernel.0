From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Nov 2017 20:49:59 -0200
Subject: [PATCH 2/3] ARM: dts: imx6sx-sdb: Rearrange the regulators node
Message-ID: <1511304601-1149-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is not recommended to place regulators inside "simple-bus", so
move them out. The motivation for doing this is to make it easier to
adding new regulators.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 135 +++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index da81552..d76b458 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -49,86 +49,73 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vcc_sd3: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_vcc_sd3>;
-			regulator-name = "VCC_SD3";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-			gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	vcc_sd3: regulator-vcc-sd3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_vcc_sd3>;
+		regulator-name = "VCC_SD3";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usb_otg1_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb_otg1>;
-			regulator-name = "usb_otg1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_otg1>;
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usb_otg2_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb_otg2>;
-			regulator-name = "usb_otg2_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_otg2>;
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_psu_5v: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "PSU-5V0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
+	reg_psu_5v: regulator-psu-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "PSU-5V0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 
-		reg_lcd_3v3: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "lcd-3v3";
-			gpio = <&gpio3 27 0>;
-			enable-active-high;
-		};
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		gpio = <&gpio3 27 0>;
+		enable-active-high;
+	};
 
-		reg_peri_3v3: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_peri_3v3>;
-			regulator-name = "peri_3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-			regulator-always-on;
-		};
+	reg_peri_3v3: regulator-peri-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_peri_3v3>;
+		regulator-name = "peri_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
 
-		reg_enet_3v3: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_enet_3v3>;
-			regulator-name = "enet_3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
-		};
+	reg_enet_3v3: regulator-enet-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enet_3v3>;
+		regulator-name = "enet_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 	};
 
 	sound {
-- 
2.7.4
