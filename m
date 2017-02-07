From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  7 Feb 2017 19:14:38 -0200
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Remove unnecessary node
Message-ID: <1486502078-550-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6ul.dtsi already contains:

cpu0: cpu at 0 {
	....
	arm-supply = <&reg_arm>;
	soc-supply = <&reg_soc>;
};

, so remove the duplication.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 00f98e5..f18e1f1 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -85,11 +85,6 @@
 	assigned-clock-rates = <786432000>;
 };
 
-&cpu0 {
-	arm-supply = <&reg_arm>;
-	soc-supply = <&reg_soc>;
-};
-
 &i2c2 {
 	clock_frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.7.4
