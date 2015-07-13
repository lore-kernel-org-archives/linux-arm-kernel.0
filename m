From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 13 Jul 2015 09:42:26 +0200
Subject: [PATCH 1/3] mfd: max77686: Don't suggest in binding to use a
 deprecated property
In-Reply-To: <1436773348-15316-1-git-send-email-javier@osg.samsung.com>
References: <1436773348-15316-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1436773348-15316-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator-compatible property from the regulator DT binding was
deprecated. But the max77686 DT binding doc still suggest to use it
instead of the regulator node name's which is the correct approach.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 Documentation/devicetree/bindings/mfd/max77686.txt | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 163bd81a4607..8221102d3fc2 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -26,7 +26,7 @@ Optional node:
 	};
 	refer Documentation/devicetree/bindings/regulator/regulator.txt
 
-  The regulator-compatible property of regulator should initialized with string
+  The regulator node's name should be initialized with a string
 to get matched with their hardware counterparts as follow:
 
 	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
@@ -55,16 +55,14 @@ Example:
 		reg = <0x09>;
 
 		voltage-regulators {
-			ldo11_reg {
-				regulator-compatible = "LDO11";
+			ldo11_reg: LDO11 {
 				regulator-name = "vdd_ldo11";
 				regulator-min-microvolt = <1900000>;
 				regulator-max-microvolt = <1900000>;
 				regulator-always-on;
 			};
 
-			buck1_reg {
-				regulator-compatible = "BUCK1";
+			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <950000>;
 				regulator-max-microvolt = <1300000>;
@@ -72,8 +70,7 @@ Example:
 				regulator-boot-on;
 			};
 
-			buck9_reg {
-				regulator-compatible = "BUCK9";
+			buck9_reg: BUCK9 {
 				regulator-name = "CAM_ISP_CORE_1.2V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1200000>;
-- 
2.4.3
