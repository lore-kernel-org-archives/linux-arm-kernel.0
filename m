From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Dec 2015 18:30:29 +0100
Subject: [PATCH v3 04/10] ARM: dts: Exynos5420: add CPU OPP and regulator
 supply property
In-Reply-To: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449250235-9613-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos5420 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 122 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..f8f70a5 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,6 +50,116 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 at 1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 at 1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp08 at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp09 at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp10 at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp11 at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00 at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01 at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp02 at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp03 at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp04 at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp05 at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06 at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07 at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <937500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -58,8 +168,11 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu-cluster.0";
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu at 1 {
@@ -68,6 +181,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu at 2 {
@@ -76,6 +190,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu at 3 {
@@ -84,14 +199,18 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu4: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
+			clocks = <&clock CLK_KFC_CLK>;
+			clock-names = "cpu-cluster.1";
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu5: cpu at 101 {
@@ -100,6 +219,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu6: cpu at 102 {
@@ -108,6 +228,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 
 		cpu7: cpu at 103 {
@@ -116,6 +237,7 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			operating-points-v2 = <&cpu1_opp_table>;
 		};
 	};
 
-- 
1.9.1
