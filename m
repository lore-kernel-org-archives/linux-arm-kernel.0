From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 May 2013 18:07:24 +0200
Subject: [PATCH] arm: mvebu: enable the third USB interface on OpenBlocks AX3
Message-ID: <1368720444-29357-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Besides the two "classic" USB interfaces with normal USB ports on the
front side, the PlatHome OpenBlocks AX3 uses the third USB interface
of the Marvell SoC in the mini-PCIe connector. This allows certain
mini-PCIe cards to expose parts of their functionality as a USB
peripheral.

This commit enables this third USB interface in the OpenBlocks AX3
Device Tree, and also adds comments on top of the two other USB
interfaces so that the Device Tree makes it clear which USB interface
at the SoC level matches which USB interface visible on the board.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index f14d36c..60a79e7 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -134,13 +134,22 @@
 				nr-ports = <2>;
 				status = "okay";
 			};
+
+			/* Front side USB 0 */
 			usb at 50000 {
 				status = "okay";
 			};
+
+			/* Front side USB 1 */
 			usb at 51000 {
 				status = "okay";
 			};
 
+			/* USB interface in the mini-PCIe connector */
+			usb at 52000 {
+				status = "okay";
+			};
+
 			devbus-bootcs at 10400 {
 				status = "okay";
 				ranges = <0 0xf0000000 0x8000000>; /* @addr 0xf000000, size 0x8000000 */
-- 
1.7.9.5
