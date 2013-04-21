From: marex@denx.de (Marek Vasut)
Date: Sun, 21 Apr 2013 23:30:05 +0200
Subject: [PATCH 5/8] ARM: mx5: Add NAND pinctrl data
In-Reply-To: <1366579808-12067-1-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
Message-ID: <1366579808-12067-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl data for NAND on MX53.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 09145e2..7574026 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -575,6 +575,27 @@
 					};
 				};
 
+				nand {
+					pinctrl_nand_1: nandgrp-1 {
+						fsl,pins = <
+							MX53_PAD_NANDF_WE_B__EMI_NANDF_WE_B	0x4
+							MX53_PAD_NANDF_RE_B__EMI_NANDF_RE_B	0x4
+							MX53_PAD_NANDF_CLE__EMI_NANDF_CLE	0x4
+							MX53_PAD_NANDF_ALE__EMI_NANDF_ALE	0x4
+							MX53_PAD_NANDF_WP_B__EMI_NANDF_WP_B	0xe0
+							MX53_PAD_NANDF_RB0__EMI_NANDF_RB_0	0xe0
+							MX53_PAD_NANDF_CS0__EMI_NANDF_CS_0	0x4
+							MX53_PAD_PATA_DATA0__EMI_NANDF_D_0	0xa4
+							MX53_PAD_PATA_DATA1__EMI_NANDF_D_1	0xa4
+							MX53_PAD_PATA_DATA2__EMI_NANDF_D_2	0xa4
+							MX53_PAD_PATA_DATA3__EMI_NANDF_D_3	0xa4
+							MX53_PAD_PATA_DATA4__EMI_NANDF_D_4	0xa4
+							MX53_PAD_PATA_DATA5__EMI_NANDF_D_5	0xa4
+							MX53_PAD_PATA_DATA6__EMI_NANDF_D_6	0xa4
+							MX53_PAD_PATA_DATA7__EMI_NANDF_D_7	0xa4
+						>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr at 53fa8000 {
-- 
1.7.10.4
