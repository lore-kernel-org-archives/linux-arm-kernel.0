From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 16 Nov 2018 15:56:52 -0800
Subject: [PATCH 2/9] dt-bindings: soc: Add ZynqMP PM bindings
In-Reply-To: <1542412619-387-1-git-send-email-jollys@xilinx.com>
References: <1542412619-387-1-git-send-email-jollys@xilinx.com>
Message-ID: <1542412619-387-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..d366f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.7.4
