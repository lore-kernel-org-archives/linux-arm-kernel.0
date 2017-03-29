From: stefan@agner.ch (Stefan Agner)
Date: Wed, 29 Mar 2017 16:21:10 -0700
Subject: [PATCH 2/5] ARM: dts: imx7-colibri: fix PMIC voltages
In-Reply-To: <20170329232113.19078-1-stefan@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
Message-ID: <20170329232113.19078-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix wrong voltage of PWR_EN_+V3.3 rail. The error had no noticeable
effect since no consumer explicitly requested a specific voltage.
Also use round voltages as it is common in other device trees.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index a171545478be..47eab920666f 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -151,29 +151,29 @@
 
 		regulators {
 			reg_DCDC1: DCDC1 {  /* V1.0_SOC */
-				regulator-min-microvolt =  <975000>;
-				regulator-max-microvolt = <1125000>;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_DCDC2: DCDC2 { /* V1.1_ARM */
-				regulator-min-microvolt =  <975000>;
-				regulator-max-microvolt = <1125000>;
+				regulator-min-microvolt = <975000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_DCDC3: DCDC3 { /* V1.8 */
-				regulator-min-microvolt = <1775000>;
-				regulator-max-microvolt = <1825000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_DCDC4: DCDC4 { /* V1.35_DRAM */
-				regulator-min-microvolt = <1325000>;
-				regulator-max-microvolt = <1375000>;
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1350000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -185,29 +185,29 @@
 			};
 
 			reg_LDO2: LDO2 { /* +V1.8_SD */
-				regulator-min-microvolt = <1775000>;
-				regulator-max-microvolt = <3325000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_LDO3: LDO3 { /* PWR_EN_+V3.3_LPSR */
-				regulator-min-microvolt = <3275000>;
-				regulator-max-microvolt = <3325000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_LDO4: LDO4 { /* V1.8_LPSR */
-				regulator-min-microvolt = <1775000>;
-				regulator-max-microvolt = <1825000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			reg_LDO5: LDO5 { /* PWR_EN_+V3.3 */
-				regulator-min-microvolt = <1775000>;
-				regulator-max-microvolt = <1825000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.12.1
