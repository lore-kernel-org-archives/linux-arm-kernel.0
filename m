From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 4 Apr 2013 15:05:29 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Fix the ethernet regulator name
Message-ID: <1365098729-21933-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC driver looks for "phy" as the regulator-name:

reg_phy = devm_regulator_get(&pdev->dev, "phy");

So adjust it properly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index c886e9a..fad5ed7 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -286,7 +286,7 @@
 
 		reg_fec_3v3: fec-3v3 {
 			compatible = "regulator-fixed";
-			regulator-name = "fec-3v3";
+			regulator-name = "phy";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio2 15 0>;
-- 
1.7.9.5
