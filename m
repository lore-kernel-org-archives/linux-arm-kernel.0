From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:16 -0300
Subject: [PATCH 1/6] ARM: dts: imx28-evk: Move regulators outside simple-bus
Message-ID: <1532119161-16597-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is recommended to place regulators outside simple-bus, so move them
accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-evk.dts | 135 ++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 6b0ae66..210aee0 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -13,6 +13,67 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_vddio_sd0: regulator-vddio-sd0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 28 0>;
+	};
+
+	reg_fec_3v3: regulator-fec-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fec-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 15 0>;
+	};
+
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 9 0>;
+		enable-active-high;
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 8 0>;
+		enable-active-high;
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 30 0>;
+		enable-active-high;
+	};
+
+	reg_can_3v3: regulator-can-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "can-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 13 0>;
+		enable-active-high;
+	};
+
 	apb at 80000000 {
 		apbh at 80000000 {
 			gpmi-nand at 8000c000 {
@@ -269,80 +330,6 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_3p3v: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_vddio_sd0: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vddio-sd0";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 28 0>;
-		};
-
-		reg_fec_3v3: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "fec-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 15 0>;
-		};
-
-		reg_usb0_vbus: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "usb0_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 9 0>;
-			enable-active-high;
-		};
-
-		reg_usb1_vbus: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "usb1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 8 0>;
-			enable-active-high;
-		};
-
-		reg_lcd_3v3: regulator at 5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "lcd-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 30 0>;
-			enable-active-high;
-		};
-
-		reg_can_3v3: regulator at 6 {
-			compatible = "regulator-fixed";
-			reg = <6>;
-			regulator-name = "can-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio2 13 0>;
-			enable-active-high;
-		};
-
-	};
-
 	sound {
 		compatible = "fsl,imx28-evk-sgtl5000",
 			     "fsl,mxs-audio-sgtl5000";
-- 
2.7.4
