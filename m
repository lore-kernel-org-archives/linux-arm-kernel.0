From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 2 Apr 2014 18:46:01 +0530
Subject: [PATCH v7 2/2] can: Add xilinx CAN device tree bindings documentation
Message-ID: <048cb313-b822-43cc-8280-feec6a3af96b@CH1EHSMHS040.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add xilinx CAN bindings documentation.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 .../devicetree/bindings/net/can/xilinx_can.txt     |   44 ++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/xilinx_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/xilinx_can.txt b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
new file mode 100644
index 0000000..450ee1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
@@ -0,0 +1,44 @@
+Xilinx Axi CAN/Zynq CANPS controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-can-1.0" for Zynq CAN
+			  controllers and "xlnx,axi-can-1.00.a" for Axi CAN
+			  controllers.
+- reg			: Physical base address and size of the Axi CAN/Zynq
+			  CANPS registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- clock-names		: List of input clock names - "can_clk", "pclk"
+			  (For CANPS), "can_clk" , "s_axi_aclk"(For AXI CAN)
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- tx-fifo-depth		: Can Tx fifo depth.
+- rx-fifo-depth		: Can Rx fifo depth.
+
+
+Example:
+
+For Zynq CANPS Dts file:
+	zynq_can_0: can at e0008000 {
+			compatible = "xlnx,zynq-can-1.0";
+			clocks = <&clkc 19>, <&clkc 36>;
+			clock-names = "can_clk", "pclk";
+			reg = <0xe0008000 0x1000>;
+			interrupts = <0 28 4>;
+			interrupt-parent = <&intc>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+For Axi CAN Dts file:
+	axi_can_0: axi-can at 40000000 {
+			compatible = "xlnx,axi-can-1.00.a";
+			clocks = <&clkc 0>;
+			clock-names = "can_clk","s_axi_aclk" ;
+			reg = <0x40000000 0x10000>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 59 1>;
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
-- 
1.7.4
