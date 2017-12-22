From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:12 +0100
Subject: [PATCH 01/11] arm64: dts: renesas: r8a7795: Move nodes which have no
 reg property out of bus
In-Reply-To: <cover.1513936760.git.horms+renesas@verge.net.au>
References: <cover.1513936760.git.horms+renesas@verge.net.au>
Message-ID: <4f5dc77b83503b5a0f8c974dcbd85749850514f3.1513936761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pmu_a5[73], timer and thermal-zones nodes from soc node to root node.
The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

This problem is flagged by the compiler as follows:
$ make
...
  DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb
arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb
arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 138 ++++++++++++++++---------------
 1 file changed, 71 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 6db4f10376a1..a851c88e1e04 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -184,6 +184,30 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+		                      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>,
+				     <&a57_1>,
+				     <&a57_2>,
+				     <&a57_3>;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>,
+				     <&a53_1>,
+				     <&a53_2>,
+				     <&a53_3>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -338,42 +362,6 @@
 			resets = <&cpg 905>;
 		};
 
-		pmu_a57 {
-			compatible = "arm,cortex-a57-pmu";
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&a57_0>,
-					     <&a57_1>,
-					     <&a57_2>,
-					     <&a57_3>;
-		};
-
-		pmu_a53 {
-			compatible = "arm,cortex-a53-pmu";
-			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&a53_0>,
-					     <&a53_1>,
-					     <&a53_2>,
-					     <&a53_3>;
-		};
-
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7795-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -2331,47 +2319,63 @@
 			#thermal-sensor-cells = <1>;
 			status = "okay";
 		};
+	};
 
-		thermal-zones {
-			sensor_thermal1: sensor-thermal1 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 0>;
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13
+				       (GIC_CPU_MASK_SIMPLE(8) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14
+				       (GIC_CPU_MASK_SIMPLE(8) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11
+				       (GIC_CPU_MASK_SIMPLE(8) |
+				       IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10
+				       (GIC_CPU_MASK_SIMPLE(8) |
+				       IRQ_TYPE_LEVEL_LOW)>;
+	};
 
-				trips {
-					sensor1_crit: sensor1-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
 				};
 			};
+		};
 
-			sensor_thermal2: sensor-thermal2 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 1>;
+		sensor_thermal2: sensor-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 1>;
 
-				trips {
-					sensor2_crit: sensor2-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
+			trips {
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
 				};
 			};
+		};
 
-			sensor_thermal3: sensor-thermal3 {
-				polling-delay-passive = <250>;
-				polling-delay = <1000>;
-				thermal-sensors = <&tsc 2>;
+		sensor_thermal3: sensor-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 2>;
 
-				trips {
-					sensor3_crit: sensor3-crit {
-						temperature = <120000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
+			trips {
+				sensor3_crit: sensor3-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
 				};
 			};
 		};
-- 
2.11.0
