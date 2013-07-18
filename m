From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 09:46:09 +0200
Subject: [PATCH 2/4] ARM: dts: i.MX53: split esdhc1 pins into base and 8bit
 groups
In-Reply-To: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
References: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1374133571-7660-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This splits the esdhc1 groups into a base group and an 8bit extension
which results in smaller devicetrees and more obvious pinctrl group
names.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53-ard.dts    |  2 +-
 arch/arm/boot/dts/imx53-evk.dts    |  2 +-
 arch/arm/boot/dts/imx53-m53evk.dts |  2 +-
 arch/arm/boot/dts/imx53-qsb.dts    |  2 +-
 arch/arm/boot/dts/imx53-smd.dts    |  2 +-
 arch/arm/boot/dts/imx53.dtsi       | 10 ++--------
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 174f869..2d47fd6 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -99,7 +99,7 @@
 
 &esdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_2>;
+	pinctrl-0 = <&pinctrl_esdhc1_base_1 &pinctrl_esdhc1_8bit_1>;
 	cd-gpios = <&gpio1 1 0>;
 	wp-gpios = <&gpio1 9 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 801fda7..2d093b5 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -34,7 +34,7 @@
 
 &esdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	pinctrl-0 = <&pinctrl_esdhc1_base_1>;
 	cd-gpios = <&gpio3 13 0>;
 	wp-gpios = <&gpio3 14 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 7d304d0..91c08f7 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -120,7 +120,7 @@
 
 &esdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	pinctrl-0 = <&pinctrl_esdhc1_base_1>;
 	cd-gpios = <&gpio1 1 0>;
 	wp-gpios = <&gpio1 9 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 512a1f6..508390f 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -112,7 +112,7 @@
 
 &esdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	pinctrl-0 = <&pinctrl_esdhc1_base_1>;
 	cd-gpios = <&gpio3 13 0>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index a9b6e10..a8fb844 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -40,7 +40,7 @@
 
 &esdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	pinctrl-0 = <&pinctrl_esdhc1_base_1>;
 	cd-gpios = <&gpio3 13 0>;
 	wp-gpios = <&gpio4 11 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 3895fbb..6e317766 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -455,7 +455,7 @@
 				};
 
 				esdhc1 {
-					pinctrl_esdhc1_1: esdhc1grp-1 {
+					pinctrl_esdhc1_base_1: esdhc1-basegrp-1 {
 						fsl,pins = <
 							MX53_PAD_SD1_DATA0__ESDHC1_DAT0 0x1d5
 							MX53_PAD_SD1_DATA1__ESDHC1_DAT1 0x1d5
@@ -466,18 +466,12 @@
 						>;
 					};
 
-					pinctrl_esdhc1_2: esdhc1grp-2 {
+					pinctrl_esdhc1_8bit_1: esdhc1-8bitgrp-1 {
 						fsl,pins = <
-							MX53_PAD_SD1_DATA0__ESDHC1_DAT0   0x1d5
-							MX53_PAD_SD1_DATA1__ESDHC1_DAT1   0x1d5
-							MX53_PAD_SD1_DATA2__ESDHC1_DAT2   0x1d5
-							MX53_PAD_SD1_DATA3__ESDHC1_DAT3   0x1d5
 							MX53_PAD_PATA_DATA8__ESDHC1_DAT4  0x1d5
 							MX53_PAD_PATA_DATA9__ESDHC1_DAT5  0x1d5
 							MX53_PAD_PATA_DATA10__ESDHC1_DAT6 0x1d5
 							MX53_PAD_PATA_DATA11__ESDHC1_DAT7 0x1d5
-							MX53_PAD_SD1_CMD__ESDHC1_CMD	  0x1d5
-							MX53_PAD_SD1_CLK__ESDHC1_CLK	  0x1d5
 						>;
 					};
 				};
-- 
1.8.3.2
