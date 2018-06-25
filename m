From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:01 +0200
Subject: [PATCH 06/29] arm64: dts: renesas: r8a77980: add SMP support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <2ec1e4b4a815ee872fb29753f4872abf1a2e62a4.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
delivery masks for the ARM GIC and Architectured Timer.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: corrected whitespace]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 40 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 4c40f9f0ebc9..6d2b61d83caf 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -30,6 +30,36 @@
 			enable-method = "psci";
 		};
 
+		a53_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <1>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <2>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <3>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA53: cache-controller {
 			compatible = "cache";
 			power-domains = <&sysc R8A77980_PD_CA53_SCU>;
@@ -408,7 +438,7 @@
 			      <0x0 0xf1020000 0 0x20000>,
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
+			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(4) |
 				      IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
@@ -424,13 +454,13 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
-- 
2.11.0
