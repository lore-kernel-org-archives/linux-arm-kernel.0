From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  9 Aug 2013 22:27:13 +0200
Subject: [PATCHv9 08/10] ARM: mvebu: the MPIC now provides MSI controller
 features
In-Reply-To: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1376080035-29344-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the 'msi-controller' property to the main interrupt controller
Device Tree node, to indicate that it can now behave as a MSI
controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Tested-by: Daniel Price <daniel.price@gmail.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..ac0bbc0 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -56,6 +56,7 @@
 				#interrupt-cells = <1>;
 				#size-cells = <1>;
 				interrupt-controller;
+				msi-controller;
 			};
 
 			coherency-fabric at 20200 {
-- 
1.8.1.2
