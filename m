From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Apr 2014 15:23:30 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx27-pdk: Add NAND support
Message-ID: <1397759011-6717-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add NAND pins

 arch/arm/boot/dts/imx27-pdk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 971961f..042d7ff 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -84,6 +84,14 @@
 	status = "okay";
 };
 
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nand>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
 &uart1 {
 	fsl,uart-has-rtscts;
 	pinctrl-names = "default";
@@ -135,6 +143,18 @@
 			>;
 		};
 
+		pinctrl_nand: nandgrp {
+			fsl,pins = <
+				MX27_PAD_NFRB__NFRB	0x0
+				MX27_PAD_NFCLE__NFCLE	0x0
+				MX27_PAD_NFWP_B__NFWP_B	0x0
+				MX27_PAD_NFCE_B__NFCE_B	0x0
+				MX27_PAD_NFALE__NFALE	0x0
+				MX27_PAD_NFRE_B__NFRE_B	0x0
+				MX27_PAD_NFWE_B__NFWE_B	0x0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX27_PAD_UART1_TXD__UART1_TXD 0x0
-- 
1.8.3.2
