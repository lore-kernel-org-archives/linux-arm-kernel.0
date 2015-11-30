From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 30 Nov 2015 21:41:58 +0800
Subject: [PATCH] arm64: dts: berlin4ct: support cpuidle-dt
Message-ID: <1448890918-6999-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an idle-states node to describe the berlin4ct idle
states and also adds references to the idle-states node in all CPU
nodes. After this patch cpuidle is enabled.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 39d0676..3649cea 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -69,6 +69,7 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -76,6 +77,7 @@
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu2: cpu at 2 {
@@ -83,6 +85,7 @@
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
 		cpu3: cpu at 3 {
@@ -90,6 +93,19 @@
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <75>;
+				exit-latency-us = <155>;
+				min-residency-us = <1000>;
+			};
 		};
 	};
 
-- 
2.6.2
