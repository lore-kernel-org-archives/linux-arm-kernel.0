From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:29 -0700
Subject: [PATCH 4/6] ARM: dts: imx: ventana: configure padconf for all pins
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1410242851-30765-5-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the convention of configuring padconf for all pins and not leaving
any 0x80000000 to leave them un-configured.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 22 +++++++++----------
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 16 +++++++-------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 32 ++++++++++++++--------------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 40 +++++++++++++++++------------------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 28 ++++++++++++------------
 5 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 9687cd8..eb28f63 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -344,18 +344,18 @@
 	imx6q-gw5400-a {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x80000000 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x80000000 /* SPINOR_CS0# */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x80000000 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x80000000 /* PCIE RST */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x0001b0b0 /* SPINOR_CS0# */
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05     0x80000000 /* GPS_PPS */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x80000000 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x80000000 /* user1 led */
-				MX6QDL_PAD_KEY_COL2__GPIO4_IO10   0x80000000 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* user3 led */
-				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x80000000 /* USBHUB_RST# */
-				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x80000000 /* MIPI_DIO */
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05     0x0001b0b0 /* GPS_PPS */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x0001b0b0 /* TOUCH_IRQ# */
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10   0x0001b0b0 /* user2 led */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
+				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x4001b0b0 /* USBHUB_RST# */
+				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x4001b0b0 /* MIPI_DIO */
 			 >;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index fa2cae4..2853a10 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -170,14 +170,14 @@
 	imx6qdl-gw51xx {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x80000000 /* MEZZ_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x80000000 /* MEZZ_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x80000000 /* OTG_PWR_EN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x80000000 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* PHY Reset */
-				MX6QDL_PAD_GPIO_0__GPIO1_IO00    0x80000000 /* PCIE_RST# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x80000000 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x80000000 /* user2 led */
+				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x4001b0b0 /* MEZZ_DIO0 */
+				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x4001b0b0 /* MEZZ_DIO1 */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x0001b0b0 /* OTG_PWR_EN */
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b0b0 /* GPS_PPS */
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b0b0 /* PHY Reset */
+				MX6QDL_PAD_GPIO_0__GPIO1_IO00    0x0001b0b0 /* PCIE_RST# */
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x0001b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x0001b0b0 /* user2 led */
 			 >;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 53f4a0b..26b1395 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -240,23 +240,23 @@
 	imx6qdl-gw52xx {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x80000000 /* MEZZ_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x80000000 /* MEZZ_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x80000000 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D31__GPIO3_IO31   0x80000000 /* VIDDEC_PDN# */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* PHY Reset */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000 /* PCIE_RST# */
-				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x80000000 /* GPS_PWDN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x80000000 /* GPS_PPS */
+				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x4001b0b0 /* MEZZ_DIO0 */
+				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x4001b0b0 /* MEZZ_DIO1 */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x0001b0b0 /* OTG_PWR_EN */
+				MX6QDL_PAD_EIM_D31__GPIO3_IO31   0x0001b0b0 /* VIDDEC_PDN# */
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b0b0 /* PHY Reset */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x0001b0b0 /* PCIE_RST# */
+				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x4001b0b0 /* GPS_PWDN */
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b0b0 /* GPS_PPS */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1     0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02    0x80000000 /* USB_SEL_PCI */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12   0x80000000 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x80000000 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x80000000 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x80000000 /* user3 led */
-				MX6QDL_PAD_SD2_CMD__GPIO1_IO11   0x80000000 /* LVDS_TCH# */
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00  0x80000000 /* SD3_CD# */
-				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11  0x80000000 /* UART2_EN# */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02    0x4001b0b0 /* USB_SEL_PCI */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12   0x0001b0b0 /* TOUCH_IRQ# */
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x0001b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x0001b0b0 /* user2 led */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x0001b0b0 /* user3 led */
+				MX6QDL_PAD_SD2_CMD__GPIO1_IO11   0x0001b0b0 /* LVDS_TCH# */
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00  0x0001b0b0 /* SD3_CD# */
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11  0x4001b0b0 /* UART2_EN# */
 			 >;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 2074df6..e6e298b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -247,25 +247,25 @@
 	imx6qdl-gw53xx {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19    0x80000000 /* PCIE6EXP_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18    0x80000000 /* PCIE6EXP_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x80000000 /* OTG_PWR_EN */
-				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27  0x80000000 /* GPS_SHDN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x80000000 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x80000000 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x80000000 /* PCIE RST */
+				MX6QDL_PAD_EIM_A19__GPIO2_IO19    0x4001b0b0 /* PCIE6EXP_DIO0 */
+				MX6QDL_PAD_EIM_A20__GPIO2_IO18    0x4001b0b0 /* PCIE6EXP_DIO1 */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
+				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27  0x4001b0b0 /* GPS_SHDN */
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x0001b0b0 /* GPS_PPS */
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x80000000 /* CAN_STBY */
-				MX6QDL_PAD_GPIO_8__GPIO1_IO08     0x80000000 /* PMIC_IRQ# */
-				MX6QDL_PAD_GPIO_9__GPIO1_IO09     0x80000000 /* HUB_RST# */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x80000000 /* PCIE_WDIS# */
-				MX6QDL_PAD_GPIO_19__GPIO4_IO05    0x80000000 /* ACCEL_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x80000000 /* user1 led */
-				MX6QDL_PAD_KEY_COL4__GPIO4_IO14   0x80000000 /* USBOTG_OC# */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x80000000 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* user3 led */
-				MX6QDL_PAD_SD2_CMD__GPIO1_IO11    0x80000000 /* TOUCH_IRQ# */
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00   0x80000000 /* SD3_DET# */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x4001b0b0 /* CAN_STBY */
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08     0x0001b0b0 /* PMIC_IRQ# */
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09     0x4001b0b0 /* HUB_RST# */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x4001b0b0 /* PCIE_WDIS# */
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05    0x0001b0b0 /* ACCEL_IRQ# */
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_COL4__GPIO4_IO14   0x0001b0b0 /* USBOTG_OC# */
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x0001b0b0 /* user2 led */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
+				MX6QDL_PAD_SD2_CMD__GPIO1_IO11    0x0001b0b0 /* TOUCH_IRQ# */
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00   0x0001b0b0 /* SD3_DET# */
 			 >;
 		};
 
@@ -301,8 +301,8 @@
 
 		pinctrl_flexcan1: flexcan1grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x80000000
-				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x80000000
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index ab7827a..a366a93 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -336,19 +336,19 @@
 	imx6qdl-gw54xx {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x80000000 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x80000000 /* SPINOR_CS0# */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x80000000 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x80000000 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x80000000 /* PCIE RST */
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x0001b0b0 /* SPINOR_CS0# */
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x0001b0b0 /* GPS_PPS */
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x80000000 /* CAN_STBY */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x80000000 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x80000000 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x80000000 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* user3 led */
-				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x80000000 /* USBHUB_RST# */
-				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x80000000 /* MIPI_DIO */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x4001b0b0 /* CAN_STBY */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x0001b0b0 /* TOUCH_IRQ# */
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x0001b0b0 /* user2 led */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
+				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x4001b0b0 /* USBHUB_RST# */
+				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x4001b0b0 /* MIPI_DIO */
 			 >;
 		};
 
@@ -384,8 +384,8 @@
 
 		pinctrl_flexcan1: flexcan1grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x80000000
-				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x80000000
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
 			>;
 		};
 
-- 
1.8.3.2
