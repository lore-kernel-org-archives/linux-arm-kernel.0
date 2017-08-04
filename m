From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Aug 2017 15:26:20 +0200
Subject: [PATCH] arm64: dts: r8a7795: Add OPPs table for cpu devices
Message-ID: <1501853180-23939-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

Current, OPP tables are defined temporary,
they are being evaluated and adjust in future.

Based in part on work by Hien Dang.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: consolidated sseveral patches into one]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 309 +++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

I am not aware of any build-time depdendencies of this patch.

This patch has run-time depdnencies on:
* [PATCH] cpufreq: rcar: Add support for R8A7795 SoC
* [PATCH 0/4] r8a7795: Add Z and Z2 clock support

I have provided an integration patch with this patch, those DTS changes,
and Renesas clock updates also depended on by the DTS changes. The result
is working CPUFreq for the r8a7795 (R-Car H3) ES1.0.

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/r8a7795-cpufreq

A description of steps taken to lightly exercise the above can be found here:

http://elinux.org/Tests:R-CAR-GEN3-CPUFreq

If this work is acceptable I plan to follow up with patches to
enable CPUFreq on the r8a7796 (R-Car M3-W).

This patch is based on renesas-arm64-dt-for-v4.14

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a87ae76880ab..f34da4c9ea52 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -46,6 +46,12 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp_tb0>,
+				<&cluster0_opp_tb1>, <&cluster0_opp_tb2>,
+				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
+				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
+				<&cluster0_opp_tb7>;
 		};
 
 		a57_1: cpu at 1 {
@@ -55,6 +61,11 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp_tb0>,
+				<&cluster0_opp_tb1>, <&cluster0_opp_tb2>,
+				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
+				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
+				<&cluster0_opp_tb7>;
 		};
 
 		a57_2: cpu at 2 {
@@ -64,6 +75,11 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU2>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp_tb0>,
+				<&cluster0_opp_tb1>, <&cluster0_opp_tb2>,
+				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
+				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
+				<&cluster0_opp_tb7>;
 		};
 
 		a57_3: cpu at 3 {
@@ -73,6 +89,11 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU3>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp_tb0>,
+				<&cluster0_opp_tb1>, <&cluster0_opp_tb2>,
+				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
+				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
+				<&cluster0_opp_tb7>;
 		};
 
 		a53_0: cpu at 100 {
@@ -82,6 +103,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp_tb0>;
 		};
 
 		a53_1: cpu at 101 {
@@ -91,6 +114,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp_tb0>;
 		};
 
 		a53_2: cpu at 102 {
@@ -100,6 +124,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp_tb0>;
 		};
 
 		a53_3: cpu at 103 {
@@ -109,6 +134,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp_tb0>;
 		};
 
 		L2_CA57: cache-controller-0 {
@@ -126,6 +152,289 @@
 		};
 	};
 
+	cluster0_opp_tb0: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <960000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb1: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <890000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb2: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <810000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <810000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <810000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <880000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <930000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb3: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <870000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <910000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb4: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <790000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <790000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <790000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <860000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <890000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb5: opp_table5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <780000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <780000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <780000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <850000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <880000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb6: opp_table6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <770000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <770000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <770000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <840000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <870000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster0_opp_tb7: opp_table7 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <760000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <760000>;
+			clock-latency-ns = <300000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <760000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <860000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp_tb0: opp_table10 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
 	extal_clk: extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.1.4
