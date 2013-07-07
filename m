From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Jul 2013 15:13:29 +0200
Subject: [PATCH 1/3] ARM: dts: imx27 phyCARD-S SOM remove wrong i2c sensor
In-Reply-To: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
References: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1373202811-13825-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sensor was introduced in the original pca100 board file, but
phyCARD-S SOM and RDK do not have a temperature sensor.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index 01ee807..cdff8c7 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -50,11 +50,6 @@
 &i2c2 {
 	status = "okay";
 
-	lm75 at 4a {
-		compatible = "national,lm75";
-		reg = <0x4a>;
-	};
-
 	at24 at 52 {
 		compatible = "at,24c32";
 		pagesize = <32>;
-- 
1.8.2.1
