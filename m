From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:32 +0530
Subject: [PATCH 09/10] ARM64: dts: rockchip: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <ee0bd5fb56652141e5ce23927b258b1779844af6.1542362530.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/rockchip/rk3328.dtsi          |  5 ++++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi          | 15 ++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts |  8 ++++++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          | 12 +++++++++---
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index e1a33dd981e0..ecd7f19c3542 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -479,7 +479,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&target>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 9c24de1ba43c..7014d10b954c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -426,12 +426,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
-					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -459,7 +465,10 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 2cc7c47d6a85..81e73103fa78 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -118,13 +118,17 @@
 			map0 {
 				trip = <&ppvar_bigcpu_alert>;
 				cooling-device =
-					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				contribution = <4096>;
 			};
 			map1 {
 				trip = <&ppvar_bigcpu_alert>;
 				cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				contribution = <1024>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 99e7f65c1779..d4ebffc28953 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -770,13 +770,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
 						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -804,7 +809,8 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a
