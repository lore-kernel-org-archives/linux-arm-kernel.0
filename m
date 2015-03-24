From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Mar 2015 15:09:07 +0100
Subject: [PATCH 2/2] ARM: dts: imx25-karo-tx25: Fix pincontrol definition
In-Reply-To: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
References: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1427206147-19365-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iomux group nodes have to be in a pinmux category as described in
the devicetree binding documentation example. The current definitions
are not parsed by imx25-pinctrl.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts | 84 +++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 9b31faa96377..11344fb27727 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -42,49 +42,55 @@
 };
 
 &iomuxc {
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX25_PAD_UART1_TXD__UART1_TXD 0x80000000
-			MX25_PAD_UART1_RXD__UART1_RXD 0x80000000
-			MX25_PAD_UART1_CTS__UART1_CTS 0x80000000
-			MX25_PAD_UART1_RTS__UART1_RTS 0x80000000
-		>;
+	uart1 {
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX25_PAD_UART1_TXD__UART1_TXD 0x80000000
+				MX25_PAD_UART1_RXD__UART1_RXD 0x80000000
+				MX25_PAD_UART1_CTS__UART1_CTS 0x80000000
+				MX25_PAD_UART1_RTS__UART1_RTS 0x80000000
+			>;
+		};
 	};
 
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX25_PAD_D11__GPIO_4_9		0x80000000 /* FEC PHY power on pin */
-			MX25_PAD_D13__GPIO_4_7		0x80000000 /* FEC reset */
-			MX25_PAD_FEC_MDC__FEC_MDC	0x80000000
-			MX25_PAD_FEC_MDIO__FEC_MDIO	0x80000000
-			MX25_PAD_FEC_TDATA0__FEC_TDATA0	0x80000000
-			MX25_PAD_FEC_TDATA1__FEC_TDATA1	0x80000000
-			MX25_PAD_FEC_TX_EN__FEC_TX_EN	0x80000000
-			MX25_PAD_FEC_RDATA0__FEC_RDATA0	0x80000000
-			MX25_PAD_FEC_RDATA1__FEC_RDATA1	0x80000000
-			MX25_PAD_FEC_RX_DV__FEC_RX_DV	0x80000000
-			MX25_PAD_FEC_TX_CLK__FEC_TX_CLK	0x80000000
-		>;
+	fec {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX25_PAD_D11__GPIO_4_9		0x80000000 /* FEC PHY power on pin */
+				MX25_PAD_D13__GPIO_4_7		0x80000000 /* FEC reset */
+				MX25_PAD_FEC_MDC__FEC_MDC	0x80000000
+				MX25_PAD_FEC_MDIO__FEC_MDIO	0x80000000
+				MX25_PAD_FEC_TDATA0__FEC_TDATA0	0x80000000
+				MX25_PAD_FEC_TDATA1__FEC_TDATA1	0x80000000
+				MX25_PAD_FEC_TX_EN__FEC_TX_EN	0x80000000
+				MX25_PAD_FEC_RDATA0__FEC_RDATA0	0x80000000
+				MX25_PAD_FEC_RDATA1__FEC_RDATA1	0x80000000
+				MX25_PAD_FEC_RX_DV__FEC_RX_DV	0x80000000
+				MX25_PAD_FEC_TX_CLK__FEC_TX_CLK	0x80000000
+			>;
+		};
 	};
 
-	pinctrl_nfc: nfcgrp {
-		fsl,pins = <
-			MX25_PAD_NF_CE0__NF_CE0		0x80000000
-			MX25_PAD_NFWE_B__NFWE_B		0x80000000
-			MX25_PAD_NFRE_B__NFRE_B		0x80000000
-			MX25_PAD_NFALE__NFALE		0x80000000
-			MX25_PAD_NFCLE__NFCLE		0x80000000
-			MX25_PAD_NFWP_B__NFWP_B		0x80000000
-			MX25_PAD_NFRB__NFRB		0x80000000
-			MX25_PAD_D7__D7			0x80000000
-			MX25_PAD_D6__D6			0x80000000
-			MX25_PAD_D5__D5			0x80000000
-			MX25_PAD_D4__D4			0x80000000
-			MX25_PAD_D3__D3			0x80000000
-			MX25_PAD_D2__D2			0x80000000
-			MX25_PAD_D1__D1			0x80000000
-			MX25_PAD_D0__D0			0x80000000
-		>;
+	nfc {
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+				MX25_PAD_NF_CE0__NF_CE0		0x80000000
+				MX25_PAD_NFWE_B__NFWE_B		0x80000000
+				MX25_PAD_NFRE_B__NFRE_B		0x80000000
+				MX25_PAD_NFALE__NFALE		0x80000000
+				MX25_PAD_NFCLE__NFCLE		0x80000000
+				MX25_PAD_NFWP_B__NFWP_B		0x80000000
+				MX25_PAD_NFRB__NFRB		0x80000000
+				MX25_PAD_D7__D7			0x80000000
+				MX25_PAD_D6__D6			0x80000000
+				MX25_PAD_D5__D5			0x80000000
+				MX25_PAD_D4__D4			0x80000000
+				MX25_PAD_D3__D3			0x80000000
+				MX25_PAD_D2__D2			0x80000000
+				MX25_PAD_D1__D1			0x80000000
+				MX25_PAD_D0__D0			0x80000000
+			>;
+		};
 	};
 };
 
-- 
2.1.4
