From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 Jul 2016 15:34:44 +0200
Subject: [PATCH] arm64: dts: marvell: update DT description of Armada 7K/8K
 SATA controller
Message-ID: <1469021684-5467-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to what was originally thought, the Armada 7K/8K AHCI
controller is compatible with the standard AHCI, so this commit adds
the "generic-ahci" compatible string to the list of compatible string
in the description of this HW block in the Armada 7K/8K Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index da31bbb..ceb83b0 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -80,7 +80,8 @@
 			};
 
 			cpm_sata0: sata at 540000 {
-				compatible = "marvell,armada-8k-ahci";
+				compatible = "marvell,armada-8k-ahci",
+					     "generic-ahci";
 				reg = <0x540000 0x30000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 15>;
-- 
2.7.4
