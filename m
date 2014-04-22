From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:23 +0200
Subject: [PATCH v2 19/38] ARM: orion5x: add interrupt for Ethernet in Device
 Tree
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason, the Ethernet interrupt was missing in the Orion5x
Device Tree definition.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 3802d4f..ad23ff4 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -128,6 +128,7 @@
 				ethport: ethernet-port at 0 {
 					compatible = "marvell,orion-eth-port";
 					reg = <0>;
+					interrupts = <21>;
 					/* overwrite MAC address in bootloader */
 					local-mac-address = [00 00 00 00 00 00];
 					/* set phy-handle property in board file */
-- 
1.9.2
