From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 22:12:42 +0900
Subject: [PATCHv4 3/3] ARM: dts: Add sleep mode of regulator for
 exynos3250-rinato board
In-Reply-To: <1414156362-5752-1-git-send-email-cw00.choi@samsung.com>
References: <1414156362-5752-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1414156362-5752-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add sleep mode of regulator for exynos3250-rinato board to optimize
power-consumption in sleep state.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 8ad9808..84380fa 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -157,6 +157,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo2_reg: LDO2 {
@@ -164,6 +168,10 @@
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo3_reg: LDO3 {
@@ -171,6 +179,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -178,6 +190,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -185,6 +201,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -192,6 +212,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -199,6 +223,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
@@ -206,6 +234,10 @@
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo9_reg: LDO9 {
@@ -213,12 +245,20 @@
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
 				regulator-name = "UNUSED_LDO10";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -239,60 +279,100 @@
 				regulator-name = "CAM_AVDD_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
 				regulator-name = "UNUSED_LDO14";
 				regulator-min-microvolt = <2700000>;
 				regulator-max-microvolt = <2700000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo15_reg: LDO15 {
 				regulator-name = "TSP_AVDD_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
 				regulator-name = "LCD_VDD_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo17_reg: LDO17 {
 				regulator-name = "V_IRLED_3.3V";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo18_reg: LDO18 {
 				regulator-name = "CAM_AF_2.8V";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo19_reg: LDO19 {
 				regulator-name = "TSP_VDD_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
 				regulator-name = "LCD_VDD_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo21_reg: LDO21 {
 				regulator-name = "CAM_IO_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo22_reg: LDO22 {
 				regulator-name = "CAM_DVDD_1.2V";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo23_reg: LDO23 {
@@ -306,12 +386,20 @@
 				regulator-name = "HRM_VCC_3.3V";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo25_reg: LDO25 {
 				regulator-name = "UNUSED_LDO25";
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck1_reg: BUCK1 {
@@ -319,6 +407,10 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -326,6 +418,10 @@
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -333,6 +429,10 @@
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -340,6 +440,10 @@
 				regulator-min-microvolt = <1950000>;
 				regulator-max-microvolt = <1950000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
@@ -347,6 +451,10 @@
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 		};
 	};
-- 
1.8.5.5
