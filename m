From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  6 Jun 2013 11:49:36 +0200
Subject: [PATCH v2] ARM i.MX53: tqma53: add WP/CD pinctrl and vmmc to esdhc2
Message-ID: <1370512176-19705-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add WP/CD pinctrl for esdhc2.
Also, add vmmc-supply for esdhc2.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---

Changes since v1:
	- move pinctrl to boardspecific namespace

 arch/arm/boot/dts/imx53-tqma53.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index 38bed3e..dae03bb 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -35,7 +35,9 @@
 
 &esdhc2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	pinctrl-0 = <&pinctrl_esdhc2_1>,
+		    <&pinctrl_tqma53_esdhc2_2>;
+	vmmc-supply = <&reg_3p3v>;
 	wp-gpios = <&gpio1 2 0>;
 	cd-gpios = <&gpio1 4 0>;
 	status = "disabled";
@@ -69,6 +71,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	esdhc2_2 {
+		pinctrl_tqma53_esdhc2_2: esdhc2-tqma53-grp2 {
+			fsl,pins = <
+				MX53_PAD_GPIO_4__GPIO1_4	0x80000000 /* SD2_CD */
+				MX53_PAD_GPIO_2__GPIO1_2	0x80000000 /* SD2_WP */
+			>;
+		};
+	};
+
 	i2s {
 		pinctrl_i2s_1: i2s-grp1 {
 			fsl,pins = <
-- 
1.8.2.rc2
