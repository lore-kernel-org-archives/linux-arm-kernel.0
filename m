From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 May 2013 16:13:27 +0200
Subject: [PATCH] ARM: dts: mvebu: Fix wrong the address reg value for the
 L2-cache node
Message-ID: <1369059207-32210-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the conversion to the internal-regs' subnode, the L2-cache node
haven not been converted (due to a wrong choice made by myself during
the resolution of the merge conflict when I rebased the commit). This
leads to wrong address for L2 cache which prevent it to be used on
Armada 370. This commit fix the address reg of the e L2-cache node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index b2c1b5a..a38a262 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -38,7 +38,7 @@
 
 			L2: l2-cache {
 				compatible = "marvell,aurora-outer-cache";
-				reg = <0xd0008000 0x1000>;
+				reg = <0x08000 0x1000>;
 				cache-id-part = <0x100>;
 				wt-override;
 			};
-- 
1.8.1.2
