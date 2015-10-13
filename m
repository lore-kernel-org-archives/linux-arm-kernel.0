From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 08:58:16 +0800
Subject: [PATCH v2 4/4] arm64: dts: enable idle states for Hi6220
In-Reply-To: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
References: <1444697896-4323-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1444697896-4323-5-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpu and cluster level's low power state for Hi6220.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index cdd4125..2830571 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -52,11 +52,35 @@
 			};
 		};
 
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <700>;
+				exit-latency-us = <250>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER_SLEEP: cluster-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+				wakeup-latency-us = <1500>;
+			};
+		};
+
 		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu1: cpu at 1 {
@@ -64,6 +88,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu2: cpu at 2 {
@@ -71,6 +96,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu3: cpu at 3 {
@@ -78,6 +104,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu4: cpu at 100 {
@@ -85,6 +112,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu5: cpu at 101 {
@@ -92,6 +120,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu6: cpu at 102 {
@@ -99,6 +128,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu7: cpu at 103 {
@@ -106,6 +136,7 @@
 			device_type = "cpu";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 	};
 
-- 
1.9.1
