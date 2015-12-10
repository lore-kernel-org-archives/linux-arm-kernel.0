From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 10 Dec 2015 17:58:45 +0100
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

For Exynos542x/5800 platforms, add CPU operating points
for migrating from Exynos specific cpufreq driver to using
generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch
- merged Exynos5422 fixes from Ben

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi      | 122 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi |  10 +++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..616c2d0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,6 +50,116 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp at 1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp at 600000000 {
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
 
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index b7f60c8..9a5131d 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -20,8 +20,10 @@
 	device_type = "cpu";
 	compatible = "arm,cortex-a7";
 	reg = <0x100>;
+	clocks = <&clock CLK_KFC_CLK>;
 	clock-frequency = <1000000000>;
 	cci-control-port = <&cci_control0>;
+	operating-points-v2 = <&cpu1_opp_table>;
 };
 
 &cpu1 {
@@ -30,6 +32,7 @@
 	reg = <0x101>;
 	clock-frequency = <1000000000>;
 	cci-control-port = <&cci_control0>;
+	operating-points-v2 = <&cpu1_opp_table>;
 };
 
 &cpu2 {
@@ -38,6 +41,7 @@
 	reg = <0x102>;
 	clock-frequency = <1000000000>;
 	cci-control-port = <&cci_control0>;
+	operating-points-v2 = <&cpu1_opp_table>;
 };
 
 &cpu3 {
@@ -46,14 +50,17 @@
 	reg = <0x103>;
 	clock-frequency = <1000000000>;
 	cci-control-port = <&cci_control0>;
+	operating-points-v2 = <&cpu1_opp_table>;
 };
 
 &cpu4 {
 	device_type = "cpu";
 	compatible = "arm,cortex-a15";
 	reg = <0x0>;
+	clocks = <&clock CLK_ARM_CLK>;
 	clock-frequency = <1800000000>;
 	cci-control-port = <&cci_control1>;
+	operating-points-v2 = <&cpu0_opp_table>;
 };
 
 &cpu5 {
@@ -62,6 +69,7 @@
 	reg = <0x1>;
 	clock-frequency = <1800000000>;
 	cci-control-port = <&cci_control1>;
+	operating-points-v2 = <&cpu0_opp_table>;
 };
 
 &cpu6 {
@@ -70,6 +78,7 @@
 	reg = <0x2>;
 	clock-frequency = <1800000000>;
 	cci-control-port = <&cci_control1>;
+	operating-points-v2 = <&cpu0_opp_table>;
 };
 
 &cpu7 {
@@ -78,4 +87,5 @@
 	reg = <0x3>;
 	clock-frequency = <1800000000>;
 	cci-control-port = <&cci_control1>;
+	operating-points-v2 = <&cpu0_opp_table>;
 };
-- 
1.9.1
