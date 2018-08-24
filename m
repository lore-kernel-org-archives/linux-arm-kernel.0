From: tony.xie@rock-chips.com (Tony Xie)
Date: Fri, 24 Aug 2018 18:03:00 +0800
Subject: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for
 rk3399
In-Reply-To: <1535104980-8456-1-git-send-email-tony.xie@rock-chips.com>
References: <1535104980-8456-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <1535104980-8456-2-git-send-email-tony.xie@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b6..49fb57f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -111,6 +111,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKL>;
 			dynamic-power-coefficient = <100>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu_l1: cpu at 1 {
@@ -120,6 +121,7 @@
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
 			dynamic-power-coefficient = <100>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu_l2: cpu at 2 {
@@ -129,6 +131,7 @@
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
 			dynamic-power-coefficient = <100>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu_l3: cpu at 3 {
@@ -138,6 +141,7 @@
 			enable-method = "psci";
 			clocks = <&cru ARMCLKL>;
 			dynamic-power-coefficient = <100>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu_b0: cpu at 100 {
@@ -148,6 +152,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			clocks = <&cru ARMCLKB>;
 			dynamic-power-coefficient = <436>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 		};
 
 		cpu_b1: cpu at 101 {
@@ -157,6 +162,29 @@
 			enable-method = "psci";
 			clocks = <&cru ARMCLKB>;
 			dynamic-power-coefficient = <436>;
+			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <120>;
+				exit-latency-us = <250>;
+				min-residency-us = <900>;
+			};
+
+			CLUSTER_SLEEP: cluster-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x1010000>;
+				entry-latency-us = <400>;
+				exit-latency-us = <500>;
+				min-residency-us = <2000>;
+			};
 		};
 	};
 
-- 
1.9.1
