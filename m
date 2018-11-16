From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:25 +0530
Subject: [PATCH 02/10] ARM64: dts: exynos: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index fe3a0b14bee6..81b72393dd0d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -55,37 +55,44 @@ thermal-zones {
 			map0 {
 				/* Set maximum frequency as 1800MHz  */
 				trip = <&atlas0_alert_0>;
-				cooling-device = <&cpu4 1 2>;
+				cooling-device = <&cpu4 1 2>, <&cpu5 1 2>,
+						 <&cpu6 1 2>, <&cpu7 1 2>;
 			};
 			map1 {
 				/* Set maximum frequency as 1700MHz  */
 				trip = <&atlas0_alert_1>;
-				cooling-device = <&cpu4 2 3>;
+				cooling-device = <&cpu4 2 3>, <&cpu5 2 3>,
+						 <&cpu6 2 3>, <&cpu7 2 3>;
 			};
 			map2 {
 				/* Set maximum frequency as 1600MHz  */
 				trip = <&atlas0_alert_2>;
-				cooling-device = <&cpu4 3 4>;
+				cooling-device = <&cpu4 3 4>, <&cpu5 3 4>,
+						 <&cpu6 3 4>, <&cpu7 3 4>;
 			};
 			map3 {
 				/* Set maximum frequency as 1500MHz  */
 				trip = <&atlas0_alert_3>;
-				cooling-device = <&cpu4 4 5>;
+				cooling-device = <&cpu4 4 5>, <&cpu5 4 5>,
+						 <&cpu6 4 5>, <&cpu7 4 5>;
 			};
 			map4 {
 				/* Set maximum frequency as 1400MHz  */
 				trip = <&atlas0_alert_4>;
-				cooling-device = <&cpu4 5 7>;
+				cooling-device = <&cpu4 5 7>, <&cpu5 5 7>,
+						 <&cpu6 5 7>, <&cpu7 5 7>;
 			};
 			map5 {
 				/* Set maximum frequencyas 1200MHz  */
 				trip = <&atlas0_alert_5>;
-				cooling-device = <&cpu4 7 9>;
+				cooling-device = <&cpu4 7 9>, <&cpu5 7 9>,
+						 <&cpu6 7 9>, <&cpu7 7 9>;
 			};
 			map6 {
 				/* Set maximum frequency as 1000MHz  */
 				trip = <&atlas0_alert_6>;
-				cooling-device = <&cpu4 9 14>;
+				cooling-device = <&cpu4 9 14>, <&cpu5 9 14>,
+						 <&cpu6 9 14>, <&cpu7 9 14>;
 			};
 		};
 	};
@@ -222,27 +229,32 @@ thermal-zones {
 			map0 {
 				/* Set maximum frequency as 1200MHz  */
 				trip = <&apollo_alert_2>;
-				cooling-device = <&cpu0 1 2>;
+				cooling-device = <&cpu0 1 2>, <&cpu1 1 2>,
+						 <&cpu2 1 2>, <&cpu3 1 2>;
 			};
 			map1 {
 				/* Set maximum frequency as 1100MHz  */
 				trip = <&apollo_alert_3>;
-				cooling-device = <&cpu0 2 3>;
+				cooling-device = <&cpu0 2 3>, <&cpu1 2 3>,
+						 <&cpu2 2 3>, <&cpu3 2 3>;
 			};
 			map2 {
 				/* Set maximum frequency as 1000MHz  */
 				trip = <&apollo_alert_4>;
-				cooling-device = <&cpu0 3 4>;
+				cooling-device = <&cpu0 3 4>, <&cpu1 3 4>,
+						 <&cpu2 3 4>, <&cpu3 3 4>;
 			};
 			map3 {
 				/* Set maximum frequency as 900MHz  */
 				trip = <&apollo_alert_5>;
-				cooling-device = <&cpu0 4 5>;
+				cooling-device = <&cpu0 4 5>, <&cpu1 4 5>,
+						 <&cpu2 4 5>, <&cpu3 4 5>;
 			};
 			map4 {
 				/* Set maximum frequency as 800MHz  */
 				trip = <&apollo_alert_6>;
-				cooling-device = <&cpu0 5 9>;
+				cooling-device = <&cpu0 5 9>, <&cpu1 5 9>,
+						 <&cpu2 5 9>, <&cpu3 5 9>;
 			};
 		};
 	};
-- 
2.19.1.568.g152ad8e3369a
