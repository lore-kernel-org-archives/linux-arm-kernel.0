From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  1 Dec 2014 14:24:56 +0100
Subject: [PATCH v5 5/7] devicetree: bindings: Add zynq ocmc node description
In-Reply-To: <cover.1417440250.git.michal.simek@xilinx.com>
References: <cover.1417440250.git.michal.simek@xilinx.com>
Message-ID: <a408c70d8ce54e47e1b400dc2523b7886bf7fcef.1417440250.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding for Zynq On Chip Memory controller driver
which is taking care about On Chip Memory.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

---

Changes in v5:
- Separate binding from the driver

Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt

diff --git a/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt b/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
new file mode 100644
index 000000000000..dcf221e8a16e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/zynq/xlnx,zynq-ocmc.txt
@@ -0,0 +1,17 @@
+Device tree bindings for Zynq's OCM controller
+
+The OCM is divided to 4 64kB segments which can be separately configured
+to low or high location. Location is controlled via SLCR.
+
+Required properties:
+ compatible: Compatibility string. Must be "xlnx,zynq-ocmc-1.0".
+ reg: Specify the base and size of the OCMC registers in the memory map.
+      E.g.: reg = <0xf800c000 0x1000>;
+
+Example:
+ocmc: memory-controller at f800c000 {
+	compatible =  "xlnx,zynq-ocmc-1.0";
+	interrupt-parent = <&intc>;
+	interrupts = <0 3 4>;
+	reg = <0xf800c000 0x1000>;
+};
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/7cce9ab8/attachment.sig>
