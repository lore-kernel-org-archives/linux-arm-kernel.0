From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri,  2 Nov 2012 19:01:47 +0100
Subject: [PATCH 1/2] ARM: mxs: apf28dev: Add pinctrl and gpios
Message-ID: <1351879308-72491-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index dde09d4..8e765ae 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -26,6 +26,27 @@
 				bus-width = <4>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_apf28dev>;
+
+				hog_pins_apf28dev: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1103 /* MX28_PAD_LCD_D16__GPIO_1_16 */
+						0x1113 /* MX28_PAD_LCD_D17__GPIO_1_17 */
+						0x1123 /* MX28_PAD_LCD_D18__GPIO_1_18 */
+						0x1133 /* MX28_PAD_LCD_D19__GPIO_1_19 */
+						0x1143 /* MX28_PAD_LCD_D20__GPIO_1_20 */
+						0x1153 /* MX28_PAD_LCD_D21__GPIO_1_21 */
+						0x1163 /* MX28_PAD_LCD_D22__GPIO_1_22 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
 		};
 
 		apbx at 80040000 {
-- 
1.7.8.6
