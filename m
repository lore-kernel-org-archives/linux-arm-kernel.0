From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  9 Jan 2013 14:44:23 +0100
Subject: [PATCH 2/4] ARM: dts: imx53: pinctrl update
In-Reply-To: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1357739065-9153-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl for cspi, csi.
Add new pingroups for can1 and uart3.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |   53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 552aed4..160c24a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -274,6 +274,44 @@
 					};
 				};
 
+				csi {
+					pinctrl_csi_1: csigrp-1 {
+						fsl,pins = <
+							286 0x1d5	/* MX53_PAD_CSI0_DATA_EN__IPU_CSI0_DATA_EN */
+							291 0x1d5	/* MX53_PAD_CSI0_VSYNC__IPU_CSI0_VSYNC */
+							280 0x1d5	/* MX53_PAD_CSI0_MCLK__IPU_CSI0_HSYNC */
+							276 0x1d5	/* MX53_PAD_CSI0_PIXCLK__IPU_CSI0_PIXCLK */
+							409 0x1d5	/* MX53_PAD_CSI0_DAT19__IPU_CSI0_D_19 */
+							402 0x1d5	/* MX53_PAD_CSI0_DAT18__IPU_CSI0_D_18 */
+							395 0x1d5	/* MX53_PAD_CSI0_DAT17__IPU_CSI0_D_17 */
+							388 0x1d5	/* MX53_PAD_CSI0_DAT16__IPU_CSI0_D_16 */
+							381 0x1d5	/* MX53_PAD_CSI0_DAT15__IPU_CSI0_D_15 */
+							374 0x1d5	/* MX53_PAD_CSI0_DAT14__IPU_CSI0_D_14 */
+							367 0x1d5	/* MX53_PAD_CSI0_DAT13__IPU_CSI0_D_13 */
+							360 0x1d5	/* MX53_PAD_CSI0_DAT12__IPU_CSI0_D_12 */
+							352 0x1d5	/* MX53_PAD_CSI0_DAT11__IPU_CSI0_D_11 */
+							344 0x1d5	/* MX53_PAD_CSI0_DAT10__IPU_CSI0_D_10 */
+							336 0x1d5	/* MX53_PAD_CSI0_DAT9__IPU_CSI0_D_9 */
+							328 0x1d5	/* MX53_PAD_CSI0_DAT8__IPU_CSI0_D_8 */
+							320 0x1d5	/* MX53_PAD_CSI0_DAT7__IPU_CSI0_D_7 */
+							312 0x1d5	/* MX53_PAD_CSI0_DAT6__IPU_CSI0_D_6 */
+							304 0x1d5	/* MX53_PAD_CSI0_DAT5__IPU_CSI0_D_5 */
+							296 0x1d5	/* MX53_PAD_CSI0_DAT4__IPU_CSI0_D_4 */
+							276 0x1d5	/* MX53_PAD_CSI0_PIXCLK__IPU_CSI0_PIXCLK */
+						>;
+					};
+				};
+
+				cspi {
+					pinctrl_cspi_1: cspigrp-1 {
+						fsl,pins = <
+							998  0x1d5	/* MX53_PAD_SD1_DATA0__CSPI_MISO */
+							1008 0x1d5	/* MX53_PAD_SD1_CMD__CSPI_MOSI */
+							1022 0x1d5	/* MX53_PAD_SD1_CLK__CSPI_SCLK */
+						>;
+					};
+				};
+
 				ecspi1 {
 					pinctrl_ecspi1_1: ecspi1grp-1 {
 						fsl,pins = <
@@ -349,6 +387,13 @@
 							853 0x80000000  /* MX53_PAD_PATA_DIOR__CAN1_RXCAN */
 						>;
 					};
+
+					pinctrl_can1_2: can1grp-2 {
+						fsl,pins = <
+							37  0x80000000  /* MX53_PAD_KEY_COL2__CAN1_TXCAN */
+							44  0x80000000  /* MX53_PAD_KEY_ROW2__CAN1_RXCAN */
+						>;
+					};
 				};
 
 				can2 {
@@ -421,6 +466,14 @@
 							880 0x1c5	/* MX53_PAD_PATA_DA_2__UART3_RTS */
 						>;
 					};
+
+					pinctrl_uart3_2: uart3grp-2 {
+						fsl,pins = <
+							884 0x1c5	/* MX53_PAD_PATA_CS_0__UART3_TXD_MUX */
+							888 0x1c5	/* MX53_PAD_PATA_CS_1__UART3_RXD_MUX */
+						>;
+					};
+
 				};
 
 				uart4 {
-- 
1.7.10.4
