From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 13:36:22 +0800
Subject: [PATCH v2 2/7] ARM: dts: imx28: move lcdif control pins into board dts
In-Reply-To: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341898587-8462-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The presence and muxing of lcdif control pins can vary much on different
boards.  Move them into imx28-evk.dts to make lcdif_24bit_pins_a only
about data pins, so that it can be reused by other boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   16 +++++++++++++++-
 arch/arm/boot/dts/imx28.dtsi    |    4 ----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 0444964..0fcc7ea 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -76,11 +76,25 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				lcdif_pins_evk: lcdif-evk at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
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
 
 			lcdif at 80030000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&lcdif_24bit_pins_a>;
+				pinctrl-0 = <&lcdif_24bit_pins_a
+					     &lcdif_pins_evk>;
 				panel-enable-gpios = <&gpio3 30 0>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2874adc..02e778b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -400,10 +400,6 @@
 						0x1150 /* MX28_PAD_LCD_D21__LCD_D21 */
 						0x1160 /* MX28_PAD_LCD_D22__LCD_D22 */
 						0x1170 /* MX28_PAD_LCD_D23__LCD_D23 */
-						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
-						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
-						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
-						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
-- 
1.7.5.4
