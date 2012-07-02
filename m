From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  2 Jul 2012 17:39:30 +0200
Subject: [PATCH 5/9] arm: mach-mvebu: add documentation for new device tree
 bindings
In-Reply-To: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1341243574-3258-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   23 +++++++++++++++++++
 .../bindings/arm/armada-370-xp-timer.txt           |   11 +++++++++
 .../devicetree/bindings/arm/armada-370-xp.txt      |   24 ++++++++++++++++++++
 .../bindings/arm/mvebu-system-controller.txt       |   17 ++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-system-controller.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
new file mode 100644
index 0000000..70c0dc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
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
diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
new file mode 100644
index 0000000..d14dc7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt
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
diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp.txt b/Documentation/devicetree/bindings/arm/armada-370-xp.txt
new file mode 100644
index 0000000..c6ed90e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp.txt
@@ -0,0 +1,24 @@
+Marvell Armada 370 and Armada XP Platforms Device Tree Bindings
+---------------------------------------------------------------
+
+Boards with a SoC of the Marvell Armada 370 and Armada XP families
+shall have the following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada-370-xp"
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
diff --git a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
new file mode 100644
index 0000000..081c6a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
@@ -0,0 +1,17 @@
+MVEBU System Controller
+-----------------------
+MVEBU (Marvell SOCs: Armada 370/XP, Dove, mv78xx0, Kirkwood, Orion5x)
+
+Required properties:
+
+- compatible: one of:
+	- "marvell,orion-system-controller"
+	- "marvell,armada-370-xp-system-controller"
+- reg: Should contain system controller registers location and length.
+
+Example:
+
+	system-controller at d0018200 {
+		compatible = "marvell,armada-370-xp-system-controller";
+		reg = <0xd0018200 0x500>;
+	};
-- 
1.7.9.5
