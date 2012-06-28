From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:07 +0800
Subject: [PATCH 11/11] ARM: dts: mxs: add lcd support for imx23-evk and
 imx28-evk
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lcd support for imx23-evk and imx28-evk.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |    7 +++++++
 arch/arm/boot/dts/imx23.dtsi    |   39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-evk.dts |    7 +++++++
 arch/arm/boot/dts/imx28.dtsi    |   38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 3974959d..9d674ca 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -48,6 +48,13 @@
 					fsl,pull-up = <0>;
 				};
 			};
+
+			lcdif at 80030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcdif_24bit_pins_a>;
+				panel-enable-gpios = <&gpio1 18 0>;
+				status = "okay";
+			};
 		};
 
 		apbx at 80040000 {
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 22e1617..7662134 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -191,6 +191,43 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				lcdif_24bit_pins_a: lcdif-24bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1000 /* MX23_PAD_LCD_D00__LCD_D0 */
+						0x1010 /* MX23_PAD_LCD_D01__LCD_D1 */
+						0x1020 /* MX23_PAD_LCD_D02__LCD_D2 */
+						0x1030 /* MX23_PAD_LCD_D03__LCD_D3 */
+						0x1040 /* MX23_PAD_LCD_D04__LCD_D4 */
+						0x1050 /* MX23_PAD_LCD_D05__LCD_D5 */
+						0x1060 /* MX23_PAD_LCD_D06__LCD_D6 */
+						0x1070 /* MX23_PAD_LCD_D07__LCD_D7 */
+						0x1080 /* MX23_PAD_LCD_D08__LCD_D8 */
+						0x1090 /* MX23_PAD_LCD_D09__LCD_D9 */
+						0x10a0 /* MX23_PAD_LCD_D10__LCD_D10 */
+						0x10b0 /* MX23_PAD_LCD_D11__LCD_D11 */
+						0x10c0 /* MX23_PAD_LCD_D12__LCD_D12 */
+						0x10d0 /* MX23_PAD_LCD_D13__LCD_D13 */
+						0x10e0 /* MX23_PAD_LCD_D14__LCD_D14 */
+						0x10f0 /* MX23_PAD_LCD_D15__LCD_D15 */
+						0x1100 /* MX23_PAD_LCD_D16__LCD_D16 */
+						0x1110 /* MX23_PAD_LCD_D17__LCD_D17 */
+						0x0081 /* MX23_PAD_GPMI_D08__LCD_D18 */
+						0x0091 /* MX23_PAD_GPMI_D09__LCD_D19 */
+						0x00a1 /* MX23_PAD_GPMI_D10__LCD_D20 */
+						0x00b1 /* MX23_PAD_GPMI_D11__LCD_D21 */
+						0x00c1 /* MX23_PAD_GPMI_D12__LCD_D22 */
+						0x00d1 /* MX23_PAD_GPMI_D13__LCD_D23 */
+						0x1160 /* MX23_PAD_LCD_DOTCK__LCD_DOTCK */
+						0x1170 /* MX23_PAD_LCD_ENABLE__LCD_ENABLE */
+						0x1180 /* MX23_PAD_LCD_HSYNC__LCD_HSYNC */
+						0x1190 /* MX23_PAD_LCD_VSYNC__LCD_VSYNC */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -229,7 +266,9 @@
 			};
 
 			lcdif at 80030000 {
+				compatible = "fsl,imx23-lcdif";
 				reg = <0x80030000 2000>;
+				interrupts = <46 45>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index d4fa97e..66aa92d 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -66,6 +66,13 @@
 				};
 			};
 
+			lcdif at 80030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcdif_24bit_pins_a>;
+				panel-enable-gpios = <&gpio3 30 0>;
+				status = "okay";
+			};
+
 			can0: can at 80032000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can0_pins_a>;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2628513..936d1aa 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -396,6 +396,43 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				lcdif_24bit_pins_a: lcdif-24bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1000 /* MX28_PAD_LCD_D00__LCD_D0 */
+						0x1010 /* MX28_PAD_LCD_D01__LCD_D1 */
+						0x1020 /* MX28_PAD_LCD_D02__LCD_D2 */
+						0x1030 /* MX28_PAD_LCD_D03__LCD_D3 */
+						0x1040 /* MX28_PAD_LCD_D04__LCD_D4 */
+						0x1050 /* MX28_PAD_LCD_D05__LCD_D5 */
+						0x1060 /* MX28_PAD_LCD_D06__LCD_D6 */
+						0x1070 /* MX28_PAD_LCD_D07__LCD_D7 */
+						0x1080 /* MX28_PAD_LCD_D08__LCD_D8 */
+						0x1090 /* MX28_PAD_LCD_D09__LCD_D9 */
+						0x10a0 /* MX28_PAD_LCD_D10__LCD_D10 */
+						0x10b0 /* MX28_PAD_LCD_D11__LCD_D11 */
+						0x10c0 /* MX28_PAD_LCD_D12__LCD_D12 */
+						0x10d0 /* MX28_PAD_LCD_D13__LCD_D13 */
+						0x10e0 /* MX28_PAD_LCD_D14__LCD_D14 */
+						0x10f0 /* MX28_PAD_LCD_D15__LCD_D15 */
+						0x1100 /* MX28_PAD_LCD_D16__LCD_D16 */
+						0x1110 /* MX28_PAD_LCD_D17__LCD_D17 */
+						0x1120 /* MX28_PAD_LCD_D18__LCD_D18 */
+						0x1130 /* MX28_PAD_LCD_D19__LCD_D19 */
+						0x1140 /* MX28_PAD_LCD_D20__LCD_D20 */
+						0x1150 /* MX28_PAD_LCD_D21__LCD_D21 */
+						0x1160 /* MX28_PAD_LCD_D22__LCD_D22 */
+						0x1170 /* MX28_PAD_LCD_D23__LCD_D23 */
+						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
+						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
+						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
+						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -437,6 +474,7 @@
 			};
 
 			lcdif at 80030000 {
+				compatible = "fsl,imx28-lcdif";
 				reg = <0x80030000 2000>;
 				interrupts = <38 86>;
 				status = "disabled";
-- 
1.7.5.4
