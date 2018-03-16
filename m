From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:32 +0100
Subject: [PATCH 02/69] arm64: dts: renesas: r8a7795: Add OPPs table for cpu
 devices
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <dd149e851ace00a7832846e46ddefc6b181522c2.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

Define OOP tables for all CPUs.
This allows CPUFreq to function.

Based in part on work by Hien Dang.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 24e9209ea54e..1485e6a8e112 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -41,6 +41,8 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_1: cpu at 1 {
@@ -50,6 +52,8 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_2: cpu at 2 {
@@ -59,6 +63,8 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU2>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_3: cpu at 3 {
@@ -68,6 +74,8 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU3>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a53_0: cpu at 100 {
@@ -77,6 +85,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_1: cpu at 101 {
@@ -86,6 +96,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_2: cpu at 102 {
@@ -95,6 +107,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_3: cpu at 103 {
@@ -104,6 +118,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		L2_CA57: cache-controller-0 {
@@ -165,6 +181,51 @@
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <960000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
 	/* External PCIe clock - can be overridden by the board */
 	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
-- 
2.11.0
