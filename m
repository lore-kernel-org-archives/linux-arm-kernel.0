From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:25 +0800
Subject: [PATCH 05/17] ARM: dts: imx6q-arm2: add pinctrl for uart and enet
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinctrl of uart and enet for imx6q-arm2 board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-arm2.dts |   21 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi     |   29 +++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index d792581..15df4c1 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -28,8 +28,27 @@
 			status = "disabled"; /* gpmi nand conflicts with SD */
 		};
 
+		aips-bus at 02000000 { /* AIPS1 */
+			iomuxc at 020e0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							176  0x80000000	/* MX6Q_PAD_EIM_D25__GPIO_3_25 */
+							1363 0x80000000	/* MX6Q_PAD_NANDF_CS0__GPIO_6_11 */
+							1369 0x80000000 /* MX6Q_PAD_NANDF_CS1__GPIO_6_14 */
+						>;
+					};
+				};
+			};
+		};
+
 		aips-bus at 02100000 { /* AIPS2 */
 			ethernet at 02188000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_enet_2>;
 				phy-mode = "rgmii";
 				status = "okay";
 			};
@@ -52,6 +71,8 @@
 			};
 
 			uart4: serial at 021f0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart4_1>;
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 6bdfeea..23d680a 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -545,6 +545,26 @@
 							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
 						>;
 					};
+
+					pinctrl_enet_2: enetgrp-2 {
+						fsl,pins = <
+							890 0x1b0b0	/* MX6Q_PAD_KEY_COL1__ENET_MDIO */
+							909 0x1b0b0	/* MX6Q_PAD_KEY_COL2__ENET_MDC */
+							24  0x1b0b0	/* MX6Q_PAD_RGMII_TXC__ENET_RGMII_TXC */
+							30  0x1b0b0	/* MX6Q_PAD_RGMII_TD0__ENET_RGMII_TD0 */
+							34  0x1b0b0	/* MX6Q_PAD_RGMII_TD1__ENET_RGMII_TD1 */
+							39  0x1b0b0	/* MX6Q_PAD_RGMII_TD2__ENET_RGMII_TD2 */
+							44  0x1b0b0	/* MX6Q_PAD_RGMII_TD3__ENET_RGMII_TD3 */
+							56  0x1b0b0	/* MX6Q_PAD_RGMII_TX_CTL__RGMII_TX_CTL */
+							702 0x1b0b0	/* MX6Q_PAD_ENET_REF_CLK__ENET_TX_CLK */
+							74  0x1b0b0	/* MX6Q_PAD_RGMII_RXC__ENET_RGMII_RXC */
+							52  0x1b0b0	/* MX6Q_PAD_RGMII_RD0__ENET_RGMII_RD0 */
+							61  0x1b0b0	/* MX6Q_PAD_RGMII_RD1__ENET_RGMII_RD1 */
+							66  0x1b0b0	/* MX6Q_PAD_RGMII_RD2__ENET_RGMII_RD2 */
+							70  0x1b0b0	/* MX6Q_PAD_RGMII_RD3__ENET_RGMII_RD3 */
+							48  0x1b0b0	/* MX6Q_PAD_RGMII_RX_CTL__RGMII_RX_CTL */
+						>;
+					};
 				};
 
 				gpmi-nand {
@@ -591,6 +611,15 @@
 					};
 				};
 
+				uart4 {
+					pinctrl_uart4_1: uart4grp-1 {
+						fsl,pins = <
+							877 0x1b0b1	/* MX6Q_PAD_KEY_COL0__UART4_TXD */
+							885 0x1b0b1	/* MX6Q_PAD_KEY_ROW0__UART4_RXD */
+						>;
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <
-- 
1.7.5.4
