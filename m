From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:31 +0530
Subject: [PATCH 08/10] ARM64: dts: renesas: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 15 ++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi |  6 +++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a79c8d369e0b..3a662df32143 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2878,7 +2878,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
@@ -2904,7 +2907,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
@@ -2930,7 +2936,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 4 4>;
+					cooling-device = <&a57_0 4 4>,
+							 <&a57_1 4 4>,
+							 <&a57_2 4 4>,
+							 <&a57_3 4 4>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 1ec6aaa520c1..dd95e937f87a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2526,7 +2526,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2552,7 +2552,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2578,7 +2578,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a
