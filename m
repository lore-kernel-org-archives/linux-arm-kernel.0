From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 18 Oct 2017 17:29:46 -0200
Subject: [PATCH v2 1/6] ARM: dts: imx51-apf51dev: Fix 'backlight@bl1' node
 with unit name and no reg property
Message-ID: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /backlight at bl1 has a unit name, but no 
reg property

Fix this warning by changing '@' to '-'.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-none
 arch/arm/boot/dts/imx51-apf51dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 2f1a9d2..a6c2c11 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -16,7 +16,7 @@
 	model = "Armadeus Systems APF51Dev docking/development board";
 	compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
 
-	backlight at bl1{
+	backlight-bl1{
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_backlight>;
 		compatible = "gpio-backlight";
-- 
2.7.4
