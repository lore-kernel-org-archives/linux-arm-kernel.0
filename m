From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:56 +0200
Subject: [PATCH 6/10] ARM: dts: mxs: add pin config for LCD sync and clock pins
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375281480-25775-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index f597c0f..284166a9 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -648,6 +648,19 @@
 					fsl,pull-up = <0>;
 				};
 
+				lcdif_sync_pins_a: lcdif-sync at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
+						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
+						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
+						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				can0_pins_a: can0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.2.5
