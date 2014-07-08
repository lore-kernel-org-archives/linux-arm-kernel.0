From: harinik@xilinx.com (Harini Katakam)
Date: Tue,  8 Jul 2014 16:32:36 +0530
Subject: [PATCH v3 2/2] devicetree: Add Zynq GPIO devicetree bindings
 documentation
In-Reply-To: <1404817356-21568-1-git-send-email-harinik@xilinx.com>
References: <1404817356-21568-1-git-send-email-harinik@xilinx.com>
Message-ID: <1404817356-21568-2-git-send-email-harinik@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harini Katakam <harini.katakam@xilinx.com>

Add gpio-zynq bindings documentation.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

v3 changes:
Change description of #gpio-cells - use 'gpio-line' instead of 'pin'

v2 changes:
Improve description.

---
 .../devicetree/bindings/gpio/gpio-zynq.txt         |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-zynq.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.txt b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
new file mode 100644
index 0000000..986371a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
@@ -0,0 +1,26 @@
+Xilinx Zynq GPIO controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify optional
+			    parameters (unused)
+- compatible		: Should be "xlnx,zynq-gpio-1.0"
+- clocks		: Clock specifier (see clock bindings for details)
+- gpio-controller	: Marks the device node as a GPIO controller.
+- interrupts		: Interrupt specifier (see interrupt bindings for
+			  details)
+- interrupt-parent	: Must be core interrupt controller
+- reg			: Address and length of the register set for the device
+
+Example:
+	gpio at e000a000 {
+		#gpio-cells = <2>;
+		compatible = "xlnx,zynq-gpio-1.0";
+		clocks = <&clkc 42>;
+		gpio-controller;
+		interrupt-parent = <&intc>;
+		interrupts = <0 20 4>;
+		reg = <0xe000a000 0x1000>;
+	};
-- 
1.7.9.5
