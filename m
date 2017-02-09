From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Thu,  9 Feb 2017 16:27:02 +0100
Subject: [PATCH] ARM: dts: armada-385-linksys: fix DSA compatible property
Message-ID: <20170209152702.23036-1-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch to the new DSA binding used "marvell,mv88e6095" for the
compatible property which doesn't exist, use "marvell,mv88e6085"
instead.

Fixes: 455b82f03f52 ("ARM: dts: armada-385-linksys: Utilize new DSA binding")
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 20d5e8b..df47bf1 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -107,7 +107,7 @@
 				status = "okay";
 
 				switch at 0 {
-					compatible = "marvell,mv88e6095";
+					compatible = "marvell,mv88e6085";
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0>;
-- 
2.10.2
