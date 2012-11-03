From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  3 Nov 2012 16:59:08 +0100
Subject: [PATCH 2/2] ARM: dts: mxs: Add hog pins to Crystalfontz boards
In-Reply-To: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1351958348-7327-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a hog_pins pinctrl group to force the muxing of GPIOs used on the
Crystalfonz CFA10036 and CFA10049 boards.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts |   13 +++++++++++++
 arch/arm/boot/dts/imx28-cfa10049.dts |   16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index 8760b87..1594694 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -23,6 +23,19 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_cfa10036>;
+
+				hog_pins_cfa10036: hog-10036 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2073 /* MX28_PAD_SSP0_D7__GPIO_2_7 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				led_pins_cfa10036: leds-10036 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 6c4c071..bdc80a4 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -22,6 +22,22 @@
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl@80018000 {
+				pinctrl-names = "default", "default";
+				pinctrl-1 = <&hog_pins_cfa10049>;
+
+				hog_pins_cfa10049: hog-10049 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0073 /* MX28_PAD_GPMI_D7__GPIO_0_7 */
+						0x1163 /* MX28_PAD_LCD_D22__GPIO_1_22 */
+						0x1173 /* MX28_PAD_LCD_D22__GPIO_1_23 */
+						0x2153 /* MX28_PAD_SSP2_D5__GPIO_2_21 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				spi3_pins_cfa10049: spi3-cfa10049 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5
