From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon,  6 Aug 2018 18:09:32 +0200
Subject: [PATCH 3/4] ARM: dts: exynos: Disable unused PMIC regulators on
 Exynos5422 Odroid boards
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
Message-ID: <20180806160933.6578-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable unused PMIC regulators on Exynos5422 Odroid boards to reduce
energy used. According to schematics:
1. LDO12, LDO16 and LDO24 are not connected,
2. LDO26 is not used on Odroid HC1.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 26 +++++++++++-----------
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  6 +++++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 744fd86a38ad..b0dc9cc81b94 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -223,10 +223,10 @@
 			};
 
 			ldo12_reg: LDO12 {
+				/* Unused */
 				regulator-name = "vdd_ldo12";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
 			};
 
 			ldo13_reg: LDO13 {
@@ -250,10 +250,10 @@
 			};
 
 			ldo16_reg: LDO16 {
+				/* Unused */
 				regulator-name = "vdd_ldo16";
-				regulator-min-microvolt = <2200000>;
-				regulator-max-microvolt = <2200000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo17_reg: LDO17 {
@@ -304,10 +304,10 @@
 			};
 
 			ldo24_reg: LDO24 {
-				regulator-name = "tsp_io";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
+				/* Unused */
+				regulator-name = "vdd_ldo24";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo25_reg: LDO25 {
@@ -318,10 +318,10 @@
 			};
 
 			ldo26_reg: LDO26 {
+				/* Used on XU3, XU3-Lite and XU4 */
 				regulator-name = "vdd_ldo26";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
 			};
 
 			ldo27_reg: LDO27 {
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c0a118..e522edb2bb82 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -367,6 +367,12 @@
 	status = "okay";
 };
 
+&ldo26_reg {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+};
+
 &mixer {
 	status = "okay";
 };
-- 
2.14.1
