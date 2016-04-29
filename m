From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 29 Apr 2016 19:39:45 -0300
Subject: [PATCH] ARM: dts: imx6qdl: Remove unneeded unit-addresses
Message-ID: <1461969585-17784-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The following build warnings are seen when building with 'W=1' option:

Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-1p1 at 110 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-3p0 at 120 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-2p5 at 130 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddcore at 140 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddpu at 140 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips-bus at 02000000/anatop at 020c8000/regulator-vddsoc at 140 has a unit name, but no reg property

Fix them by removing the unneeded unit-addresses.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 294afa7..ed613eb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -621,7 +621,7 @@
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 
-				regulator-1p1 at 110 {
+				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
 					regulator-min-microvolt = <800000>;
@@ -635,7 +635,7 @@
 					anatop-max-voltage = <1375000>;
 				};
 
-				regulator-3p0 at 120 {
+				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
 					regulator-min-microvolt = <2800000>;
@@ -649,7 +649,7 @@
 					anatop-max-voltage = <3400000>;
 				};
 
-				regulator-2p5 at 130 {
+				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
 					regulator-min-microvolt = <2000000>;
@@ -663,7 +663,7 @@
 					anatop-max-voltage = <2750000>;
 				};
 
-				reg_arm: regulator-vddcore at 140 {
+				reg_arm: regulator-vddcore {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
@@ -680,7 +680,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_pu: regulator-vddpu at 140 {
+				reg_pu: regulator-vddpu {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddpu";
 					regulator-min-microvolt = <725000>;
@@ -697,7 +697,7 @@
 					anatop-max-voltage = <1450000>;
 				};
 
-				reg_soc: regulator-vddsoc at 140 {
+				reg_soc: regulator-vddsoc {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vddsoc";
 					regulator-min-microvolt = <725000>;
-- 
1.9.1
