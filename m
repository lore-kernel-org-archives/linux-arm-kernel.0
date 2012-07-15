From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:09 +0200
Subject: [PATCH 3/8] ARM: MCS814x: add Device Tree bindings documentation
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-4-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings documentation for the basic
Moschip MCS814x bindings that we support:
- soc
- interrupt controller
- timer
- pci controller

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 .../devicetree/bindings/arm/mcs814x/mcs814x-intc.txt |   18 ++++++++++++++++++
 .../devicetree/bindings/arm/mcs814x/mcs814x-pci.txt  |   16 ++++++++++++++++
 .../bindings/arm/mcs814x/mcs814x-timer.txt           |   16 ++++++++++++++++
 .../devicetree/bindings/arm/mcs814x/mcs814x.txt      |   13 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt          |    1 +
 5 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-intc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x-timer.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mcs814x/mcs814x.txt

diff --git a/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-intc.txt b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-intc.txt
new file mode 100644
index 0000000..2bf0c47
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-intc.txt
@@ -0,0 +1,18 @@
+Moschip MCS814x interrupt controller bindings
+----------------------------------------------
+
+Required properties:
+- compatible: should be "moschip,mcs814x-intc"
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: the number of cells to define the interrupts. Should be 1.
+The cells are the IRQ number
+- reg: contains the base address register and length, there should be only 1
+  cell
+
+Example:
+	intc: interrupt-controller at 400e4000 {
+		compatible = "moschip,mcs814x-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x400e4000 0x48>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
new file mode 100644
index 0000000..de59b04
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
@@ -0,0 +1,16 @@
+Moschip MCS814x PCI controller bindings
+---------------------------------------
+
+Required properties:
+- compatible: should be "moschip,mcs814x-pci"
+- reg: should contain the base register address and length of the PCI controller
+  configuration register as well as the base register address and length of the
+  PCI eeprom emulator
+- interrupts: should contain the interrupt line of the abort interrupt
+- #address-cells: should be 3
+- #size-cells: should be 2
+- ranges: should contain the properly encoded PCI ranges of the IO, non-prefetchable
+  and prefetchable memory regions
+- #interrupt-cells: should be 1
+- interrupt-map-mask: should be 0
+- interrupt-map: should be the properly encoded PCI slot/pin to interrupt line
diff --git a/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-timer.txt b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-timer.txt
new file mode 100644
index 0000000..0bf22d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-timer.txt
@@ -0,0 +1,16 @@
+MMoschip MCS814x timer bindings
+-------------------------------
+
+Required properties:
+- compatible: should be "moschip,mcs814x-timer"
+- interrupts: should be the physical interrupt number
+- reg: contains the base address register and length, there should be only 1
+  cell
+
+Example:
+	timer: timer at 400f800c {
+		compatible = "moschip,mcs814x-timer";
+		interrupts = <0>;
+		reg = <0x400f800c 0x8>;
+	};
+
diff --git a/Documentation/devicetree/bindings/arm/mcs814x/mcs814x.txt b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x.txt
new file mode 100644
index 0000000..503c234
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x.txt
@@ -0,0 +1,13 @@
+MMoschip MCS814x SoC bindings
+
+-----------------------------
+
+Boards including a Moschip MCS814x SoC should include the following properties
+
+Required root node property:
+- compatible: must contain "moschip,mcs814x"
+
+Boards including a Moschip MCS8140 should also include the following property.
+
+Required root node property:
+- compatible: must contain "moschip,mcs8140"
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6eab917..943e4f3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -28,6 +28,7 @@ linux	Linux-specific binding
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 mosaixtech	Mosaix Technologies, Inc.
+moschp		Moschip Semiconductors
 national	National Semiconductor
 nintendo	Nintendo
 nvidia	NVIDIA
-- 
1.7.10.4
