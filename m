From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 11:12:28 +0200
Subject: [PATCH 2/4] ARM i.MX53: tqma53: fix pinctrl settings
In-Reply-To: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370337150-18487-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

BIT(31) is NO_PAD_CTL, not BIT(16)

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-tqma53.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 3b2eb7d..45a273b 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -72,11 +72,11 @@
 	i2s {
 		pinctrl_i2s_1: i2s-grp1 {
 			fsl,pins = <
-				 MX53_PAD_GPIO_19__GPIO4_5           0x10000 /* I2S_MCLK */
-				 MX53_PAD_KEY_COL0__AUDMUX_AUD5_TXC  0x10000 /* I2S_SCLK */
-				 MX53_PAD_KEY_ROW0__AUDMUX_AUD5_TXD  0x10000 /* I2S_DOUT */
-				 MX53_PAD_KEY_COL1__AUDMUX_AUD5_TXFS 0x10000 /* I2S_LRCLK */
-				 MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD  0x10000 /* I2S_DIN */
+				 MX53_PAD_GPIO_19__GPIO4_5           0x80000000 /* I2S_MCLK */
+				 MX53_PAD_KEY_COL0__AUDMUX_AUD5_TXC  0x80000000 /* I2S_SCLK */
+				 MX53_PAD_KEY_ROW0__AUDMUX_AUD5_TXD  0x80000000 /* I2S_DOUT */
+				 MX53_PAD_KEY_COL1__AUDMUX_AUD5_TXFS 0x80000000 /* I2S_LRCLK */
+				 MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD  0x80000000 /* I2S_DIN */
 			>;
 		};
 	};
@@ -84,16 +84,16 @@
 	hog {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				 MX53_PAD_EIM_CS1__IPU_DI1_PIN6  0x10000 /* VSYNC */
-				 MX53_PAD_EIM_DA15__IPU_DI1_PIN4 0x10000 /* HSYNC */
-				 MX53_PAD_PATA_DA_1__GPIO7_7     0x10000 /* LCD_BLT_EN */
-				 MX53_PAD_PATA_DA_2__GPIO7_8     0x10000 /* LCD_RESET */
-				 MX53_PAD_PATA_DATA5__GPIO2_5    0x10000 /* LCD_POWER */
-				 MX53_PAD_PATA_DATA6__GPIO2_6    0x10000 /* PMIC_INT */
-				 MX53_PAD_PATA_DATA14__GPIO2_14  0x10000 /* CSI_RST */
-				 MX53_PAD_PATA_DATA15__GPIO2_15  0x10000 /* CSI_PWDN */
-				 MX53_PAD_GPIO_0__GPIO1_0        0x10000 /* SYSTEM_DOWN */
-				 MX53_PAD_GPIO_3__GPIO1_3        0x10000
+				 MX53_PAD_EIM_CS1__IPU_DI1_PIN6  0x80000000 /* VSYNC */
+				 MX53_PAD_EIM_DA15__IPU_DI1_PIN4 0x80000000 /* HSYNC */
+				 MX53_PAD_PATA_DA_1__GPIO7_7     0x80000000 /* LCD_BLT_EN */
+				 MX53_PAD_PATA_DA_2__GPIO7_8     0x80000000 /* LCD_RESET */
+				 MX53_PAD_PATA_DATA5__GPIO2_5    0x80000000 /* LCD_POWER */
+				 MX53_PAD_PATA_DATA6__GPIO2_6    0x80000000 /* PMIC_INT */
+				 MX53_PAD_PATA_DATA14__GPIO2_14  0x80000000 /* CSI_RST */
+				 MX53_PAD_PATA_DATA15__GPIO2_15  0x80000000 /* CSI_PWDN */
+				 MX53_PAD_GPIO_0__GPIO1_0        0x80000000 /* SYSTEM_DOWN */
+				 MX53_PAD_GPIO_3__GPIO1_3        0x80000000
 			>;
 		};
 	};
-- 
1.8.2.rc2
