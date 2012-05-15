From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:39 +0200
Subject: [PATCH 3/8] arm: mach-armada: add documentation for new device tree
 bindings
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-mpic.txt        |   23 +++++++++++++++++++
 .../devicetree/bindings/arm/armada-timer.txt       |   11 +++++++++
 Documentation/devicetree/bindings/arm/armada.txt   |   24 ++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-mpic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-timer.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-mpic.txt b/Documentation/devicetree/bindings/arm/armada-mpic.txt
new file mode 100644
index 0000000..3571f44
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-mpic.txt
@@ -0,0 +1,23 @@
+Marvell Armada Interrupt Controller
+-----------------------------------
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
diff --git a/Documentation/devicetree/bindings/arm/armada-timer.txt b/Documentation/devicetree/bindings/arm/armada-timer.txt
new file mode 100644
index 0000000..6bed565
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-timer.txt
@@ -0,0 +1,11 @@
+Marvell Armada Global Timers
+----------------------------
+
+Required properties:
+- compatible: Should be "marvell,timer"
+- interrupts: Should contain the list of Global Timer interrupts
+- reg: Should contain the base address of the Global Timer registers
+
+Optional properties:
+- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
+  Mhz fixed mode (available on Armada XP and not on Armada 370)
diff --git a/Documentation/devicetree/bindings/arm/armada.txt b/Documentation/devicetree/bindings/arm/armada.txt
new file mode 100644
index 0000000..9724178
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada.txt
@@ -0,0 +1,24 @@
+Marvell Armada Platforms Device Tree Bindings
+---------------------------------------------
+
+Boards with a SoC of the Marvell Armada family shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada"
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
