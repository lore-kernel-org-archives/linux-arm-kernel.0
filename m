From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Nov 2014 16:21:35 +0100
Subject: [PATCHv2 15/16] ARM: mvebu: adjust mbus controller description on
 Armada 370/XP
In-Reply-To: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1415978496-9334-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support suspend/resume on Armada XP, an additional set of
registers need to be described at the MBus controller level. This
commit therefore adjusts the Device Tree of the Armada 370/XP SoC to
include those registers in the MBus controller description;

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 83286ec..90dba78 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -180,7 +180,8 @@
 
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
-				reg = <0x20000 0x100>, <0x20180 0x20>;
+				reg = <0x20000 0x100>, <0x20180 0x20>,
+				      <0x20250 0x8>;
 			};
 
 			mpic: interrupt-controller at 20000 {
-- 
2.1.0
