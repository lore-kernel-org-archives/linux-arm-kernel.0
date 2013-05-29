From: c.hemp@phytec.de (Christian Hemp)
Date: Wed, 29 May 2013 23:06:48 +0200
Subject: [PATCH 1/2] ARM: dts: imx6q: Add pinctrl for usdhc2 and enet
In-Reply-To: <1369861609-30408-1-git-send-email-c.hemp@phytec.de>
References: <1369861609-30408-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1369861609-30408-2-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a group to the usdhc2 and enet pinctrl.

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6q.dtsi |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index ed11bcf..c0c8b7b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -157,6 +157,28 @@
 							MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 						>;
 					};
+
+					pinctrl_enet_3: enetgrp-3 {
+						fsl,pins = <
+							MX6Q_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+							MX6Q_PAD_ENET_MDC__ENET_MDC         0x1b0b0
+							MX6Q_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
+							MX6Q_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
+							MX6Q_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
+							MX6Q_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
+							MX6Q_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
+							MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+							MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
+							MX6Q_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
+							MX6Q_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
+							MX6Q_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
+							MX6Q_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
+							MX6Q_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
+							MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+							MX6Q_PAD_ENET_CRS_DV__SPDIF_EXT_CLK 0x1b0b0
+							MX6Q_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
+						>;
+					};
 				};
 
 				gpmi-nand {
@@ -266,6 +288,17 @@
 							MX6Q_PAD_NANDF_D7__SD2_DATA7 0x17059
 						>;
 					};
+
+					pinctrl_usdhc2_2: usdhc2grp-2 {
+						fsl,pins = <
+							MX6Q_PAD_SD2_CMD__SD2_CMD    0x17059
+							MX6Q_PAD_SD2_CLK__SD2_CLK    0x10059
+							MX6Q_PAD_SD2_DAT0__SD2_DATA0 0x17059
+							MX6Q_PAD_SD2_DAT1__SD2_DATA1 0x17059
+							MX6Q_PAD_SD2_DAT2__SD2_DATA2 0x17059
+							MX6Q_PAD_SD2_DAT3__SD2_DATA3 0x17059
+						>;
+					};
 				};
 
 				usdhc3 {
-- 
1.7.9.5
