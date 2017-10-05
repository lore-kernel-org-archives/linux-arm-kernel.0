From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Oct 2017 15:26:23 +0200
Subject: [PATCH v2 1/2] arm64: dts: r8a7795: Add OPPs table for cpu devices
In-Reply-To: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1507209984-17123-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@rvc.renesas.com>

Current, OPP tables are defined temporary,
they are being evaluated and adjust in future.

Based in part on work by Hien Dang.

Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2 [Simon Horman]
- Only provide one operating points node for each operating-points-v2 node
  as per the binding; other nodes were unused and have been removed

v1 [Simon Horman]
- consolidated several patches into one

v0 [Dien Pham]
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d5cfd1a1c539..9cf63a1f0c35 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -46,6 +46,8 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_1: cpu at 1 {
@@ -55,6 +57,7 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_2: cpu at 2 {
@@ -64,6 +67,7 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU2>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_3: cpu at 3 {
@@ -73,6 +77,7 @@
 			power-domains = <&sysc R8A7795_PD_CA57_CPU3>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a53_0: cpu at 100 {
@@ -82,6 +87,8 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_1: cpu at 101 {
@@ -91,6 +98,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_2: cpu at 102 {
@@ -100,6 +108,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_3: cpu at 103 {
@@ -109,6 +118,7 @@
 			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		L2_CA57: cache-controller-0 {
@@ -126,6 +136,51 @@
 		};
 	};
 
+	cluster0_opp: opp_table0 {
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
+	cluster1_opp: opp_table1 {
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
