From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Jul 2013 15:13:30 +0200
Subject: [PATCH 2/3] ARM: dts: imx27 phyCARD-S, move i2c1 and owire to rdk
In-Reply-To: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
References: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1373202811-13825-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both buses are not used on the phyCARD-S module. This patch moves them
to the rdk file. Remove ioexpander.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 13 +++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 18 ------------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 390d8f2..0514b0a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -41,6 +41,19 @@
 	status = "okay";
 };
 
+&i2c1 {
+	status = "okay";
+
+	rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&owire {
+	status = "okay";
+};
+
 &sdhci2 {
 	cd-gpios = <&gpio3 29 0>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index cdff8c7..c8d57d1 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -33,20 +33,6 @@
 	status = "okay";
 };
 
-&i2c1 {
-	status = "okay";
-
-	ioexpander at 41 {
-		compatible = "nxp,pca9536";
-		reg = <0x41>;
-	};
-
-	rtc at 51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
 &i2c2 {
 	status = "okay";
 
@@ -56,7 +42,3 @@
 		reg = <0x52>;
 	};
 };
-
-&owire {
-	status = "okay";
-};
-- 
1.8.2.1
