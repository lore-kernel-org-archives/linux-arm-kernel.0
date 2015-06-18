From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 11:20:05 +0200
Subject: [PATCH] ARM: mvebu: use armada-370-sata for SATA on Armada 375
Message-ID: <1434619205-24873-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

The Armada 375 has the same SATA IP as Armada 370 and Armada XP, which
requires the PHY speed to be set in the LP_PHY_CTL register for SATA
hotplug to work.

Therefore, this commit updates the compatible string used to describe
the SATA IP in Armada 375 from marvell,orion-nand to
marvell,armada-370-nand.

Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index f076ff8..07f61bb 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -508,7 +508,7 @@
 			};
 
 			sata at a0000 {
-				compatible = "marvell,orion-sata";
+				compatible = "marvell,armada-370-sata";
 				reg = <0xa0000 0x5000>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 14>, <&gateclk 20>;
-- 
2.1.0
