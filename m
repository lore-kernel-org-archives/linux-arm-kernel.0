From: marco.franchi@nxp.com (Marco Franchi)
Date: Fri, 20 Oct 2017 13:48:22 -0200
Subject: [PATCH v3 1/6] ARM: dts: imx51-apf51dev: Fix 'backlight@bl1' node
 with unit name and no reg property
Message-ID: <1508514507-30736-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /backlight at bl1 has a unit name, but no reg property

Fix this warning by removing '@bl1'from such node and change 'bl1grp' to 
'backlightgrp', once there is only one backlight in this dts.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v2:
-change message log
-change backlight-bl1 to backlight
-change bl1grp to backlightgrp
-add missed space
 arch/arm/boot/dts/imx51-apf51dev.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 2f1a9d2..3e1846a 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -16,7 +16,7 @@
 	model = "Armadeus Systems APF51Dev docking/development board";
 	compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
 
-	backlight at bl1{
+	backlight {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_backlight>;
 		compatible = "gpio-backlight";
@@ -120,7 +120,7 @@
 	pinctrl-0 = <&pinctrl_hog>;
 
 	imx51-apf51dev {
-		pinctrl_backlight: bl1grp {
+		pinctrl_backlight: backlightgrp {
 			fsl,pins = <
 				MX51_PAD_DI1_D1_CS__GPIO3_4 0x1F5
 			>;
-- 
2.7.4
