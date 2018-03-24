From: chinnikishore369@gmail.com (chinnikishore369 at gmail.com)
Date: Sat, 24 Mar 2018 23:16:37 +0530
Subject: [RFC 1/2] documentation: Add nvmem bindings documentation
Message-ID: <20180324174638.12621-1-chinnikishore369@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <navam@xilinx.com>

This patch add the bindings document of zynqmp silicon id driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 .../devicetree/bindings/nvmem/zynqmp_nvmem.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
new file mode 100644
index 000000000000..94332f160a92
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
@@ -0,0 +1,32 @@
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	nvmem_firmware {
+		compatible = "xlnx,zynqmp-nvmem-fw";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		 /* Data cells */
+		soc_revision: soc_revision at 0 {
+			reg = <0x0 0x4>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
-- 
2.16.1
