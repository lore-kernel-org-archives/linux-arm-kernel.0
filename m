From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Nov 2015 16:53:40 +0100
Subject: [PATCH] ARM: mvebu: add reference to ETH connectors for A385-AP
Message-ID: <1447775620-25919-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds some comments to the Armada 385 AP Device Tree
description to indicate which Ethernet interface matches which
physical connector on the board.

This is especially useful on this board, since the mapping between the
logical interface names and the physical ports is not very
straightforward. It also doesn't match the numbering of the interfaces
done by U-Boot:

 U-Boot interface | Linux interface | Physical port
 -----------------+-----------------+--------------
   egiga0         |     eth2        |   CON4
   egiga1         |     eth0        |   CON2
   egiga2         |     eth1        |   CON3
 -----------------+-----------------+--------------

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 4047621..408b813 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -132,18 +132,21 @@
 				};
 			};
 
+			/* CON3 */
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy2>;
 				phy-mode = "sgmii";
 			};
 
+			/* CON2 */
 			ethernet at 34000 {
 				status = "okay";
 				phy = <&phy1>;
 				phy-mode = "sgmii";
 			};
 
+			/* CON4 */
 			ethernet at 70000 {
 				pinctrl-names = "default";
 
-- 
2.6.3
