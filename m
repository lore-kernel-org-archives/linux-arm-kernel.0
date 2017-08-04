From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 15:45:30 +0200
Subject: [PATCH 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <cover.1501854302.git.michal.simek@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
Message-ID: <8c27b7eec6cc00d37dfe9b3998212ce9c9c27a31.1501854302.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Soren Brinkmann <soren.brinkmann@xilinx.com>

Document the DT bindings for the Zynq UltraScale+ PM Firmware.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
new file mode 100644
index 000000000000..222a18ce07fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
@@ -0,0 +1,19 @@
+Xilinx Zynq MPSoC Firmware Device Tree Bindings
+
+The zynqmp-pm node describes the interface to platform firmware.
+
+Required properties:
+ - compatible:	Must contain:  "xlnx,zynqmp-pm"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		 - "smc" : To be used in configurations without a hypervisor
+		 - "hvc" : To be used when hypervisor is present
+ - interrupts:	Interrupt specifier
+
+Examples:
+	zynqmp-firmware {
+		compatible = "xlnx,zynqmp-pm";
+		method = "smc";
+		interrupt-parent = <&gic>;
+		interrupts = <0 35 4>;
+	};
-- 
1.9.1
