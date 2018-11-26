From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:55:06 +0100
Subject: [PATCH 40/40] arm64: dts: renesas: Add all CPUs in cooling maps
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <275e4eb3f21a09b6b8bd4a353b9a01e500240385.1543229516.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 15 ++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi |  6 +++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e94a5f2dbd08..8643ecb1a3f3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -3115,7 +3115,10 @@
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
@@ -3141,7 +3144,10 @@
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
@@ -3167,7 +3173,10 @@
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
index e7614b781308..afedbf5728ec 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2839,7 +2839,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor1_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2865,7 +2865,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor2_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
@@ -2891,7 +2891,7 @@
 			cooling-maps {
 				map0 {
 					trip = <&sensor3_passive>;
-					cooling-device = <&a57_0 5 5>;
+					cooling-device = <&a57_0 5 5>, <&a57_1 5 5>;
 				};
 			};
 		};
-- 
2.11.0
