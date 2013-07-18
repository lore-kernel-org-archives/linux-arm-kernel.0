From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 09:46:10 +0200
Subject: [PATCH 3/4] ARM: dts: i.MX53: split esdhc2 pins into base and 8bit
 groups
In-Reply-To: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
References: <1374133571-7660-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1374133571-7660-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This splits the esdhc2 groups into a base group and an 8bit extension
which results in smaller devicetrees and more obvious pinctrl group
names.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx53-smd.dts     | 2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi | 2 +-
 arch/arm/boot/dts/imx53.dtsi        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index a8fb844..74d34872 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -48,7 +48,7 @@
 
 &esdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	pinctrl-0 = <&pinctrl_esdhc2_base_1>;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index abd72af..82b0bd8 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -35,7 +35,7 @@
 
 &esdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc2_1>,
+	pinctrl-0 = <&pinctrl_esdhc2_base_1>,
 		    <&pinctrl_tqma53_esdhc2_2>;
 	vmmc-supply = <&reg_3p3v>;
 	wp-gpios = <&gpio1 2 0>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6e317766..bfbeaef 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -477,7 +477,7 @@
 				};
 
 				esdhc2 {
-					pinctrl_esdhc2_1: esdhc2grp-1 {
+					pinctrl_esdhc2_base_1: esdhc2-basegrp-1 {
 						fsl,pins = <
 							MX53_PAD_SD2_CMD__ESDHC2_CMD	0x1d5
 							MX53_PAD_SD2_CLK__ESDHC2_CLK	0x1d5
-- 
1.8.3.2
