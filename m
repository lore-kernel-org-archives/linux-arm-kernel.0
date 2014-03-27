From: harinik@xilinx.com (Harini Katakam)
Date: Thu, 27 Mar 2014 20:55:06 +0530
Subject: [PATCH 2/2] Devicetree: Add Zynq GPIO devicetree bindings
 documentation
In-Reply-To: <1395933906-2268-1-git-send-email-harinik@xilinx.com>
References: <1395933906-2268-1-git-send-email-harinik@xilinx.com>
Message-ID: <1395933906-2268-2-git-send-email-harinik@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio-zynq bindings documentation.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 .../devicetree/bindings/gpio/gpio-zynq.txt         |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-zynq.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.txt b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
new file mode 100644
index 0000000..1b6e83f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.txt
@@ -0,0 +1,24 @@
+Xilinx Zynq GPIO controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- #gpio-cells 		: Should be two. First cell is used to mention
+			  pin number.
+- compatible		: Should be "xlnx,zynq-gpio-1.0"
+- clocks		: Clock phandles (see clock bindings for details)
+- gpio-controller	: Marks the device node as a GPIO controller.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- reg			: Address and length of the register set for the device
+
+Example:
+		gpio at e000a000 {
+			#gpio-cells = <2>;
+			compatible = "xlnx,zynq-gpio-1.0";
+			clocks = <&clkc 42>;
+			gpio-controller ;
+			interrupt-parent = <&intc>;
+			interrupts = <0 20 4>;
+			reg = <0xe000a000 0x1000>;
+		} ;
-- 
1.7.9.5
