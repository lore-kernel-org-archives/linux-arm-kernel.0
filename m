From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Fri, 15 Jun 2012 09:44:06 +0200
Subject: [PATCH v3 5/9] arm: mach-mvebu: add documentation for new device tree
 bindings
In-Reply-To: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339746250-26650-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 .../devicetree/bindings/arm/armada_370_xp-mpic.txt |   23 +++++++++++++++++++
 .../bindings/arm/armada_370_xp-timer.txt           |   11 +++++++++
 .../devicetree/bindings/arm/armada_370_xp.txt      |   24 ++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada_370_xp-mpic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada_370_xp-timer.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada_370_xp.txt

diff --git a/Documentation/devicetree/bindings/arm/armada_370_xp-mpic.txt b/Documentation/devicetree/bindings/arm/armada_370_xp-mpic.txt
new file mode 100644
index 0000000..70c0dc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada_370_xp-mpic.txt
@@ -0,0 +1,23 @@
+Marvell Armada 370 and Armada XP Interrupt Controller
+-----------------------------------------------------
+
+Required properties:
+- compatible: Should be "marvell,mpic"
+- interrupt-controller: Identifies the node as an interrupt controller.
+- #interrupt-cells: The number of cells to define the interrupts. Should be 1.
+  The cell is the IRQ number
+- reg: Should contain PMIC registers location and length. First pair
+  for the main interrupt registers, second pair for the per-CPU
+  interrupt registers
+
+Example:
+
+        mpic: interrupt-controller at d0020000 {
+              compatible = "marvell,mpic";
+              #interrupt-cells = <1>;
+              #address-cells = <1>;
+              #size-cells = <1>;
+              interrupt-controller;
+              reg = <0xd0020000 0x1000>,
+                    <0xd0021000 0x1000>;
+        };
diff --git a/Documentation/devicetree/bindings/arm/armada_370_xp-timer.txt b/Documentation/devicetree/bindings/arm/armada_370_xp-timer.txt
new file mode 100644
index 0000000..d14dc7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada_370_xp-timer.txt
@@ -0,0 +1,11 @@
+Marvell Armada 370 and Armada XP Global Timers
+----------------------------------------------
+
+Required properties:
+- compatible: Should be "marvell,timer"
+- interrupts: Should contain the list of Global Timer interrupts
+- reg: Should contain the base address of the Global Timer registers
+
+Optional properties:
+- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
+  Mhz fixed mode (available on Armada XP and not on Armada 370)
diff --git a/Documentation/devicetree/bindings/arm/armada_370_xp.txt b/Documentation/devicetree/bindings/arm/armada_370_xp.txt
new file mode 100644
index 0000000..3cdd793
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada_370_xp.txt
@@ -0,0 +1,24 @@
+Marvell Armada 370 and Armada XP Platforms Device Tree Bindings
+---------------------------------------------------------------
+
+Boards with a SoC of the Marvell Armada 370 and Armada XP families
+shall have the following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada_370_xp"
+
+In addition, boards using the Marvell Armada 370 SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada370"
+
+In addition, boards using the Marvell Armada XP SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armadaxp"
+
-- 
1.7.9.5
