From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 18 Mar 2015 11:00:22 +0200
Subject: [PATCH v2] ARM: bcm2835: fix i2c0 node name
Message-ID: <7b7024c0438fe4b3fda66bbef4fe7db138761370.1426669222.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree node names should contain the node's reg property address value.
The i2c0 node was apparently forgotten in commit 25b2f1bd0b7e0 (ARM: bcm2835:
node name unit address cleanup).

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: add an informative commit log, and Stephen's ack
---
 arch/arm/boot/dts/bcm2835.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1407bc..fbf58418399e 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -112,7 +112,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 20205000 {
+		i2c0: i2c at 7e205000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e205000 0x1000>;
 			interrupts = <2 21>;
-- 
2.1.4
