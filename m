From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 16 Jun 2016 16:40:18 +0800
Subject: [PATCH] arm64: dts: berlin4ct: Add L2 cache topology
Message-ID: <1466066418-1141-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the L2 cache topology for berlin4ct which has 1MB L2
cache.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 099ad93..c9e3a98 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -68,6 +68,7 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			next-level-cache = <&L2_0>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -76,6 +77,7 @@
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			next-level-cache = <&L2_0>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -84,6 +86,7 @@
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			next-level-cache = <&L2_0>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
@@ -92,9 +95,14 @@
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			next-level-cache = <&L2_0>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
 		};
 
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+
 		idle-states {
 			entry-method = "psci";
 			CPU_SLEEP_0: cpu-sleep-0 {
-- 
2.8.1
