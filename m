From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Feb 2015 18:04:26 +0100
Subject: [PATCHv2 07/15] devicetree: bindings: update DT bindings for Marvell
 EBU clock support
In-Reply-To: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1424451874-25375-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of the Marvell Armada 39x SoC, the DT bindings
for Marvell EBU clocks need to be extended. This commit include the
corresponding update to the Device Tree bindings documentation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-core-clock.txt        |  9 +++++++++
 .../devicetree/bindings/clock/mvebu-gated-clock.txt       | 15 ++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index dc5ea5b..670c2af 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -23,6 +23,14 @@ The following is a list of provided IDs and clock names on Armada 380/385:
  2 = l2clk   (L2 Cache clock)
  3 = ddrclk  (DDR clock)
 
+The following is a list of provided IDs and clock names on Armada 39x:
+ 0 = tclk    (Internal Bus clock)
+ 1 = cpuclk  (CPU clock)
+ 2 = nbclk   (Coherent Fabric clock)
+ 3 = hclk    (SDRAM Controller Internal Clock)
+ 4 = dclk    (SDRAM Interface Clock)
+ 5 = refclk  (Reference Clock)
+
 The following is a list of provided IDs and clock names on Kirkwood and Dove:
  0 = tclk   (Internal Bus clock)
  1 = cpuclk (CPU0 clock)
@@ -39,6 +47,7 @@ Required properties:
 	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
 	"marvell,armada-375-core-clock" - For Armada 375 SoC core clocks
 	"marvell,armada-380-core-clock" - For Armada 380/385 SoC core clocks
+	"marvell,armada-390-core-clock" - For Armada 39x SoC core clocks
 	"marvell,armada-xp-core-clock" - For Armada XP SoC core clocks
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 76477be..31c7c0c 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -1,6 +1,6 @@
 * Gated Clock bindings for Marvell EBU SoCs
 
-Marvell Armada 370/375/380/385/XP, Dove and Kirkwood allow some
+Marvell Armada 370/375/380/385/39x/XP, Dove and Kirkwood allow some
 peripheral clocks to be gated to save some power. The clock consumer
 should specify the desired clock by having the clock ID in its
 "clocks" phandle cell. The clock ID is directly mapped to the
@@ -77,6 +77,18 @@ ID	Clock		Peripheral
 28	xor1		XOR 1
 30	sata1		SATA 1
 
+The following is a list of provided IDs for Armada 39x:
+ID	Clock		Peripheral
+-----------------------------------
+5	pex1		PCIe 1
+6	pex2		PCIe 2
+7	pex3		PCIe 3
+8	pex0		PCIe 0
+9	usb3h0		USB3 Host 0
+17	sdio		SDIO
+22	xor0		XOR 0
+28	xor1		XOR 1
+
 The following is a list of provided IDs for Armada XP:
 ID	Clock	Peripheral
 -----------------------------------
@@ -152,6 +164,7 @@ Required properties:
 	"marvell,armada-370-gating-clock" - for Armada 370 SoC clock gating
 	"marvell,armada-375-gating-clock" - for Armada 375 SoC clock gating
 	"marvell,armada-380-gating-clock" - for Armada 380/385 SoC clock gating
+	"marvell,armada-390-gating-clock" - for Armada 39x SoC clock gating
 	"marvell,armada-xp-gating-clock" - for Armada XP SoC clock gating
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
-- 
2.1.0
