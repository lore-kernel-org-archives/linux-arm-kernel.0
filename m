From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 14:24:56 +0200
Subject: [PATCHv2 1/3] dt: xilinx: zynqmp: Add bindings for PM firmware
In-Reply-To: <cover.1502886277.git.michal.simek@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
Message-ID: <2935be9896d54020720919e7dab7c2f86bdc83a3.1502886277.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Soren Brinkmann <soren.brinkmann@xilinx.com>

Document the DT bindings for the Zynq UltraScale+ PM Firmware.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Move to bindings/firmware and also add it to firmware node
  Reported-by Rob

 .../bindings/firmware/xlnx,zynqmp-pm.txt           | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt

diff --git a/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt b/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
new file mode 100644
index 000000000000..7de0c82758b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
@@ -0,0 +1,22 @@
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
+
+	firmware {
+		zynqmp-firmware {
+			compatible = "xlnx,zynqmp-pm";
+			method = "smc";
+			interrupt-parent = <&gic>;
+			interrupts = <0 35 4>;
+		};
+	};
-- 
1.9.1
