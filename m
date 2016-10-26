From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 27 Oct 2016 01:37:39 +0900
Subject: [PATCH 2/2] ARM: dts: uniphier: add CPU clocks and OPP table for PXs2
 SoC
In-Reply-To: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
References: <1477499859-12415-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1477499859-12415-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a CPU clock to every CPU node and a CPU OPP table to use the
generic cpufreq driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pxs2.dtsi | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 950f07b..83ba3e6 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -56,32 +56,78 @@
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
 		};
 
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&sys_clk 32>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			operating-points-v2 = <&cpu_opp>;
 		};
 
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
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
+		opp at 150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			clock-latency-ns = <300>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			clock-latency-ns = <300>;
 		};
 	};
 
-- 
1.9.1
