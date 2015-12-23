From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Wed, 23 Dec 2015 15:58:25 +0530
Subject: [RFC LINUX PATCH] dt: xilinx: xadc: provision to control clock
 frequency
Message-ID: <1450866505-22069-1-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds parameter to the xilinx-xadc node for controlling
clock frequency.

Following are the possible options for user to control the frequency:
	* 00 : 1/2 of clock frequency
	* 01 : 1/4 of clock frequency
	* 10 : 1/8 of clock frequency
	* 11 : 1/16 of clock frequency

So this patch adds parameter tck-rate to set user defined values from
above pool to control the clock frequency.

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
index d71258e..2cabb9b 100644
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -20,6 +20,11 @@ Required properties:
 	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
 	  when using the AXI-XADC pcore this must be the clock that provides the
 	  clock to the AXI bus interface of the core.
+	- tck-rate: clock frequency control
+		* 0x0: 1/2  of clock frequency
+		* 0x1: 1/4  of clock frequency
+		* 0x2: 1/8  of clock frequency
+		* 0x3: 1/16 of clock frequency

 Optional properties:
 	- interrupt-parent: phandle to the parent interrupt controller
@@ -79,6 +84,7 @@ Examples:
 		interrupts = <0 7 4>;
 		interrupt-parent = <&gic>;
 		clocks = <&pcap_clk>;
+		tck-rate = <0x3>;

 		xlnx,channels {
 			#address-cells = <1>;
@@ -101,6 +107,7 @@ Examples:
 		interrupts = <0 53 4>;
 		interrupt-parent = <&gic>;
 		clocks = <&fpga1_clk>;
+		tck-rate = <0x3>;

 		xlnx,channels {
 			#address-cells = <1>;
--
2.1.2
