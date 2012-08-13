From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:30 +0800
Subject: [PATCH 10/17] ARM: dts: imx53-evk: add pinctrl settings
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl settings for the exsiting devices in imx53-evk.dts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-evk.dts |   31 +++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx53.dtsi    |   10 ++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 86aebc5..43f8f03 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -25,12 +25,16 @@
 		aips at 50000000 { /* AIPS1 */
 			spba at 50000000 {
 				esdhc at 50004000 { /* ESDHC1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc1_1>;
 					cd-gpios = <&gpio3 13 0>;
 					wp-gpios = <&gpio3 14 0>;
 					status = "okay";
 				};
 
 				ecspi at 50010000 { /* ECSPI1 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_ecspi1_1>;
 					fsl,spi-num-chipselects = <2>;
 					cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
 					status = "okay";
@@ -56,6 +60,8 @@
 				};
 
 				esdhc at 50020000 { /* ESDHC3 */
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_esdhc3_1>;
 					cd-gpios = <&gpio3 11 0>;
 					wp-gpios = <&gpio3 12 0>;
 					status = "okay";
@@ -63,17 +69,36 @@
 			};
 
 			iomuxc at 53fa8000 {
-				compatible = "fsl,imx53-iomuxc-evk";
-				reg = <0x53fa8000 0x4000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_hog>;
+
+				hog {
+					pinctrl_hog: hoggrp {
+						fsl,pins = <
+							424 0x80000000	/* MX53_PAD_EIM_EB2__GPIO2_30 */
+							449 0x80000000	/* MX53_PAD_EIM_D19__GPIO3_19 */
+							693 0x80000000	/* MX53_PAD_EIM_DA11__GPIO3_11 */
+							697 0x80000000	/* MX53_PAD_EIM_DA12__GPIO3_12 */
+							701 0x80000000	/* MX53_PAD_EIM_DA13__GPIO3_13 */
+							705 0x80000000	/* MX53_PAD_EIM_DA14__GPIO3_14 */
+							868 0x80000000	/* MX53_PAD_PATA_DA_0__GPIO7_6 */
+							873 0x80000000	/* MX53_PAD_PATA_DA_1__GPIO7_7 */
+						>;
+					};
+				};
 			};
 
 			uart1: serial at 53fbc000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1_1>;
 				status = "okay";
 			};
 		};
 
 		aips at 60000000 {	/* AIPS2 */
 			i2c at 63fc4000 { /* I2C2 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2_1>;
 				status = "okay";
 
 				pmic: mc13892 at 08 {
@@ -88,6 +113,8 @@
 			};
 
 			ethernet at 63fec000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_fec_1>;
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 9721e16..e91cbc0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -213,6 +213,16 @@
 					};
 				};
 
+				ecspi1 {
+					pinctrl_ecspi1_1: ecspi1grp-1 {
+						fsl,pins = <
+							433 0x80000000	/* MX53_PAD_EIM_D16__ECSPI1_SCLK */
+							439 0x80000000	/* MX53_PAD_EIM_D17__ECSPI1_MISO */
+							445 0x80000000	/* MX53_PAD_EIM_D18__ECSPI1_MOSI */
+						>;
+					};
+				};
+
 				esdhc1 {
 					pinctrl_esdhc1_1: esdhc1grp-1 {
 						fsl,pins = <
-- 
1.7.5.4
