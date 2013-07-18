From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 09:46:11 +0200
Subject: [PATCH 4/4] ARM: dts: i.MX53: split esdhc3 pins into base and 8bit
 groups
In-Reply-To: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
References: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1374133571-7660-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This splits the esdhc3 groups into a base group and an 8bit extension
which results in smaller devicetrees and more obvious pinctrl group
names.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53-evk.dts     |  2 +-
 arch/arm/boot/dts/imx53-qsb.dts     |  2 +-
 arch/arm/boot/dts/imx53-smd.dts     |  2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi |  2 +-
 arch/arm/boot/dts/imx53.dtsi        | 11 ++++++++---
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 2d093b5..ed5a41a 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -69,7 +69,7 @@
 
 &esdhc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	pinctrl-0 = <&pinctrl_esdhc3_base_1 &pinctrl_esdhc3_8bit_1>;
 	cd-gpios = <&gpio3 11 0>;
 	wp-gpios = <&gpio3 12 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 508390f..dbdd807 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -124,7 +124,7 @@
 
 &esdhc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	pinctrl-0 = <&pinctrl_esdhc3_base_1 &pinctrl_esdhc3_8bit_1>;
 	cd-gpios = <&gpio3 11 0>;
 	wp-gpios = <&gpio3 12 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 74d34872..668c518 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -95,7 +95,7 @@
 
 &esdhc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	pinctrl-0 = <&pinctrl_esdhc3_base_1 &pinctrl_esdhc3_8bit_1>;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 82b0bd8..4c95c93 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -60,7 +60,7 @@
 
 &esdhc3 { /* EMMC */
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	pinctrl-0 = <&pinctrl_esdhc3_base_1 &pinctrl_esdhc3_8bit_1>;
 	vmmc-supply = <&reg_3p3v>;
 	non-removable;
 	bus-width = <8>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index bfbeaef..a3e1eee 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -490,18 +490,23 @@
 				};
 
 				esdhc3 {
-					pinctrl_esdhc3_1: esdhc3grp-1 {
+					pinctrl_esdhc3_base_1: esdhc3-basegrp-1 {
 						fsl,pins = <
 							MX53_PAD_PATA_DATA8__ESDHC3_DAT0  0x1d5
 							MX53_PAD_PATA_DATA9__ESDHC3_DAT1  0x1d5
 							MX53_PAD_PATA_DATA10__ESDHC3_DAT2 0x1d5
 							MX53_PAD_PATA_DATA11__ESDHC3_DAT3 0x1d5
+							MX53_PAD_PATA_RESET_B__ESDHC3_CMD 0x1d5
+							MX53_PAD_PATA_IORDY__ESDHC3_CLK   0x1d5
+						>;
+					};
+
+					pinctrl_esdhc3_8bit_1: esdhc3-8bitgrp-1 {
+						fsl,pins = <
 							MX53_PAD_PATA_DATA0__ESDHC3_DAT4  0x1d5
 							MX53_PAD_PATA_DATA1__ESDHC3_DAT5  0x1d5
 							MX53_PAD_PATA_DATA2__ESDHC3_DAT6  0x1d5
 							MX53_PAD_PATA_DATA3__ESDHC3_DAT7  0x1d5
-							MX53_PAD_PATA_RESET_B__ESDHC3_CMD 0x1d5
-							MX53_PAD_PATA_IORDY__ESDHC3_CLK   0x1d5
 						>;
 					};
 				};
-- 
1.8.3.2
