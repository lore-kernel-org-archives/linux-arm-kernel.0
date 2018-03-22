From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 22 Mar 2018 11:24:20 +0100
Subject: [PATCH v2 1/4] arm64: dts: renesas: r8a7795: sort subnodes of the
 root node
In-Reply-To: <20180322102423.18269-1-horms+renesas@verge.net.au>
References: <20180322102423.18269-1-horms+renesas@verge.net.au>
Message-ID: <20180322102423.18269-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the root node alphanumerically.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Also sort clock nodes
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 84 ++++++++++++++++----------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1d5e3ac0231c..800bb7429240 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -30,6 +30,36 @@
 		i2c7 = &i2c_dvfs;
 	};
 
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock - to be overridden by boards that provide it */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -155,36 +185,6 @@
 		clock-frequency = <0>;
 	};
 
-	/*
-	 * The external audio clocks are configured as 0 Hz fixed frequency
-	 * clocks by default.
-	 * Boards that provide audio clocks should override them.
-	 */
-	audio_clk_a: audio_clk_a {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_b: audio_clk_b {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_c: audio_clk_c {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	/* External CAN clock - to be overridden by boards that provide it */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	cluster0_opp: opp_table0 {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -247,18 +247,6 @@
 		clock-frequency = <0>;
 	};
 
-	pmu_a57 {
-		compatible = "arm,cortex-a57-pmu";
-		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-		                      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&a57_0>,
-				     <&a57_1>,
-				     <&a57_2>,
-				     <&a57_3>;
-	};
-
 	pmu_a53 {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
@@ -271,6 +259,18 @@
 				     <&a53_3>;
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
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.11.0
