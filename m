From: broonie@kernel.org (Mark Brown)
Date: Mon,  1 Jul 2013 22:36:38 +0100
Subject: [PATCH 2/3] ARM: dts: Hook up supplies for Arndale S5M8767
In-Reply-To: <1372714599-17588-1-git-send-email-broonie@kernel.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
Message-ID: <1372714599-17588-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

As part of this add nodes for the main wall supply as well as bucks 7
and 8 which are used to drop that down for several of the LDOs.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 68a13a6..482f275 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -38,6 +38,26 @@
 			compatible = "samsung,s5m8767-pmic";
 			reg = <0x66>;
 
+			vinb1-supply = <&main_dc_reg>;
+			vinb2-supply = <&main_dc_reg>;
+			vinb3-supply = <&main_dc_reg>;
+			vinb4-supply = <&main_dc_reg>;
+			vinb5-supply = <&main_dc_reg>;
+			vinb6-supply = <&main_dc_reg>;
+			vinb7-supply = <&main_dc_reg>;
+			vinb8-supply = <&main_dc_reg>;
+			vinb9-supply = <&main_dc_reg>;
+
+			vinl1-supply = <&buck7_reg>;
+			vinl2-supply = <&buck7_reg>;
+			vinl3-supply = <&buck7_reg>;
+			vinl4-supply = <&main_dc_reg>;
+			vinl5-supply = <&main_dc_reg>;
+			vinl6-supply = <&main_dc_reg>;
+			vinl7-supply = <&main_dc_reg>;
+			vinl8-supply = <&buck8_reg>;
+			vinl9-supply = <&buck8_reg>;
+
 			s5m8767,pmic-buck2-dvs-voltage = <1300000>;
 			s5m8767,pmic-buck3-dvs-voltage = <1100000>;
 			s5m8767,pmic-buck4-dvs-voltage = <1200000>;
@@ -276,6 +296,16 @@
 					op_mode = <1>;
 				};
 
+				buck7_reg: BUCK7 {
+					regulator-name = "PVDD_BUCK7";
+					regulator-always-on;
+				};
+
+				buck8_reg: BUCK8 {
+					regulator-name = "PVDD_BUCK8";
+					regulator-always-on;
+				};
+
 				buck9_reg: BUCK9 {
 					regulator-name = "VDD_33_OFF_EXT1";
 					regulator-min-microvolt = <750000>;
@@ -434,6 +464,11 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		main_dc_reg: fixedregulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "MAIN_DC";
+		};
+
 		mmc_reg: voltage-regulator {
 			compatible = "regulator-fixed";
 			regulator-name = "VDD_33ON_2.8V";
-- 
1.8.3.1
