From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 12 Jul 2016 14:07:08 -0500
Subject: [PATCH 1/2] ARM: socfpga: add bindings doc for arria10 fpga manager
In-Reply-To: <20160712190709.5964-1-atull@opensource.altera.com>
References: <20160712190709.5964-1-atull@opensource.altera.com>
Message-ID: <20160712190709.5964-2-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree bindings document for the SoCFPGA Arria10
FPGA Manager driver.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 .../bindings/fpga/altera-socfpga-a10-fpga-mgr.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-socfpga-a10-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/altera-socfpga-a10-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/altera-socfpga-a10-fpga-mgr.txt
new file mode 100644
index 0000000..2fd8e7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-socfpga-a10-fpga-mgr.txt
@@ -0,0 +1,19 @@
+Altera SOCFPGA Arria10 FPGA Manager
+
+Required properties:
+- compatible : should contain "altr,socfpga-a10-fpga-mgr"
+- reg        : base address and size for memory mapped io.
+               - The first index is for FPGA manager register access.
+               - The second index is for writing FPGA configuration data.
+- resets     : Phandle and reset specifier for the device's reset.
+- clocks     : Clocks used by the device.
+
+Example:
+
+	fpga_mgr: fpga-mgr at ffd03000 {
+		compatible = "altr,socfpga-a10-fpga-mgr";
+		reg = <0xffd03000 0x100
+		       0xffcfe400 0x20>;
+		clocks = <&l4_mp_clk>;
+		resets = <&rst FPGAMGR_RESET>;
+	};
-- 
2.9.1
