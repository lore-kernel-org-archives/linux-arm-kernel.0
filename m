From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 17 Mar 2015 17:33:54 +0100
Subject: [PATCH] ARM: mvebu: Conform L2CC node with ePAPR specification by
 adding cache-level
Message-ID: <1426610034-4204-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For L2 cache controller node, cache-level property is mandatory. Let's
add it to Armada 370 and Armada XP device tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 1 +
 arch/arm/boot/dts/armada-xp.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 27397f151def..b38bfa03d3bf 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -129,6 +129,7 @@
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
+				cache-level = <2>;
 				cache-unified;
 				wt-override;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 82917236a2fb..9806046dde1e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -78,6 +78,7 @@
 				compatible = "marvell,aurora-system-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
+				cache-level = <2>;
 				cache-unified;
 				wt-override;
 			};
-- 
2.1.0
