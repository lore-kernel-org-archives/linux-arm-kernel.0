From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:35 +0100
Subject: [PATCH 05/69] arm64: dts: renesas: r8a7795: add thermal cooling
 management
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <0c38c54ef9bc2a1062900adb01833e0b824f8462.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Add nodes and properties for thermal cooling management support.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1485e6a8e112..19b7de57704c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -43,6 +43,7 @@
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		a57_1: cpu at 1 {
@@ -54,6 +55,7 @@
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		a57_2: cpu at 2 {
@@ -65,6 +67,7 @@
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		a57_3: cpu at 3 {
@@ -76,6 +79,7 @@
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		a53_0: cpu at 100 {
@@ -2418,12 +2422,24 @@
 			thermal-sensors = <&tsc 0>;
 
 			trips {
+				sensor1_passive: sensor1-passive {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				sensor1_crit: sensor1-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&sensor1_passive>;
+					cooling-device = <&a57_0 4 4>;
+				};
+			};
 		};
 
 		sensor_thermal2: sensor-thermal2 {
@@ -2432,12 +2448,24 @@
 			thermal-sensors = <&tsc 1>;
 
 			trips {
+				sensor2_passive: sensor2-passive {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				sensor2_crit: sensor2-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&sensor2_passive>;
+					cooling-device = <&a57_0 4 4>;
+				};
+			};
 		};
 
 		sensor_thermal3: sensor-thermal3 {
@@ -2446,12 +2474,24 @@
 			thermal-sensors = <&tsc 2>;
 
 			trips {
+				sensor3_passive: sensor3-passive {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&sensor3_passive>;
+					cooling-device = <&a57_0 4 4>;
+				};
+			};
 		};
 	};
 
-- 
2.11.0
