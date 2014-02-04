From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  4 Feb 2014 18:59:30 +0400
Subject: [PATCH 1/3] ARM: dts: imx27-phytec-phycard-s-som: Sort entries
Message-ID: <1391525972-15810-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index e51e550..a28b6c7 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -29,6 +29,24 @@
 	status = "okay";
 };
 
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	at24 at 52 {
+		compatible = "at,24c32";
+		pagesize = <32>;
+		reg = <0x52>;
+	};
+};
+
 &iomuxc {
 	imx27-phycard-s-som {
 		pinctrl_fec1: fec1grp {
@@ -62,21 +80,3 @@
 		};
 	};
 };
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	at24 at 52 {
-		compatible = "at,24c32";
-		pagesize = <32>;
-		reg = <0x52>;
-	};
-};
-- 
1.8.3.2
