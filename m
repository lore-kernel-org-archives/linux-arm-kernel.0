From: jonas@microbit.se (Jonas Andersson)
Date: Mon, 27 May 2013 10:52:54 +0200
Subject: [PATCH] ARM: dts: imx53: add fec pinctrl
Message-ID: <1369644774-17225-1-git-send-email-jonas@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a group to the fec pinctrl, for use with MII interface.

Signed-off-by: Jonas Andersson <jonas@microbit.se>
---
 arch/arm/boot/dts/imx53.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index dd59ace..d7d9270 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -284,6 +284,29 @@
 							MX53_PAD_FEC_TXD0__FEC_TDATA_0   0x80000000
 						>;
 					};
+
+					pinctrl_fec_2: fecgrp-2 {
+						fsl,pins = <
+							MX53_PAD_FEC_MDC__FEC_MDC	 0x80000000
+							MX53_PAD_FEC_MDIO__FEC_MDIO	 0x80000000
+							MX53_PAD_FEC_REF_CLK__FEC_TX_CLK 0x80000000
+							MX53_PAD_FEC_RX_ER__FEC_RX_ER    0x80000000
+							MX53_PAD_FEC_CRS_DV__FEC_RX_DV   0x80000000
+							MX53_PAD_FEC_RXD1__FEC_RDATA_1   0x80000000
+							MX53_PAD_FEC_RXD0__FEC_RDATA_0   0x80000000
+							MX53_PAD_FEC_TX_EN__FEC_TX_EN    0x80000000
+							MX53_PAD_FEC_TXD1__FEC_TDATA_1   0x80000000
+							MX53_PAD_FEC_TXD0__FEC_TDATA_0   0x80000000
+							MX53_PAD_KEY_ROW1__FEC_COL	 0x80000000
+							MX53_PAD_KEY_COL3__FEC_CRS	 0x80000000
+							MX53_PAD_KEY_COL2__FEC_RDATA_2	 0x80000000
+							MX53_PAD_KEY_COL0__FEC_RDATA_3	 0x80000000
+							MX53_PAD_KEY_COL1__FEC_RX_CLK	 0x80000000
+							MX53_PAD_KEY_ROW2__FEC_TDATA_2	 0x80000000
+							MX53_PAD_GPIO_19__FEC_TDATA_3	 0x80000000
+							MX53_PAD_KEY_ROW0__FEC_TX_ER	 0x80000000
+						>;
+					};
 				};
 
 				csi {
-- 
1.8.1.4
