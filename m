From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:26 +0530
Subject: [PATCH 03/10] ARM64: dts: fsl: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <c92e66ea7e0692b13c8088d0a554acfeacf74cf4.1542362530.git.viresh.kumar@linaro.org>
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
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 17 ++++++-----
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 28 ++++++-------------
 4 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504b5381..c7224c5bb6cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -171,8 +171,10 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50012d6..8c94d8279b5e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -140,8 +140,10 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612ab56b..7faee0d270d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -152,15 +152,14 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774a36e8..f11187f7465c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -101,26 +101,14 @@
 				map0 {
 					trip = <&cpu_alert>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu2 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map2 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu4 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
-				};
-				map3 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&cpu6 THERMAL_NO_LIMIT
-						THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a
