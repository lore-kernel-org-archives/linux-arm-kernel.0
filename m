From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  9 Jan 2018 12:32:42 +0800
Subject: [PATCH] arm64: dts: Hi3660: Remove 'CPU_NAP' idle state
Message-ID: <1515472362-19979-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
idle state.  At early time, the CPU CA73 CPU_NAP idle state has been
supported on Hikey960.  Later we found the system has the hang issue
and for resolving this issue Hisilicon released new MCU firmware, but
unfortunately the new MCU firmware has side effect and results in the
CA73 CPU cannot really enter CPU_NAP state and roll back to WFI state.

After discussion we cannot see the possibility to enable CA73 CPU_NAP
state anymore on Hikey960, based on this conclusion we should remove
this state from DT binding.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Wang <jean.wangtao@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 32 ++++---------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ab0b95b..8fddf0d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -96,11 +96,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <
-					&CPU_NAP
-					&CPU_SLEEP
-					&CLUSTER_SLEEP_1
-			>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 		};
 
 		cpu5: cpu at 101 {
@@ -109,11 +105,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <
-					&CPU_NAP
-					&CPU_SLEEP
-					&CLUSTER_SLEEP_1
-			>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 		};
 
 		cpu6: cpu at 102 {
@@ -122,11 +114,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <
-					&CPU_NAP
-					&CPU_SLEEP
-					&CLUSTER_SLEEP_1
-			>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 		};
 
 		cpu7: cpu at 103 {
@@ -135,24 +123,12 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&A73_L2>;
-			cpu-idle-states = <
-					&CPU_NAP
-					&CPU_SLEEP
-					&CLUSTER_SLEEP_1
-			>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
 		};
 
 		idle-states {
 			entry-method = "psci";
 
-			CPU_NAP: cpu-nap {
-				compatible = "arm,idle-state";
-				arm,psci-suspend-param = <0x0000001>;
-				entry-latency-us = <7>;
-				exit-latency-us = <2>;
-				min-residency-us = <15>;
-			};
-
 			CPU_SLEEP: cpu-sleep {
 				compatible = "arm,idle-state";
 				local-timer-stop;
-- 
2.7.4
