From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Tue, 7 Jun 2016 19:14:15 +0200
Subject: [PATCH v3 1/4] ARM: dts: imx6q-cm-fx6: remove iomuxc container node
Message-ID: <3b1f9cd8f7804e7da7e093b4661441d4@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

The imx6q-cm-fx6 iomuxc container node is not required. Remove it.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

Notes:
    Changes since v2:
     - add Igor's Acked-By
    
    Changes since v1:
     - this is a new patch in v2 required to address the iomuxc review
       comments of v1 (remove container nodes to reduce indentation)

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 94 +++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 99b46f8..21c513f 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -47,56 +47,54 @@
 };
 
 &iomuxc {
-	imx6q-cm-fx6 {
-		pinctrl_enet: enetgrp {
-			fsl,pins = <
-				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
-				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
-				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
-				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
-				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
-				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
-				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
-				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
-				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
-				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
-				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
-				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
-				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
-			>;
-		};
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+		>;
+	};
 
-		pinctrl_gpmi_nand: gpminandgrp {
-			fsl,pins = <
-				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
-				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
-				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
-				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
-				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
-				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
-				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
-				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
-				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
-				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
-				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
-				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
-				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
-				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
-				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
-				MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
-			>;
-		};
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
+		>;
+	};
 
-		pinctrl_uart4: uart4grp {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
-				MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
-			>;
-		};
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
+		>;
 	};
 };
 
-- 
2.8.3
