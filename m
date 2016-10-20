From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 20 Oct 2016 10:15:26 +0900
Subject: [PATCH v2 2/2] arm64: dts: uniphier: add CPU clocks and OPP tables
 for LD20 SoC
In-Reply-To: <1476926126-6079-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476926126-6079-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1476926126-6079-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CPU clock to every CPU node and CPU OPP tables to use the
generic cpufreq driver.  All the CPUs in each cluster share the
same OPP table.

Note:
clock-latency-ns (300ns) was calculated based on the CPU-gear switch
sequencer spec; it takes 12 clock cycles on the sequencer running
at 50 MHz, plus a bit additional latency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Match the node name to the opp-hz property.

 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 6f48e82..7404678 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -79,28 +79,36 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x000>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72", "arm,armv8";
 			reg = <0 0x001>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x100>;
+			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu3: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x101>;
+			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster1_opp>;
 		};
 	};
 
@@ -109,6 +117,82 @@
 		method = "smc";
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 666667000 {
+			opp-hz = /bits/ 64 <666667000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 733334000 {
+			opp-hz = /bits/ 64 <733334000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			clock-latency-ns = <300>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 666666666 {
+			opp-hz = /bits/ 64 <666667000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 733333333 {
+			opp-hz = /bits/ 64 <733334000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			clock-latency-ns = <300>;
+		};
+	};
+
 	clocks {
 		refclk: ref {
 			compatible = "fixed-clock";
-- 
1.9.1
