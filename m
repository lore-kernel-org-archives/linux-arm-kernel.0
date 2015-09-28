From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Sep 2015 12:38:34 +0200
Subject: [PATCH v2] ARM: dts: exynos4412-trats2: remove regulator-compatible
 usage
Message-ID: <1443436714-4488-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator-compatible property from the regulator DT binding was
deprecated and the correct approach is to use the node's name.

This patch has no functional changes but by not using a deprecated
property, new DTS based on this one will not carry the same issue.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Fixed typo on LDO10. Pointed out by Anand Moon.

 arch/arm/boot/dts/exynos4412-trats2.dts | 105 +++++++++++---------------------
 1 file changed, 35 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 2a1ebb76ebe0..93e3bbd4bd49 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -564,16 +564,14 @@
 		#clock-cells = <1>;
 
 		voltage-regulators {
-			ldo1_reg: ldo1 {
-				regulator-compatible = "LDO1";
+			ldo1_reg: LDO1 {
 				regulator-name = "VALIVE_1.0V_AP";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 			};
 
-			ldo2_reg: ldo2 {
-				regulator-compatible = "LDO2";
+			ldo2_reg: LDO2 {
 				regulator-name = "VM1M2_1.2V_AP";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
@@ -583,32 +581,28 @@
 				};
 			};
 
-			ldo3_reg: ldo3 {
-				regulator-compatible = "LDO3";
+			ldo3_reg: LDO3 {
 				regulator-name = "VCC_1.8V_AP";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 			};
 
-			ldo4_reg: ldo4 {
-				regulator-compatible = "LDO4";
+			ldo4_reg: LDO4 {
 				regulator-name = "VCC_2.8V_AP";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-always-on;
 			};
 
-			ldo5_reg: ldo5 {
-				regulator-compatible = "LDO5";
+			ldo5_reg: LDO5 {
 				regulator-name = "VCC_1.8V_IO";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 			};
 
-			ldo6_reg: ldo6 {
-				regulator-compatible = "LDO6";
+			ldo6_reg: LDO6 {
 				regulator-name = "VMPLL_1.0V_AP";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
@@ -618,8 +612,7 @@
 				};
 			};
 
-			ldo7_reg: ldo7 {
-				regulator-compatible = "LDO7";
+			ldo7_reg: LDO7 {
 				regulator-name = "VPLL_1.0V_AP";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
@@ -629,8 +622,7 @@
 				};
 			};
 
-			ldo8_reg: ldo8 {
-				regulator-compatible = "LDO8";
+			ldo8_reg: LDO8 {
 				regulator-name = "VMIPI_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
@@ -639,15 +631,13 @@
 				};
 			};
 
-			ldo9_reg: ldo9 {
-				regulator-compatible = "LDO9";
+			ldo9_reg: LDO9 {
 				regulator-name = "CAM_ISP_MIPI_1.2V";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 			};
 
-			ldo10_reg: ldo10 {
-				regulator-compatible = "LDO10";
+			ldo10_reg: LDO10 {
 				regulator-name = "VMIPI_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -656,8 +646,7 @@
 				};
 			};
 
-			ldo11_reg: ldo11 {
-				regulator-compatible = "LDO11";
+			ldo11_reg: LDO11 {
 				regulator-name = "VABB1_1.95V";
 				regulator-min-microvolt = <1950000>;
 				regulator-max-microvolt = <1950000>;
@@ -667,8 +656,7 @@
 				};
 			};
 
-			ldo12_reg: ldo12 {
-				regulator-compatible = "LDO12";
+			ldo12_reg: LDO12 {
 				regulator-name = "VUOTG_3.0V";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
@@ -677,15 +665,13 @@
 				};
 			};
 
-			ldo13_reg: ldo13 {
-				regulator-compatible = "LDO13";
+			ldo13_reg: LDO13 {
 				regulator-name = "NFC_AVDD_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			ldo14_reg: ldo14 {
-				regulator-compatible = "LDO14";
+			ldo14_reg: LDO14 {
 				regulator-name = "VABB2_1.95V";
 				regulator-min-microvolt = <1950000>;
 				regulator-max-microvolt = <1950000>;
@@ -695,8 +681,7 @@
 				};
 			};
 
-			ldo15_reg: ldo15 {
-				regulator-compatible = "LDO15";
+			ldo15_reg: LDO15 {
 				regulator-name = "VHSIC_1.0V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
@@ -705,8 +690,7 @@
 				};
 			};
 
-			ldo16_reg: ldo16 {
-				regulator-compatible = "LDO16";
+			ldo16_reg: LDO16 {
 				regulator-name = "VHSIC_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -715,80 +699,69 @@
 				};
 			};
 
-			ldo17_reg: ldo17 {
-				regulator-compatible = "LDO17";
+			ldo17_reg: LDO17 {
 				regulator-name = "CAM_SENSOR_CORE_1.2V";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 			};
 
-			ldo18_reg: ldo18 {
-				regulator-compatible = "LDO18";
+			ldo18_reg: LDO18 {
 				regulator-name = "CAM_ISP_SEN_IO_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			ldo19_reg: ldo19 {
-				regulator-compatible = "LDO19";
+			ldo19_reg: LDO19 {
 				regulator-name = "VT_CAM_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			ldo20_reg: ldo20 {
-				regulator-compatible = "LDO20";
+			ldo20_reg: LDO20 {
 				regulator-name = "VDDQ_PRE_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			ldo21_reg: ldo21 {
-				regulator-compatible = "LDO21";
+			ldo21_reg: LDO21 {
 				regulator-name = "VTF_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				maxim,ena-gpios = <&gpy2 0 GPIO_ACTIVE_HIGH>;
 			};
 
-			ldo22_reg: ldo22 {
-				regulator-compatible = "LDO22";
+			ldo22_reg: LDO22 {
 				regulator-name = "VMEM_VDD_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
 			};
 
-			ldo23_reg: ldo23 {
-				regulator-compatible = "LDO23";
+			ldo23_reg: LDO23 {
 				regulator-name = "TSP_AVDD_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 			};
 
-			ldo24_reg: ldo24 {
-				regulator-compatible = "LDO24";
+			ldo24_reg: LDO24 {
 				regulator-name = "TSP_VDD_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 			};
 
-			ldo25_reg: ldo25 {
-				regulator-compatible = "LDO25";
+			ldo25_reg: LDO25 {
 				regulator-name = "LCD_VCC_3.3V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 			};
 
-			ldo26_reg: ldo26 {
-				regulator-compatible = "LDO26";
+			ldo26_reg: LDO26 {
 				regulator-name = "MOTOR_VCC_3.0V";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 			};
 
-			buck1_reg: buck1 {
-				regulator-compatible = "BUCK1";
+			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1100000>;
@@ -799,8 +772,7 @@
 				};
 			};
 
-			buck2_reg: buck2 {
-				regulator-compatible = "BUCK2";
+			buck2_reg: BUCK2 {
 				regulator-name = "vdd_arm";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1500000>;
@@ -811,8 +783,7 @@
 				};
 			};
 
-			buck3_reg: buck3 {
-				regulator-compatible = "BUCK3";
+			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1150000>;
@@ -823,8 +794,7 @@
 				};
 			};
 
-			buck4_reg: buck4 {
-				regulator-compatible = "BUCK4";
+			buck4_reg: BUCK4 {
 				regulator-name = "vdd_g3d";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1150000>;
@@ -834,40 +804,35 @@
 				};
 			};
 
-			buck5_reg: buck5 {
-				regulator-compatible = "BUCK5";
+			buck5_reg: BUCK5 {
 				regulator-name = "VMEM_1.2V_AP";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 			};
 
-			buck6_reg: buck6 {
-				regulator-compatible = "BUCK6";
+			buck6_reg: BUCK6 {
 				regulator-name = "VCC_SUB_1.35V";
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
 			};
 
-			buck7_reg: buck7 {
-				regulator-compatible = "BUCK7";
+			buck7_reg: BUCK7 {
 				regulator-name = "VCC_SUB_2.0V";
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
 				regulator-always-on;
 			};
 
-			buck8_reg: buck8 {
-				regulator-compatible = "BUCK8";
+			buck8_reg: BUCK8 {
 				regulator-name = "VMEM_VDDF_3.0V";
 				regulator-min-microvolt = <2850000>;
 				regulator-max-microvolt = <2850000>;
 				maxim,ena-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
 			};
 
-			buck9_reg: buck9 {
-				regulator-compatible = "BUCK9";
+			buck9_reg: BUCK9 {
 				regulator-name = "CAM_ISP_CORE_1.2V";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1200000>;
-- 
2.4.3
