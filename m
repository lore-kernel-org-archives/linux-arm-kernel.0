From: broonie@kernel.org (Mark Brown)
Date: Fri,  5 Sep 2014 22:12:05 +0100
Subject: [PATCH] ARM: dts: am335x-boneblack: Add names for remaining regulators
Message-ID: <1409951525-30035-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator-name properties for the regulators that don't have them,
allowing the kernel to display the name from the schematic rather than
the name of the regulator on the PMIC in order to improve diagnostics.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index bde1777b62be..fe983d204b2b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -227,6 +227,7 @@
 &tps {
 	regulators {
 		dcdc1_reg: regulator at 0 {
+			regulator-name = "vdds_dpr";
 			regulator-always-on;
 		};
 
@@ -249,18 +250,22 @@
 		};
 
 		ldo1_reg: regulator at 3 {
+			regulator-name = "vio,vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator at 4 {
+			regulator-name = "vdd_3v3aux";
 			regulator-always-on;
 		};
 
 		ldo3_reg: regulator at 5 {
+			regulator-name = "vdd_1v8";
 			regulator-always-on;
 		};
 
 		ldo4_reg: regulator at 6 {
+			regulator-name = "vdd_3v3a";
 			regulator-always-on;
 		};
 	};
-- 
2.1.0
