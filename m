From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:34:27 +0530
Subject: [PATCH 04/10] arm64: dts: hi3660: Add missing cooling device
 properties for CPUs
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <042e5e647a7b54f4322024f1b3e286b6b6d69175.1542362530.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a88c65..d943a96eedee 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -79,6 +79,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu at 2 {
@@ -91,6 +92,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -103,6 +105,7 @@
 			capacity-dmips-mhz = <592>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER0>;
 			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu at 100 {
@@ -129,6 +132,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu at 102 {
@@ -141,6 +145,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu at 103 {
@@ -153,6 +158,7 @@
 			capacity-dmips-mhz = <1024>;
 			clocks = <&stub_clock HI3660_CLK_STUB_CLUSTER1>;
 			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
 		};
 
 		idle-states {
-- 
2.19.1.568.g152ad8e3369a
