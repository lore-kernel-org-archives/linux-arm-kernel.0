From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 27 Mar 2012 22:54:15 +0100
Subject: [PATCH V3 5/5] mtd: Move fdt partition documentation to a seperate
 file
In-Reply-To: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Partitions are described in the same way for all mtd devices when using
devicetree, move the documentation to a separate file and add references
to it.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 .../devicetree/bindings/mtd/arm-versatile.txt      |    4 +-
 .../devicetree/bindings/mtd/atmel-dataflash.txt    |    3 ++
 .../devicetree/bindings/mtd/fsl-upm-nand.txt       |    4 ++
 .../devicetree/bindings/mtd/gpio-control-nand.txt  |    3 ++
 .../devicetree/bindings/mtd/mtd-physmap.txt        |   23 +-----------
 .../devicetree/bindings/mtd/orion-nand.txt         |    3 ++
 .../devicetree/bindings/mtd/partition.txt          |   38 ++++++++++++++++++++
 7 files changed, 55 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partition.txt

diff --git a/Documentation/devicetree/bindings/mtd/arm-versatile.txt b/Documentation/devicetree/bindings/mtd/arm-versatile.txt
index 476845d..beace4b 100644
--- a/Documentation/devicetree/bindings/mtd/arm-versatile.txt
+++ b/Documentation/devicetree/bindings/mtd/arm-versatile.txt
@@ -4,5 +4,5 @@ Required properties:
 - compatible : must be "arm,versatile-flash";
 - bank-width : width in bytes of flash interface.
 
-Optional properties:
-- Subnode partition map from mtd flash binding
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
diff --git a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
index ef66ddd..1889a4d 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
@@ -3,6 +3,9 @@
 Required properties:
 - compatible : "atmel,<model>", "atmel,<series>", "atmel,dataflash".
 
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
 Example:
 
 flash at 1 {
diff --git a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
index 00f1f54..fce4894 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt
@@ -19,6 +19,10 @@ Optional properties:
 	read registers (tR). Required if property "gpios" is not used
 	(R/B# pins not connected).
 
+Each flash chip described may optionally contain additional sub-nodes
+describing partitions of the address space. See partition.txt for more
+detail.
+
 Examples:
 
 upm at 1,0 {
diff --git a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt b/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
index 719f4dc..36ef07d 100644
--- a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
@@ -25,6 +25,9 @@ Optional properties:
   GPIO state and before and after command byte writes, this register will be
   read to ensure that the GPIO accesses have completed.
 
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
 Examples:
 
 gpio-nand at 1,0 {
diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
index 80152cb..a63c2bd7 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
@@ -23,27 +23,8 @@ are defined:
  - vendor-id : Contains the flash chip's vendor id (1 byte).
  - device-id : Contains the flash chip's device id (1 byte).
 
-In addition to the information on the mtd bank itself, the
-device tree may optionally contain additional information
-describing partitions of the address space.  This can be
-used on platforms which have strong conventions about which
-portions of a flash are used for what purposes, but which don't
-use an on-flash partition table such as RedBoot.
-
-Each partition is represented as a sub-node of the mtd device.
-Each node's name represents the name of the corresponding
-partition of the mtd device.
-
-Flash partitions
- - reg : The partition's offset and size within the mtd bank.
- - label : (optional) The label / name for this partition.
-   If omitted, the label is taken from the node name (excluding
-   the unit address).
- - read-only : (optional) This parameter, if present, is a hint to
-   Linux that this partition should only be mounted
-   read-only.  This is usually used for flash partitions
-   containing early-boot firmware images or data which should not
-   be clobbered.
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
index 22c7438..d606009 100644
--- a/Documentation/devicetree/bindings/mtd/orion-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
@@ -11,6 +11,9 @@ Optional properties:
 - bank-width :
 - chip-delay :
 
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
 Examples:
 
 nand at f4000000 {
diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
new file mode 100644
index 0000000..f114ce1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partition.txt
@@ -0,0 +1,38 @@
+Representing flash partitions in devicetree
+
+Partitions can be represented by sub-nodes of an mtd device. This can be used
+on platforms which have strong conventions about which portions of a flash are
+used for what purposes, but which don't use an on-flash partition table such
+as RedBoot.
+
+#address-cells & #size-cells must both be present in the mtd device and be
+equal to 1.
+
+Required properties:
+- reg : The partition's offset and size within the mtd bank.
+
+Optional properties:
+- label : The label / name for this partition.  If omitted, the label is taken
+  from the node name (excluding the unit address).
+- read-only : This parameter, if present, is a hint to Linux that this
+  partition should only be mounted read-only. This is usually used for flash
+  partitions containing early-boot firmware images or data which should not be
+  clobbered.
+
+Examples:
+
+
+flash at 0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	partition at 0 {
+		label = "u-boot";
+		reg = <0x0000000 0x100000>;
+		read-only;
+	};
+
+	uimage at 100000 {
+		reg = <0x0100000 0x200000>;
+	};
+];
-- 
1.7.9.1
