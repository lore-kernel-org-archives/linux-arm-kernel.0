From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:26 +0800
Subject: [PATCH 06/17] ARM: dts: imx6q-sabresd: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for existing devices in imx6q-sabresd.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabresd.dts |   25 ++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6q.dtsi        |   26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 07509a1..e596c28c 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -22,28 +22,51 @@
 	};
 
 	soc {
-
 		aips-bus at 02000000 { /* AIPS1 */
 			spba-bus at 02000000 {
 				uart1: serial at 02020000 {
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_uart1_1>;
 					status = "okay";
 				};
 			};
+
+			iomuxc at 020e0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							1402 0x80000000	/* MX6Q_PAD_NANDF_D0__GPIO_2_0 */
+							1410 0x80000000	/* MX6Q_PAD_NANDF_D1__GPIO_2_1 */
+							1418 0x80000000	/* MX6Q_PAD_NANDF_D2__GPIO_2_2 */
+							1426 0x80000000	/* MX6Q_PAD_NANDF_D3__GPIO_2_3 */
+						>;
+					};
+				};
+			};
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
 			ethernet at 02188000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_enet_1>;
 				phy-mode = "rgmii";
 				status = "okay";
 			};
 
 			usdhc at 02194000 { /* uSDHC2 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc2_1>;
 				cd-gpios = <&gpio2 2 0>;
 				wp-gpios = <&gpio2 3 0>;
 				status = "okay";
 			};
 
 			usdhc at 02198000 { /* uSDHC3 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usdhc3_1>;
 				cd-gpios = <&gpio2 0 0>;
 				wp-gpios = <&gpio2 1 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 23d680a..3b97212 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -602,6 +602,15 @@
 					};
 				};
 
+				uart1 {
+					pinctrl_uart1_1: uart1grp-1 {
+						fsl,pins = <
+							1140 0x1b0b1	/* MX6Q_PAD_CSI0_DAT10__UART1_TXD */
+							1148 0x1b0b1	/* MX6Q_PAD_CSI0_DAT11__UART1_RXD */
+						>;
+					};
+				};
+
 				uart2 {
 					pinctrl_uart2_1: uart2grp-1 {
 						fsl,pins = <
@@ -620,6 +629,23 @@
 					};
 				};
 
+				usdhc2 {
+					pinctrl_usdhc2_1: usdhc2grp-1 {
+						fsl,pins = <
+							1577 0x17059	/* MX6Q_PAD_SD2_CMD__USDHC2_CMD */
+							1569 0x10059	/* MX6Q_PAD_SD2_CLK__USDHC2_CLK */
+							16   0x17059	/* MX6Q_PAD_SD2_DAT0__USDHC2_DAT0 */
+							0    0x17059	/* MX6Q_PAD_SD2_DAT1__USDHC2_DAT1 */
+							8    0x17059	/* MX6Q_PAD_SD2_DAT2__USDHC2_DAT2 */
+							1583 0x17059	/* MX6Q_PAD_SD2_DAT3__USDHC2_DAT3 */
+							1430 0x17059	/* MX6Q_PAD_NANDF_D4__USDHC2_DAT4 */
+							1438 0x17059	/* MX6Q_PAD_NANDF_D5__USDHC2_DAT5 */
+							1446 0x17059	/* MX6Q_PAD_NANDF_D6__USDHC2_DAT6 */
+							1454 0x17059	/* MX6Q_PAD_NANDF_D7__USDHC2_DAT7 */
+						>;
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <
-- 
1.7.5.4
