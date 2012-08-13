From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:24 +0800
Subject: [PATCH 04/17] ARM: dts: imx6q-sabrelite: add pinctrl for usdhc and
 enet
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pinctrl of usdhc and enet for imx6q-sabrelite board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   15 +++++++++-
 arch/arm/boot/dts/imx6q.dtsi          |   44 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 1a99257..6d8f68d 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -51,8 +51,13 @@
 				gpios {
 					pinctrl_gpio_hog: gpiohog {
 						fsl,pins = <
-							144 0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
-							121 0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
+							1450 0x80000000	/* MX6Q_PAD_NANDF_D6__GPIO_2_6 */
+							1458 0x80000000	/* MX6Q_PAD_NANDF_D7__GPIO_2_7 */
+							121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
+							144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
+							152  0x80000000	/* MX6Q_PAD_EIM_D23__GPIO_3_23 */
+							1262 0x80000000 /* MX6Q_PAD_SD3_DAT5__GPIO_7_0 */
+							1270 0x1f0b0	/* MX6Q_PAD_SD3_DAT4__GPIO_7_1 */
 						>;
 					};
 				};
@@ -70,12 +75,16 @@
 			};
 
 			ethernet at 02188000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_enet_1>;
 				phy-mode = "rgmii";
 				phy-reset-gpios = <&gpio3 23 0>;
 				status = "okay";
 			};
 
 			usdhc at 02198000 { /* uSDHC3 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc3_2>;
 				cd-gpios = <&gpio7 0 0>;
 				wp-gpios = <&gpio7 1 0>;
 				vmmc-supply = <&reg_3p3v>;
@@ -83,6 +92,8 @@
 			};
 
 			usdhc at 0219c000 { /* uSDHC4 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc4_2>;
 				cd-gpios = <&gpio2 6 0>;
 				wp-gpios = <&gpio2 7 0>;
 				vmmc-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e8595fa..6bdfeea 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -525,6 +525,28 @@
 					};
 				};
 
+				enet {
+					pinctrl_enet_1: enetgrp-1 {
+						fsl,pins = <
+							695 0x1b0b0	/* MX6Q_PAD_ENET_MDIO__ENET_MDIO */
+							756 0x1b0b0	/* MX6Q_PAD_ENET_MDC__ENET_MDC */
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
+				};
+
 				gpmi-nand {
 					pinctrl_gpmi_nand_1: gpmi-nand-1 {
 						fsl,pins = <
@@ -584,6 +606,17 @@
 							1241 0x17059	/* MX6Q_PAD_SD3_DAT7__USDHC3_DAT7 */
 						>;
 					};
+
+					pinctrl_usdhc3_2: usdhc3grp-2 {
+						fsl,pins = <
+							1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
+							1281 0x10059	/* MX6Q_PAD_SD3_CLK__USDHC3_CLK	*/
+							1289 0x17059	/* MX6Q_PAD_SD3_DAT0__USDHC3_DAT0 */
+							1297 0x17059	/* MX6Q_PAD_SD3_DAT1__USDHC3_DAT1 */
+							1305 0x17059	/* MX6Q_PAD_SD3_DAT2__USDHC3_DAT2 */
+							1312 0x17059	/* MX6Q_PAD_SD3_DAT3__USDHC3_DAT3 */
+						>;
+					};
 				};
 
 				usdhc4 {
@@ -601,6 +634,17 @@
 							1517 0x17059	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
 						>;
 					};
+
+					pinctrl_usdhc4_2: usdhc4grp-2 {
+						fsl,pins = <
+							1386 0x17059	/* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
+							1392 0x10059	/* MX6Q_PAD_SD4_CLK__USDHC4_CLK	*/
+							1462 0x17059	/* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
+							1470 0x17059	/* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
+							1478 0x17059	/* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
+							1486 0x17059	/* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
+						>;
+					};
 				};
 			};
 
-- 
1.7.5.4
