From: tobetter@gmail.com (tobetter at gmail.com)
Date: Sat, 28 Oct 2017 13:32:48 -0400
Subject: [PATCH] ARM: dts: exynos: fix property values of LDO15/17 for
 ODROID-XU3/4
Message-ID: <20171028173329.15368-1-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dongjin Kim <tobetter@gmail.com>

Looking at the schematic, LDO15 and LDO17 are tied as a power source of a
builtin network chipset. The voltage on LDO15 is corrected to 3.3V and the
name of LDO17 is corrected to "vdd_ldo17".

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index a183b56283f8..68780569371d 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -372,8 +372,8 @@
 
 			ldo15_reg: LDO15 {
 				regulator-name = "vdd_ldo15";
-				regulator-min-microvolt = <3100000>;
-				regulator-max-microvolt = <3100000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
@@ -385,7 +385,7 @@
 			};
 
 			ldo17_reg: LDO17 {
-				regulator-name = "tsp_avdd";
+				regulator-name = "vdd_ldo17";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
-- 
2.11.0
