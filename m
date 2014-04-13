From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 Apr 2014 11:35:42 -0300
Subject: [PATCH v3 3/3] ARM: dts: imx27-pdk: Pass the FEC pin configuration
In-Reply-To: <1397399742-3577-1-git-send-email-festevam@gmail.com>
References: <1397399742-3577-1-git-send-email-festevam@gmail.com>
Message-ID: <1397399742-3577-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide an entry for the FEC pin muxing.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Keep iomux node sorted
Changes since v1:
- Keep the iomuxc node at the bottom
 arch/arm/boot/dts/imx27-pdk.dts | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index e0f4213..f6e9a72 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -23,6 +23,9 @@
 
 
 &fec {
+	phy-mode = "mii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
 	status = "okay";
 };
 
@@ -35,6 +38,29 @@
 
 &iomuxc {
 	imx27-pdk {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX27_PAD_SD3_CMD__FEC_TXD0 0x0
+				MX27_PAD_SD3_CLK__FEC_TXD1 0x0
+				MX27_PAD_ATA_DATA0__FEC_TXD2 0x0
+				MX27_PAD_ATA_DATA1__FEC_TXD3 0x0
+				MX27_PAD_ATA_DATA2__FEC_RX_ER 0x0
+				MX27_PAD_ATA_DATA3__FEC_RXD1 0x0
+				MX27_PAD_ATA_DATA4__FEC_RXD2 0x0
+				MX27_PAD_ATA_DATA5__FEC_RXD3 0x0
+				MX27_PAD_ATA_DATA6__FEC_MDIO 0x0
+				MX27_PAD_ATA_DATA7__FEC_MDC 0x0
+				MX27_PAD_ATA_DATA8__FEC_CRS 0x0
+				MX27_PAD_ATA_DATA9__FEC_TX_CLK 0x0
+				MX27_PAD_ATA_DATA10__FEC_RXD0 0x0
+				MX27_PAD_ATA_DATA11__FEC_RX_DV 0x0
+				MX27_PAD_ATA_DATA12__FEC_RX_CLK 0x0
+				MX27_PAD_ATA_DATA13__FEC_COL 0x0
+				MX27_PAD_ATA_DATA14__FEC_TX_ER 0x0
+				MX27_PAD_ATA_DATA15__FEC_TX_EN 0x0
+			>;
+		};
+	};
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX27_PAD_UART1_TXD__UART1_TXD 0x0
@@ -43,5 +69,4 @@
 				MX27_PAD_UART1_RTS__UART1_RTS 0x0
 			>;
 		};
-	};
 };
-- 
1.8.3.2
