From: fan.chen@mediatek.com (Fan Chen)
Date: Fri, 18 Dec 2015 10:42:30 +0800
Subject: [PATCH 3/4] arm64: dts: mediatek: Add cluster sleep support on MT8173
In-Reply-To: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
References: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
Message-ID: <1450406551-1741-4-git-send-email-fan.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weiyi Lu <weiyi.lu@mediatek.com>

Enable cluster sleep state by adding cluster-sleep node to mt8173.dtsi

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 880dacb..77c1f84 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -53,7 +53,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu1: cpu at 1 {
@@ -61,7 +61,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu2: cpu at 100 {
@@ -69,7 +69,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		cpu3: cpu at 101 {
@@ -77,7 +77,7 @@
 			compatible = "arm,cortex-a57";
 			reg = <0x101>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		idle-states {
@@ -91,6 +91,15 @@
 				min-residency-us = <1088>;
 				arm,psci-suspend-param = <0x0010000>;
 			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <800>;
+				exit-latency-us = <1000>;
+				min-residency-us = <2000>;
+				arm,psci-suspend-param = <0x1010000>;
+			};
 		};
 	};
 
-- 
1.7.9.5
