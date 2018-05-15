From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 15 May 2018 10:53:13 +0800
Subject: [PATCH v2 3/5] arm64: dts: hi3660: Add CPU frequency scaling support
In-Reply-To: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
References: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1526352795-6991-4-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two CPU OPP tables, one table is corresponding to one cluster,
which allow CPU frequency scaling on hi3660 platforms.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3a3bcff..a39da09 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -62,6 +62,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu at 1 {
@@ -72,6 +74,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu at 2 {
@@ -82,6 +86,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu at 3 {
@@ -92,6 +98,8 @@
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <592>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu4: cpu at 100 {
@@ -102,6 +110,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu5: cpu at 101 {
@@ -112,6 +122,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu6: cpu at 102 {
@@ -122,6 +134,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		cpu7: cpu at 103 {
@@ -132,6 +146,8 @@
 			next-level-cache = <&A73_L2>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 			capacity-dmips-mhz = <1024>;
+			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		idle-states {
@@ -174,6 +190,76 @@
 		};
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <533000000>;
+			opp-microvolt = <700000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp01 {
+			opp-hz = /bits/ 64 <999000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp02 {
+			opp-hz = /bits/ 64 <1402000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp03 {
+			opp-hz = /bits/ 64 <1709000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp04 {
+			opp-hz = /bits/ 64 <1844000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp10 {
+			opp-hz = /bits/ 64 <903000000>;
+			opp-microvolt = <700000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp11 {
+			opp-hz = /bits/ 64 <1421000000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp12 {
+			opp-hz = /bits/ 64 <1805000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp13 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp14 {
+			opp-hz = /bits/ 64 <2362000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
 	gic: interrupt-controller at e82b0000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xe82b1000 0 0x1000>, /* GICD */
-- 
1.9.1
