From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Jun 2013 15:02:57 +0200
Subject: [PATCHv3 8/8] ARM: mxs: dt: cfa10057: remove hogpins
In-Reply-To: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1372424577-8279-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Necessary pins are now grabbed by respective drivers. Unecessary hogpins are
simply removed.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10057.dts | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 2da713c..0333c05 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -23,35 +23,16 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
-				pinctrl-names = "default", "default";
-				pinctrl-1 = <&hog_pins_cfa10057
-					&hog_pins_cfa10057_pullup>;
-
-				hog_pins_cfa10057: hog-10057 at 0 {
+				usb_pins_cfa10057: usb-10057 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x0073 /* MX28_PAD_GPMI_D7__GPIO_0_7 */
-						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
 
-				hog_pins_cfa10057_pullup: hog-10057-pullup at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						0x2133 /* MX28_PAD_SSP2_D3__GPIO_2_19 */
-						0x3183 /* MX28_PAD_I2C0_SCL__GPIO_3_24 */
-						0x3193 /* MX28_PAD_I2C0_SDA__GPIO_3_25 */
-						0x31a3 /* MX28_PAD_SAIF_SDATA0__GPIO_3_26 */
-						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
-					>;
-					fsl,drive-strength = <0>;
-					fsl,voltage = <1>;
-					fsl,pull-up = <1>;
-				};
-
 				lcdif_18bit_pins_cfa10057: lcdif-18bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -164,6 +145,8 @@
 
 		reg_usb1_vbus: usb1_vbus {
 			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb_pins_cfa10057>;
 			regulator-name = "usb1_vbus";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
-- 
1.8.1.2
