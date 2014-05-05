From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon,  5 May 2014 21:57:00 +0530
Subject: [PATCH v5 4/5] ARM: dts: exynos5420: add CCI node
In-Reply-To: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399307221-8659-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

Add device-tree bindings for the ARM CCI-400 on Exynos5420.  There
are two slave interfaces: one for the A15 cluster and one for the
A7 cluster.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ff496ad..3140138 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -58,6 +58,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
 			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu1: cpu at 1 {
@@ -65,6 +66,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu2: cpu at 2 {
@@ -72,6 +74,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu3: cpu at 3 {
@@ -79,6 +82,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu4: cpu at 100 {
@@ -86,6 +90,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu5: cpu at 101 {
@@ -93,6 +98,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu6: cpu at 102 {
@@ -100,6 +106,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu7: cpu at 103 {
@@ -107,6 +114,26 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
+	};
+
+	cci at 10d20000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x10d20000 0x1000>;
+		ranges = <0x0 0x10d20000 0x6000>;
+
+		cci_control0: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+		cci_control1: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
 		};
 	};
 
-- 
1.7.9.5
