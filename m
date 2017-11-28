From: tobetter@gmail.com (Dongjin Kim)
Date: Mon, 27 Nov 2017 19:15:01 -0500
Subject: [REBASED PATCH] ARM: dts: exynos: fix property values of LDO15/17 for
 ODROID-XU3/4
Message-ID: <20171128001501.12740-1-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at the schematic, LDO15 and LDO17 are tied as a power source of a
builtin network chipset. The voltage on LDO15 is corrected to 3.3V and the
name of LDO17 is corrected to "vdd_ldo17".

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index a5b8d0f0877e..81cbb77204a8 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -233,8 +233,8 @@
 
 			ldo15_reg: LDO15 {
 				regulator-name = "vdd_ldo15";
-				regulator-min-microvolt = <3100000>;
-				regulator-max-microvolt = <3100000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
@@ -246,7 +246,7 @@
 			};
 
 			ldo17_reg: LDO17 {
-				regulator-name = "tsp_avdd";
+				regulator-name = "vdd_ldo17";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
-- 
2.11.0
