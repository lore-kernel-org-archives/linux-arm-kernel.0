From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 16 Oct 2016 23:59:17 +0900
Subject: [PATCH 2/3] arm64: dts: uniphier: add CPU clock and OPP table for
 LD11 SoC
In-Reply-To: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476629958-25368-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1476629958-25368-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CPU clock to every CPU node and a CPU OPP table to use the
generic cpufreq driver.

Note:
clock-latency-ns (300ns) was calculated based on the CPU-gear switch
sequencer spec; it takes 12 clock cycles on the sequencer running
at 50 MHz, plus a bit additional latency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 73e0acf..e3eb10f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -70,14 +70,18 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x000>;
+			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0 0x001>;
+			clocks = <&sys_clk 33>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 	};
 
@@ -86,6 +90,40 @@
 		method = "smc";
 	};
 
+	cluster0_opp: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 245000000 {
+			opp-hz = /bits/ 64 <245000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 490000000 {
+			opp-hz = /bits/ 64 <490000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 653333333 {
+			opp-hz = /bits/ 64 <653334000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 666666666 {
+			opp-hz = /bits/ 64 <666667000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 980000000 {
+			opp-hz = /bits/ 64 <980000000>;
+			clock-latency-ns = <300>;
+		};
+	};
+
 	clocks {
 		refclk: ref {
 			compatible = "fixed-clock";
-- 
1.9.1
