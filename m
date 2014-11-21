From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Nov 2014 17:00:13 +0100
Subject: [PATCHv3 16/16] ARM: mvebu: add SDRAM controller description for
 Armada XP
In-Reply-To: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1416585613-2113-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend/resume sequence on Armada XP needs to modify a number of
registers in the SDRAM controller. Therefore, this commit updates the
Armada XP Device Tree description to include the SDRAM controller
Device Tree node.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bff9f6c..2be244a 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -35,6 +35,11 @@
 		};
 
 		internal-regs {
+			sdramc at 1400 {
+				compatible = "marvell,armada-xp-sdram-controller";
+				reg = <0x1400 0x500>;
+			};
+
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
 				reg = <0x08000 0x1000>;
-- 
2.1.0
