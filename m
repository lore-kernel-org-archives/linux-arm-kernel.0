From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:29 +0800
Subject: [PATCH 09/17] ARM: dts: imx53-ard: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for the exsiting devices in imx53-ard.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-ard.dts |   49 +++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx53.dtsi    |   22 +++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index b548b9c..0433056 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -25,6 +25,8 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc1_2>;
 					cd-gpios = <&gpio1 1 0>;
 					wp-gpios = <&gpio1 9 0>;
 					status = "okay";
@@ -32,11 +34,54 @@
 			};
 
 			iomuxc at 53fa8000 {
-				compatible = "fsl,imx53-iomuxc-ard";
-				reg = <0x53fa8000 0x4000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							1077 0x80000000	/* MX53_PAD_GPIO_1__GPIO1_1 */
+							1085 0x80000000	/* MX53_PAD_GPIO_9__GPIO1_9 */
+							486  0x80000000	/* MX53_PAD_EIM_EB3__GPIO2_31 */
+							739  0x80000000	/* MX53_PAD_GPIO_10__GPIO4_0 */
+							218  0x80000000	/* MX53_PAD_DISP0_DAT16__GPIO5_10 */
+							226  0x80000000	/* MX53_PAD_DISP0_DAT17__GPIO5_11 */
+							233  0x80000000	/* MX53_PAD_DISP0_DAT18__GPIO5_12 */
+							241  0x80000000	/* MX53_PAD_DISP0_DAT19__GPIO5_13 */
+							429  0x80000000	/* MX53_PAD_EIM_D16__EMI_WEIM_D_16 */
+							435  0x80000000	/* MX53_PAD_EIM_D17__EMI_WEIM_D_17 */
+							441  0x80000000	/* MX53_PAD_EIM_D18__EMI_WEIM_D_18 */
+							448  0x80000000	/* MX53_PAD_EIM_D19__EMI_WEIM_D_19 */
+							456  0x80000000	/* MX53_PAD_EIM_D20__EMI_WEIM_D_20 */
+							464  0x80000000	/* MX53_PAD_EIM_D21__EMI_WEIM_D_21 */
+							471  0x80000000	/* MX53_PAD_EIM_D22__EMI_WEIM_D_22 */
+							477  0x80000000	/* MX53_PAD_EIM_D23__EMI_WEIM_D_23 */
+							492  0x80000000	/* MX53_PAD_EIM_D24__EMI_WEIM_D_24 */
+							500  0x80000000	/* MX53_PAD_EIM_D25__EMI_WEIM_D_25 */
+							508  0x80000000	/* MX53_PAD_EIM_D26__EMI_WEIM_D_26 */
+							516  0x80000000	/* MX53_PAD_EIM_D27__EMI_WEIM_D_27 */
+							524  0x80000000	/* MX53_PAD_EIM_D28__EMI_WEIM_D_28 */
+							532  0x80000000	/* MX53_PAD_EIM_D29__EMI_WEIM_D_29 */
+							540  0x80000000	/* MX53_PAD_EIM_D30__EMI_WEIM_D_30 */
+							548  0x80000000	/* MX53_PAD_EIM_D31__EMI_WEIM_D_31 */
+							637  0x80000000	/* MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0 */
+							642  0x80000000	/* MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1 */
+							647  0x80000000	/* MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2 */
+							652  0x80000000	/* MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3 */
+							657  0x80000000	/* MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4 */
+							662  0x80000000	/* MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5 */
+							667  0x80000000	/* MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6 */
+							611  0x80000000	/* MX53_PAD_EIM_OE__EMI_WEIM_OE */
+							616  0x80000000	/* MX53_PAD_EIM_RW__EMI_WEIM_RW */
+							607  0x80000000	/* MX53_PAD_EIM_CS1__EMI_WEIM_CS_1 */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 53fbc000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_2>;
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 35d102d..9721e16 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -224,6 +224,21 @@
 							1018 0x1d5	/* MX53_PAD_SD1_CLK__ESDHC1_CLK */
 						>;
 					};
+
+					pinctrl_esdhc1_2: esdhc1grp-2 {
+						fsl,pins = <
+							995  0x1d5	/* MX53_PAD_SD1_DATA0__ESDHC1_DAT0 */
+							1000 0x1d5	/* MX53_PAD_SD1_DATA1__ESDHC1_DAT1 */
+							1010 0x1d5	/* MX53_PAD_SD1_DATA2__ESDHC1_DAT2 */
+							1024 0x1d5	/* MX53_PAD_SD1_DATA3__ESDHC1_DAT3 */
+							941  0x1d5	/* MX53_PAD_PATA_DATA8__ESDHC1_DAT4 */
+							948  0x1d5	/* MX53_PAD_PATA_DATA9__ESDHC1_DAT5 */
+							955  0x1d5	/* MX53_PAD_PATA_DATA10__ESDHC1_DAT6 */
+							962  0x1d5	/* MX53_PAD_PATA_DATA11__ESDHC1_DAT7 */
+							1005 0x1d5	/* MX53_PAD_SD1_CMD__ESDHC1_CMD */
+							1018 0x1d5	/* MX53_PAD_SD1_CLK__ESDHC1_CLK */
+						>;
+					};
 				};
 
 				esdhc3 {
@@ -268,6 +283,13 @@
 							354 0x1c5	/* MX53_PAD_CSI0_DAT11__UART1_RXD_MUX */
 						>;
 					};
+
+					pinctrl_uart1_2: uart1grp-2 {
+						fsl,pins = <
+							828 0x1c5	/* MX53_PAD_PATA_DIOW__UART1_TXD_MUX */
+							832 0x1c5	/* MX53_PAD_PATA_DMACK__UART1_RXD_MUX */
+						>;
+					};
 				};
 			};
 
-- 
1.7.5.4
