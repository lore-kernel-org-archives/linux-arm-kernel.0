From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Mar 2018 10:40:45 +0100
Subject: [PATCH 2/3] arm64: dts: renesas: r8a7795: sort subnodes of the cpu
 node
In-Reply-To: <20180307094046.4907-1-horms+renesas@verge.net.au>
References: <20180307094046.4907-1-horms+renesas@verge.net.au>
Message-ID: <20180307094046.4907-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the cpu node alphanumerically.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 88 ++++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 119c245b4ee2..d2ecb1dfa487 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -34,6 +34,50 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		a53_0: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		a53_1: cpu at 101 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		a53_2: cpu at 102 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x102>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		a53_3: cpu at 103 {
+			compatible = "arm,cortex-a53","arm,armv8";
+			reg = <0x103>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
 		a57_0: cpu at 0 {
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
@@ -82,50 +126,6 @@
 			#cooling-cells = <2>;
 		};
 
-		a53_0: cpu at 100 {
-			compatible = "arm,cortex-a53", "arm,armv8";
-			reg = <0x100>;
-			device_type = "cpu";
-			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
-			next-level-cache = <&L2_CA53>;
-			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
-			operating-points-v2 = <&cluster1_opp>;
-		};
-
-		a53_1: cpu at 101 {
-			compatible = "arm,cortex-a53","arm,armv8";
-			reg = <0x101>;
-			device_type = "cpu";
-			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
-			next-level-cache = <&L2_CA53>;
-			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
-			operating-points-v2 = <&cluster1_opp>;
-		};
-
-		a53_2: cpu at 102 {
-			compatible = "arm,cortex-a53","arm,armv8";
-			reg = <0x102>;
-			device_type = "cpu";
-			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
-			next-level-cache = <&L2_CA53>;
-			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
-			operating-points-v2 = <&cluster1_opp>;
-		};
-
-		a53_3: cpu at 103 {
-			compatible = "arm,cortex-a53","arm,armv8";
-			reg = <0x103>;
-			device_type = "cpu";
-			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
-			next-level-cache = <&L2_CA53>;
-			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
-			operating-points-v2 = <&cluster1_opp>;
-		};
-
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
 			power-domains = <&sysc R8A7795_PD_CA57_SCU>;
-- 
2.11.0
