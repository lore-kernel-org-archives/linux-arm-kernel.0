From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Jul 2016 14:01:15 +0800
Subject: [PATCH v2] arm64: dts: berlin4ct: Add L2 cache topology
Message-ID: <1467871275-4000-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the L2 cache topology for berlin4ct which has 1MB L2
cache.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since V1:
 - use lower case for node label
 - remove useless "0" in node label and node name

 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 099ad93..deea38b 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -68,6 +68,7 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -76,6 +77,7 @@
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -84,6 +86,7 @@
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -92,9 +95,14 @@
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
+		l2: l2-cache {
+			compatible = "cache";
+		};
+
 		idle-states {
 			entry-method = "psci";
 			CPU_SLEEP_0: cpu-sleep-0 {
-- 
2.8.1
