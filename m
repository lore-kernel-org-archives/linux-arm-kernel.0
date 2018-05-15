From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 15 May 2018 14:37:54 +0200
Subject: [PATCH] arm64: dts: exynos: fix type of thermal trip points for
 Exynos7
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
Message-ID: <1702366.qL959G52Hi@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently Exynos thermal driver treats as "active" all specified
trip points before reaching maximum number of hardware supported
trip points. Moreover polling-delay-passive is specified as "0"
in exynos7.dtsi (IOW passive polling is disabled). Therefore fix
type of cpu-alert-0 to cpu-alert6 trip points to be "active"
instead of "passive" (cpu-alert-7 type is "critical" so it
doesn't need a fixup).

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
===================================================================
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi	2018-05-15 13:57:55.822172496 +0200
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi	2018-05-15 14:23:12.594016481 +0200
@@ -10,37 +10,37 @@ trips {
 	cpu-alert-0 {
 		temperature = <75000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-1 {
 		temperature = <80000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-2 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-3 {
 		temperature = <90000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-4 {
 		temperature = <95000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-5 {
 		temperature = <100000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-alert-6 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "passive";
+		type = "active";
 	};
 	cpu-crit-0 {
 		temperature = <115000>; /* millicelsius */
