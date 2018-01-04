From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:14 +0200
Subject: [PATCH v2 10/11] DT: QCOM: Add cpufreq-dt to msm8996
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-11-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree frequency table for the MSM8996 to be
used by the upstream cpufreq-dt driver with the clk-cpu-8996
driver as infrastructure.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi       | 184 ++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |   3 +
 3 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 230e9c8..da23bda 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -17,5 +17,5 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
+	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4b2afcc..8beea7e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -86,6 +86,8 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&kryocc 0>;
+			operating-points-v2 = <&cluster0_opp>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -98,6 +100,8 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			clocks = <&kryocc 0>;
+			operating-points-v2 = <&cluster0_opp>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -106,6 +110,8 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			clocks = <&kryocc 1>;
+			operating-points-v2 = <&cluster1_opp>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -118,6 +124,8 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			clocks = <&kryocc 1>;
+			operating-points-v2 = <&cluster1_opp>;
 			next-level-cache = <&L2_1>;
 		};
 
@@ -144,6 +152,182 @@
 		};
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 307200000 {
+			opp-hz = /bits/ 64 <  307200000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 422400000 {
+			opp-hz = /bits/ 64 <  422400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 480000000 {
+			opp-hz = /bits/ 64 <  480000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 556800000 {
+			opp-hz = /bits/ 64 <  556800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 652800000 {
+			opp-hz = /bits/ 64 <  652800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 729600000 {
+			opp-hz = /bits/ 64 <  729600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 844800000 {
+			opp-hz = /bits/ 64 <  844800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 960000000 {
+			opp-hz = /bits/ 64 <  960000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1036800000 {
+			opp-hz = /bits/ 64 < 1036800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1113600000 {
+			opp-hz = /bits/ 64 < 1113600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1190400000 {
+			opp-hz = /bits/ 64 < 1190400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1228800000 {
+			opp-hz = /bits/ 64 < 1228800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1324800000 {
+			opp-hz = /bits/ 64 < 1324800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1401600000 {
+			opp-hz = /bits/ 64 < 1401600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1478400000 {
+			opp-hz = /bits/ 64 < 1478400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1593600000 {
+			opp-hz = /bits/ 64 < 1593600000 >;
+			clock-latency-ns = <200000>;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 307200000 {
+			opp-hz = /bits/ 64 <  307200000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 403200000 {
+			opp-hz = /bits/ 64 <  403200000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 480000000 {
+			opp-hz = /bits/ 64 <  480000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 556800000 {
+			opp-hz = /bits/ 64 <  556800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 652800000 {
+			opp-hz = /bits/ 64 <  652800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 729600000 {
+			opp-hz = /bits/ 64 <  729600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 806400000 {
+			opp-hz = /bits/ 64 <  806400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 883200000 {
+			opp-hz = /bits/ 64 <  883200000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 940800000 {
+			opp-hz = /bits/ 64 <  940800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1036800000 {
+			opp-hz = /bits/ 64 < 1036800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1113600000 {
+			opp-hz = /bits/ 64 < 1113600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1190400000 {
+			opp-hz = /bits/ 64 < 1190400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1248000000 {
+			opp-hz = /bits/ 64 < 1248000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1324800000 {
+			opp-hz = /bits/ 64 < 1324800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1401600000 {
+			opp-hz = /bits/ 64 < 1401600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1478400000 {
+			opp-hz = /bits/ 64 < 1478400000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1552000000 {
+			opp-hz = /bits/ 64 < 1552000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1632000000 {
+			opp-hz = /bits/ 64 < 1632000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1708800000 {
+			opp-hz = /bits/ 64 < 1708800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1785600000 {
+			opp-hz = /bits/ 64 < 1785600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1824000000 {
+			opp-hz = /bits/ 64 < 1824000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1920000000 {
+			opp-hz = /bits/ 64 < 1920000000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 1996800000 {
+			opp-hz = /bits/ 64 < 1996800000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 2073600000 {
+			opp-hz = /bits/ 64 < 2073600000 >;
+			clock-latency-ns = <200000>;
+		};
+		opp at 2150400000 {
+			opp-hz = /bits/ 64 < 2150400000 >;
+			clock-latency-ns = <200000>;
+		};
+
+	};
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ecc56e2..0feca0e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -95,6 +95,9 @@
 	{ .compatible = "xlnx,zynq-7000", },
 	{ .compatible = "xlnx,zynqmp", },
 
+	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,apq8096", },
+
 	{ }
 };
 
-- 
1.9.1
