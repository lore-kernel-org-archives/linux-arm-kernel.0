From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  6 Oct 2014 11:37:56 +0200
Subject: [PATCH] ARM: mvebu: Fix the Aurora L2 cache node with the required
 cache-unified property
Message-ID: <1412588276-4514-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 cache controller on the Armada 370 and Armada XP SoCs is a
unified cache. Moreover, the Aurora cache controller is compatible
with the L2x0 cache controller: the "cache-unified" property is
required by its binding.

This patch fixes the Aurora L2 cache node for the Armada 370 and
Armada XP SoCs by adding this property.

Reported-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 1 +
 arch/arm/boot/dts/armada-xp.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 21b588b6f6bd..095ae7e1d8c7 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -95,6 +95,7 @@
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
+				cache-unified;
 				wt-override;
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bff9f6c18db1..e1707133ee18 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -39,6 +39,7 @@
 				compatible = "marvell,aurora-system-cache";
 				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
+				cache-unified;
 				wt-override;
 			};
 
-- 
1.9.1
