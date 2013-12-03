From: stefan@agner.ch (Stefan Agner)
Date: Tue,  3 Dec 2013 23:18:48 +0100
Subject: [PATCH v4 3/3] ARM: tegra: correct Colibri T20 regulator settings
In-Reply-To: <cover.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
Message-ID: <fc7440a2f4bf9ab95e47a911c0e0b3b6a2250356.1386108712.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the parent of the regulators LDO2 to LDO9 according to the
schematic. Set the base voltage to 3.3V, there is only 3.3V on the
module itself.

Set the Core and CPU voltage to the specified voltages of 1.2V and
1.0V respectivly.

LDO6 should deliver 2.85V. The attached peripherals were not in
use so far.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index cbe89ff..51e0880 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -225,15 +225,15 @@
 			#gpio-cells = <2>;
 			gpio-controller;
 
-			sys-supply = <&vdd_5v0_reg>;
+			sys-supply = <&vdd_3v3_reg>;
 			vin-sm0-supply = <&sys_reg>;
 			vin-sm1-supply = <&sys_reg>;
 			vin-sm2-supply = <&sys_reg>;
 			vinldo01-supply = <&sm2_reg>;
-			vinldo23-supply = <&sm2_reg>;
-			vinldo4-supply = <&sm2_reg>;
-			vinldo678-supply = <&sm2_reg>;
-			vinldo9-supply = <&sm2_reg>;
+			vinldo23-supply = <&vdd_3v3_reg>;
+			vinldo4-supply = <&vdd_3v3_reg>;
+			vinldo678-supply = <&vdd_3v3_reg>;
+			vinldo9-supply = <&vdd_3v3_reg>;
 
 			regulators {
 				#address-cells = <1>;
@@ -250,8 +250,8 @@
 					reg = <1>;
 					regulator-compatible = "sm0";
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1275000>;
-					regulator-max-microvolt = <1275000>;
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
 
@@ -259,8 +259,8 @@
 					reg = <2>;
 					regulator-compatible = "sm1";
 					regulator-name = "vdd_sm1,vdd_cpu";
-					regulator-min-microvolt = <1100000>;
-					regulator-max-microvolt = <1100000>;
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
 					regulator-always-on;
 				};
 
@@ -316,8 +316,8 @@
 					reg = <10>;
 					regulator-compatible = "ldo6";
 					regulator-name = "vdd_ldo6,avdd_vdac,vddio_vi,vddio_cam";
-					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <1800000>;
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
 				};
 
 				hdmi_vdd_reg: regulator at 11 {
@@ -504,12 +504,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		vdd_5v0_reg: regulator at 100 {
+		vdd_3v3_reg: regulator at 100 {
 			compatible = "regulator-fixed";
 			reg = <100>;
-			regulator-name = "vdd_5v0";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
+			regulator-name = "vdd_3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
 
-- 
1.8.4.2
