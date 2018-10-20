From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 20 Oct 2018 14:06:02 +0530
Subject: [PATCH 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
Message-ID: <20181020083603.27602-3-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		Created a Seperate(New) DT binding file as
		suggested by Rob.

Changes for RFC-V3:
                -None.

Changes for RFC-V2:
                -Moved nvmem_firmware node as a child to
                 firwmare node.

 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 0000000..0bafb9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,37 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+	nvmem_firmware {
+		compatible = "xlnx,zynqmp-nvmem-fw";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells */
+		soc_revision: soc_revision {
+			reg = <0x0 0x4>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.7.4
