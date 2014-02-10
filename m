From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Feb 2014 18:32:49 +0100
Subject: [PATCH 6/6] dt: Update binding information for mvebu gating clocks
 with Armada 380/385
In-Reply-To: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
References: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1392053569-28037-7-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Add the binding information for the gating clocks of the Armada 380
SoCs and the Armada 385 SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../bindings/clock/mvebu-gated-clock.txt           | 36 +++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index cbecec1f64fa..1533e383d6e9 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -1,9 +1,10 @@
 * Gated Clock bindings for Marvell EBU SoCs
 
-Marvell Armada 370/375/XP, Dove and Kirkwood allow some peripheral clocks to be
-gated to save some power. The clock consumer should specify the desired clock
-by having the clock ID in its "clocks" phandle cell. The clock ID is directly
-mapped to the corresponding clock gating control bit in HW to ease manual clock
+Marvell Armada 370/375/380/385/XP, Dove and Kirkwood allow some
+peripheral clocks to be gated to save some power. The clock consumer
+should specify the desired clock by having the clock ID in its
+"clocks" phandle cell. The clock ID is directly mapped to the
+corresponding clock gating control bit in HW to ease manual clock
 lookup in datasheet.
 
 The following is a list of provided IDs for Armada 370:
@@ -49,6 +50,32 @@ ID	Clock		Peripheral
 30	crypto1_enc	Cryptographic Unit Port 1 Encryption
 31	crypto1_core	Cryptographic Unit Port 1 Core
 
+The following is a list of provided IDs for Armada 380/385:
+ID	Clock		Peripheral
+-----------------------------------
+0	audio		Audio
+2	ge2		Gigabit Ethernet 2
+3	ge1		Gigabit Ethernet 1
+4	ge0		Gigabit Ethernet 0
+5	pex1		PCIe 1
+6	pex2		PCIe 2
+7	pex3		PCIe 3
+8	pex4		PCIe 0
+9	usb3h0		USB3 Host 0
+10	usb3h1		USB3 Host 1
+11	usb3d		USB3 Device
+13	bm		Buffer Management
+14	crypto0z	Cryptographic 0 Z
+15	sata0		SATA 0
+16	crypto1z	Cryptographic 1 Z
+17	sdio		SDIO
+18	usb2		USB 2
+21	crypto1		Cryptographic 1
+22	xor0		XOR 0
+23	crypto0		Cryptographic 0
+25	tdm		Time Division Multiplexing
+28	xor1		XOR 1
+30	sata1		SATA 1
 
 The following is a list of provided IDs for Armada XP:
 ID	Clock	Peripheral
@@ -124,6 +151,7 @@ Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-370-gating-clock" - for Armada 370 SoC clock gating
 	"marvell,armada-375-gating-clock" - for Armada 375 SoC clock gating
+	"marvell,armada-380-gating-clock" - for Armada 380/385 SoC clock gating
 	"marvell,armada-xp-gating-clock" - for Armada XP SoC clock gating
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
-- 
1.8.1.2
