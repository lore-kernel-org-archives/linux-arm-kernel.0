From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  1 Dec 2016 20:08:55 +0800
Subject: arm64: dts: zx: support cpu-freq for zx296718
Message-ID: <1480594135-27273-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the CPU clock phandle in CPU's node
and uses operating-points-v2 to register operating points.

So it can be used by cpufreq-dt driver.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 7a1aed7..16f7d5e 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -44,6 +44,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/zx296718-clock.h>
 
 / {
 	compatible = "zte,zx296718";
@@ -81,6 +82,8 @@
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			clocks = <&topcrm A53_GATE>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu at 1 {
@@ -88,6 +91,7 @@
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu at 2 {
@@ -95,6 +99,7 @@
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu at 3 {
@@ -102,6 +107,38 @@
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+	};
+
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <857000>;
+			clock-latency-ns = <500000>;
+		};
+		opp at 648000000 {
+			opp-hz = /bits/ 64 <648000000>;
+			opp-microvolt = <857000>;
+			clock-latency-ns = <500000>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <882000>;
+			clock-latency-ns = <500000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <892000>;
+			clock-latency-ns = <500000>;
+		};
+		opp at 1188000000 {
+			opp-hz = /bits/ 64 <1188000000>;
+			opp-microvolt = <1009000>;
+			clock-latency-ns = <500000>;
 		};
 	};
 
-- 
2.7.4
