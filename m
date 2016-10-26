From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 27 Oct 2016 01:37:38 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add CPU clocks and OPP table for Pro5
 SoC
Message-ID: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CPU clock to every CPU node and a CPU OPP table to use the
generic cpufreq driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pro5.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 5357ea9..5bd6068 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -56,16 +56,90 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
+		};
+	};
+
+	cpu_opp: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 116667000 {
+			opp-hz = /bits/ 64 <116667000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 175000000 {
+			opp-hz = /bits/ 64 <175000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 233334000 {
+			opp-hz = /bits/ 64 <233334000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 350000000 {
+			opp-hz = /bits/ 64 <350000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 466667000 {
+			opp-hz = /bits/ 64 <466667000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 933334000 {
+			opp-hz = /bits/ 64 <933334000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			clock-latency-ns = <300>;
 		};
 	};
 
-- 
1.9.1
