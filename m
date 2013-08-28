From: alison_chaiken@mentor.com (alison_chaiken at mentor.com)
Date: Tue, 27 Aug 2013 20:17:34 -0700
Subject: [PATCH 1/2] ARM: i.MX6: dts: change iomuxc pinctrl config to match
 Rev. 1 IMX6DQRM
In-Reply-To: <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
References: <521C40D9.3070802@freescale.com>
 <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
Message-ID: <1377659855-9573-2-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Update imx6.dtsi iomuxc pinctrl config settings to reflect Table 4-1 of Rev. 1
(4/2013) of IMX6DQRM, i.MX6 technical reference manual.

Impact:
USDHC: increase drive speed and impedance.
I2C and EIM: change drive impedance and disable open-drain.
ECSPI: change drive impedance.
ESAI and ENET: probably pedantic changes.

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 354 ++++++++++++++++++++---------------------
 arch/arm/boot/dts/imx6sl.dtsi  |  48 +++---
 2 files changed, 201 insertions(+), 201 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccd55c2..b1285c3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -611,17 +611,17 @@
 				ecspi1 {
 					pinctrl_ecspi1_1: ecspi1grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
-							MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
-							MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
+							MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x1b0b0
+							MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0x1b0b0
+							MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0x1b0b0
 						>;
 					};
 
 					pinctrl_ecspi1_2: ecspi1grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
-							MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
-							MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
+							MX6QDL_PAD_KEY_COL1__ECSPI1_MISO 0x1b0b0
+							MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI 0x1b0b0
+							MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK 0x1b0b0
 						>;
 					};
 				};
@@ -629,9 +629,9 @@
 				ecspi3 {
 					pinctrl_ecspi3_1: ecspi3grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO 0x100b1
-							MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI 0x100b1
-							MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK 0x100b1
+							MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO 0x1b0b0
+							MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI 0x1b0b0
+							MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK 0x1b0b0
 						>;
 					};
 				};
@@ -641,19 +641,19 @@
 						fsl,pins = <
 							MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
 							MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x13030
+							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
+							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
+							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
+							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
+							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
 							MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x13030
+							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
+							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
+							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
+							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
+							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
 							MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
 						>;
 					};
@@ -662,19 +662,19 @@
 						fsl,pins = <
 							MX6QDL_PAD_KEY_COL1__ENET_MDIO        0x1b0b0
 							MX6QDL_PAD_KEY_COL2__ENET_MDC         0x1b0b0
-							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x13030
+							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
+							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
+							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
+							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
+							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
 							MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x13030
+							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
+							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
+							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
+							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
+							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
 						>;
 					};
 
@@ -682,19 +682,19 @@
 						fsl,pins = <
 							MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
 							MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x13030
+							MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
+							MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
+							MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
+							MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
+							MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x13030
 							MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+							MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x13030
+							MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
+							MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
+							MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
+							MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
+							MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x13030
 							MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
 						>;
 					};
@@ -703,30 +703,30 @@
 				esai {
 					pinctrl_esai_1: esaigrp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK 0x1b030
-							MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK  0x1b030
-							MX6QDL_PAD_ENET_RXD1__ESAI_TX_FS     0x1b030
-							MX6QDL_PAD_ENET_TX_EN__ESAI_TX3_RX2  0x1b030
-							MX6QDL_PAD_ENET_TXD1__ESAI_TX2_RX3   0x1b030
-							MX6QDL_PAD_ENET_TXD0__ESAI_TX4_RX1   0x1b030
-							MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0    0x1b030
-							MX6QDL_PAD_NANDF_CS2__ESAI_TX0       0x1b030
-							MX6QDL_PAD_NANDF_CS3__ESAI_TX1       0x1b030
+							MX6QDL_PAD_ENET_RXD0__ESAI_TX_HF_CLK 0x1b0b0
+							MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK  0x1b0b0
+							MX6QDL_PAD_ENET_RXD1__ESAI_TX_FS     0x1b0b0
+							MX6QDL_PAD_ENET_TX_EN__ESAI_TX3_RX2  0x1b0b0
+							MX6QDL_PAD_ENET_TXD1__ESAI_TX2_RX3   0x1b0b0
+							MX6QDL_PAD_ENET_TXD0__ESAI_TX4_RX1   0x1b0b0
+							MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0    0x1b0b0
+							MX6QDL_PAD_NANDF_CS2__ESAI_TX0       0x1b0b0
+							MX6QDL_PAD_NANDF_CS3__ESAI_TX1       0x1b0b0
 						>;
 					};
 
 					pinctrl_esai_2: esaigrp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK 0x1b030
-							MX6QDL_PAD_ENET_RXD1__ESAI_TX_FS    0x1b030
-							MX6QDL_PAD_ENET_TX_EN__ESAI_TX3_RX2 0x1b030
-							MX6QDL_PAD_GPIO_5__ESAI_TX2_RX3     0x1b030
-							MX6QDL_PAD_ENET_TXD0__ESAI_TX4_RX1  0x1b030
-							MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0   0x1b030
-							MX6QDL_PAD_GPIO_17__ESAI_TX0        0x1b030
-							MX6QDL_PAD_NANDF_CS3__ESAI_TX1      0x1b030
-							MX6QDL_PAD_ENET_MDIO__ESAI_RX_CLK   0x1b030
-							MX6QDL_PAD_GPIO_9__ESAI_RX_FS       0x1b030
+							MX6QDL_PAD_ENET_CRS_DV__ESAI_TX_CLK 0x1b0b0
+							MX6QDL_PAD_ENET_RXD1__ESAI_TX_FS    0x1b0b0
+							MX6QDL_PAD_ENET_TX_EN__ESAI_TX3_RX2 0x1b0b0
+							MX6QDL_PAD_GPIO_5__ESAI_TX2_RX3     0x1b0b0
+							MX6QDL_PAD_ENET_TXD0__ESAI_TX4_RX1  0x1b0b0
+							MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0   0x1b0b0
+							MX6QDL_PAD_GPIO_17__ESAI_TX0        0x1b0b0
+							MX6QDL_PAD_NANDF_CS3__ESAI_TX1      0x1b0b0
+							MX6QDL_PAD_ENET_MDIO__ESAI_RX_CLK   0x1b0b0
+							MX6QDL_PAD_GPIO_9__ESAI_RX_FS       0x1b0b0
 						>;
 					};
 				};
@@ -759,23 +759,23 @@
 				gpmi-nand {
 					pinctrl_gpmi_nand_1: gpmi-nand-1 {
 						fsl,pins = <
-							MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
-							MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
-							MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
-							MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
-							MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
-							MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
-							MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
-							MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
-							MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
-							MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
-							MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
-							MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
-							MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
-							MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
-							MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
-							MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
-							MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+							MX6QDL_PAD_NANDF_CLE__NAND_CLE     0x1b0b0
+							MX6QDL_PAD_NANDF_ALE__NAND_ALE     0x1b0b0
+							MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0x1b0b0
+							MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0x1b0b0
+							MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0x1b0b0
+							MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0x1b0b0
+							MX6QDL_PAD_SD4_CMD__NAND_RE_B      0x1b0b0
+							MX6QDL_PAD_SD4_CLK__NAND_WE_B      0x1b0b0
+							MX6QDL_PAD_NANDF_D0__NAND_DATA00   0x1b0b0
+							MX6QDL_PAD_NANDF_D1__NAND_DATA01   0x1b0b0
+							MX6QDL_PAD_NANDF_D2__NAND_DATA02   0x1b0b0
+							MX6QDL_PAD_NANDF_D3__NAND_DATA03   0x1b0b0
+							MX6QDL_PAD_NANDF_D4__NAND_DATA04   0x1b0b0
+							MX6QDL_PAD_NANDF_D5__NAND_DATA05   0x1b0b0
+							MX6QDL_PAD_NANDF_D6__NAND_DATA06   0x1b0b0
+							MX6QDL_PAD_NANDF_D7__NAND_DATA07   0x1b0b0
+							MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x1b0b0
 						>;
 					};
 				};
@@ -820,15 +820,15 @@
 				i2c1 {
 					pinctrl_i2c1_1: i2c1grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-							MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+							MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b0b0
+							MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c1_2: i2c1grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-							MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+							MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b0b0
+							MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b0b0
 						>;
 					};
 				};
@@ -836,22 +836,22 @@
 				i2c2 {
 					pinctrl_i2c2_1: i2c2grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
-							MX6QDL_PAD_EIM_D16__I2C2_SDA 0x4001b8b1
+							MX6QDL_PAD_EIM_EB2__I2C2_SCL 0x4001b0b0
+							MX6QDL_PAD_EIM_D16__I2C2_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c2_2: i2c2grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-							MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+							MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b0b0
+							MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c2_3: i2c2grp-3 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_EB2__I2C2_SCL  0x4001b8b1
-							MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+							MX6QDL_PAD_EIM_EB2__I2C2_SCL  0x4001b0b0
+							MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b0b0
 						>;
 					};
 				};
@@ -859,29 +859,29 @@
 				i2c3 {
 					pinctrl_i2c3_1: i2c3grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
-							MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+							MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b0b0
+							MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c3_2: i2c3grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b8b1
-							MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
+							MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b0b0
+							MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c3_3: i2c3grp-3 {
 						fsl,pins = <
-							MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
-							MX6QDL_PAD_GPIO_16__I2C3_SDA 0x4001b8b1
+							MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b0b0
+							MX6QDL_PAD_GPIO_16__I2C3_SDA 0x4001b0b0
 						>;
 					};
 
 					pinctrl_i2c3_4: i2c3grp-4 {
 						fsl,pins = <
-							MX6QDL_PAD_GPIO_3__I2C3_SCL  0x4001b8b1
-							MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+							MX6QDL_PAD_GPIO_3__I2C3_SCL  0x4001b0b0
+							MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b0b0
 						>;
 					};
 				};
@@ -1015,8 +1015,8 @@
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
-							MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+							MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b0
+							MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b0
 						>;
 					};
 				};
@@ -1024,15 +1024,15 @@
 				uart2 {
 					pinctrl_uart2_1: uart2grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
-							MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
+							MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b0
+							MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b0
 						>;
 					};
 
 					pinctrl_uart2_2: uart2grp-2 { /* DTE mode */
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D26__UART2_RX_DATA   0x1b0b1
-							MX6QDL_PAD_EIM_D27__UART2_TX_DATA   0x1b0b1
+							MX6QDL_PAD_EIM_D26__UART2_RX_DATA   0x1b0b0
+							MX6QDL_PAD_EIM_D27__UART2_TX_DATA   0x1b0b0
 							MX6QDL_PAD_EIM_D28__UART2_DTE_CTS_B 0x1b0b1
 							MX6QDL_PAD_EIM_D29__UART2_DTE_RTS_B 0x1b0b1
 						>;
@@ -1042,8 +1042,8 @@
 				uart3 {
 					pinctrl_uart3_1: uart3grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b1
-							MX6QDL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b1
+							MX6QDL_PAD_SD4_CLK__UART3_RX_DATA 0x1b0b0
+							MX6QDL_PAD_SD4_CMD__UART3_TX_DATA 0x1b0b0
 							MX6QDL_PAD_EIM_D30__UART3_CTS_B   0x1b0b1
 							MX6QDL_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
 						>;
@@ -1051,8 +1051,8 @@
 
 					pinctrl_uart3_2: uart3grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
-							MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
+							MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b0
+							MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b0
 							MX6QDL_PAD_EIM_D23__UART3_CTS_B	  0x1b0b1
 							MX6QDL_PAD_EIM_EB3__UART3_RTS_B	  0x1b0b1
 						>;
@@ -1062,8 +1062,8 @@
 				uart4 {
 					pinctrl_uart4_1: uart4grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-							MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+							MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b0
+							MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b0
 						>;
 					};
 				};
@@ -1071,13 +1071,13 @@
 				usbotg {
 					pinctrl_usbotg_1: usbotggrp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+							MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x1b0b0
 						>;
 					};
 
 					pinctrl_usbotg_2: usbotggrp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+							MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x1b0b0
 						>;
 					};
 				};
@@ -1115,27 +1115,27 @@
 				usdhc1 {
 					pinctrl_usdhc1_1: usdhc1grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
-							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
-							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
-							MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
-							MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
-							MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
-							MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17059
+							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x1b0b0
+							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x1b0b0
+							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x1b0b0
+							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x1b0b0
+							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x1b0b0
+							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x1b0b0
+							MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x1b0b0
+							MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x1b0b0
+							MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x1b0b0
+							MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x1b0b0
 						>;
 					};
 
 					pinctrl_usdhc1_2: usdhc1grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
-							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
-							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x1b0b0
+							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x1b0b0
+							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x1b0b0
+							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x1b0b0
+							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x1b0b0
+							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x1b0b0
 						>;
 					};
 				};
@@ -1143,27 +1143,27 @@
 				usdhc2 {
 					pinctrl_usdhc2_1: usdhc2grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
-							MX6QDL_PAD_NANDF_D4__SD2_DATA4 0x17059
-							MX6QDL_PAD_NANDF_D5__SD2_DATA5 0x17059
-							MX6QDL_PAD_NANDF_D6__SD2_DATA6 0x17059
-							MX6QDL_PAD_NANDF_D7__SD2_DATA7 0x17059
+							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x1b0b0
+							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x1b0b0
+							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
+							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
+							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
+							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
+							MX6QDL_PAD_NANDF_D4__SD2_DATA4 0x1b0b0
+							MX6QDL_PAD_NANDF_D5__SD2_DATA5 0x1b0b0
+							MX6QDL_PAD_NANDF_D6__SD2_DATA6 0x1b0b0
+							MX6QDL_PAD_NANDF_D7__SD2_DATA7 0x1b0b0
 						>;
 					};
 
 					pinctrl_usdhc2_2: usdhc2grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+							MX6QDL_PAD_SD2_CMD__SD2_CMD    0x1b0b0
+							MX6QDL_PAD_SD2_CLK__SD2_CLK    0x1b0b0
+							MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
+							MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
+							MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
+							MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
 						>;
 					};
 				};
@@ -1171,27 +1171,27 @@
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
-							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
-							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
-							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
-							MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
+							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x1b0b0
+							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
+							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
+							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
+							MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x1b0b0
+							MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x1b0b0
+							MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x1b0b0
+							MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x1b0b0
 						>;
 					};
 
 					pinctrl_usdhc3_2: usdhc3grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+							MX6QDL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
+							MX6QDL_PAD_SD3_CLK__SD3_CLK    0x1b0b0
+							MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
+							MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
+							MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
+							MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
 						>;
 					};
 				};
@@ -1199,27 +1199,27 @@
 				usdhc4 {
 					pinctrl_usdhc4_1: usdhc4grp-1 {
 						fsl,pins = <
-							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
-							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10059
-							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
-							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
-							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
-							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
-							MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17059
-							MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17059
-							MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17059
-							MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17059
+							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x1b0b0
+							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x1b0b0
+							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x1b0b0
+							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x1b0b0
+							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x1b0b0
+							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x1b0b0
+							MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x1b0b0
+							MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x1b0b0
+							MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x1b0b0
+							MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x1b0b0
 						>;
 					};
 
 					pinctrl_usdhc4_2: usdhc4grp-2 {
 						fsl,pins = <
-							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17059
-							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10059
-							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17059
-							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17059
-							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17059
-							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17059
+							MX6QDL_PAD_SD4_CMD__SD4_CMD    0x1b0b0
+							MX6QDL_PAD_SD4_CLK__SD4_CLK    0x1b0b0
+							MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x1b0b0
+							MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x1b0b0
+							MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x1b0b0
+							MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x1b0b0
 						>;
 					};
 				};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..946402d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -551,8 +551,8 @@
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-							MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
-							MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+							MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b0
+							MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b0
 						>;
 					};
 				};
@@ -560,16 +560,16 @@
 				usdhc1 {
 					pinctrl_usdhc1_1: usdhc1grp-1 {
 						fsl,pins = <
-							MX6SL_PAD_SD1_CMD__SD1_CMD    0x17059
-							MX6SL_PAD_SD1_CLK__SD1_CLK    0x10059
-							MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-							MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-							MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-							MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x17059
-							MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x17059
-							MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x17059
-							MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x17059
-							MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x17059
+							MX6SL_PAD_SD1_CMD__SD1_CMD    0x1b0b0
+							MX6SL_PAD_SD1_CLK__SD1_CLK    0x1b0b0
+							MX6SL_PAD_SD1_DAT0__SD1_DATA0 0x1b0b0
+							MX6SL_PAD_SD1_DAT1__SD1_DATA1 0x1b0b0
+							MX6SL_PAD_SD1_DAT2__SD1_DATA2 0x1b0b0
+							MX6SL_PAD_SD1_DAT3__SD1_DATA3 0x1b0b0
+							MX6SL_PAD_SD1_DAT4__SD1_DATA4 0x1b0b0
+							MX6SL_PAD_SD1_DAT5__SD1_DATA5 0x1b0b0
+							MX6SL_PAD_SD1_DAT6__SD1_DATA6 0x1b0b0
+							MX6SL_PAD_SD1_DAT7__SD1_DATA7 0x1b0b0
 						>;
 					};
 				};
@@ -577,12 +577,12 @@
 				usdhc2 {
 					pinctrl_usdhc2_1: usdhc2grp-1 {
 						fsl,pins = <
-							MX6SL_PAD_SD2_CMD__SD2_CMD    0x17059
-							MX6SL_PAD_SD2_CLK__SD2_CLK    0x10059
-							MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-							MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-							MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-							MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+							MX6SL_PAD_SD2_CMD__SD2_CMD    0x1b0b0
+							MX6SL_PAD_SD2_CLK__SD2_CLK    0x1b0b0
+							MX6SL_PAD_SD2_DAT0__SD2_DATA0 0x1b0b0
+							MX6SL_PAD_SD2_DAT1__SD2_DATA1 0x1b0b0
+							MX6SL_PAD_SD2_DAT2__SD2_DATA2 0x1b0b0
+							MX6SL_PAD_SD2_DAT3__SD2_DATA3 0x1b0b0
 						>;
 					};
 				};
@@ -590,12 +590,12 @@
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <
-							MX6SL_PAD_SD3_CMD__SD3_CMD    0x17059
-							MX6SL_PAD_SD3_CLK__SD3_CLK    0x10059
-							MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-							MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-							MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-							MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+							MX6SL_PAD_SD3_CMD__SD3_CMD    0x1b0b0
+							MX6SL_PAD_SD3_CLK__SD3_CLK    0x1b0b0
+							MX6SL_PAD_SD3_DAT0__SD3_DATA0 0x1b0b0
+							MX6SL_PAD_SD3_DAT1__SD3_DATA1 0x1b0b0
+							MX6SL_PAD_SD3_DAT2__SD3_DATA2 0x1b0b0
+							MX6SL_PAD_SD3_DAT3__SD3_DATA3 0x1b0b0
 						>;
 					};
 				};
-- 
1.8.4
