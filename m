From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 20 Apr 2016 17:13:18 +0530
Subject: [PATCH v2 1/2] Documentation: DT: vdma: Add clock support for vdma
Message-ID: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the binding doc with clock description
for vdma.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> Listed down all the clocks supported by the h/w
    as suggested by the Datta.
--> Used IP clock names instead of shortcut clock names.

 Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index fcc2b65..afe9eb7 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -21,6 +21,11 @@ Required properties:
 - dma-channel child node: Should have at least one channel and can have up to
 	two channels per device. This node specifies the properties of each
 	DMA channel (see child node properties below).
+- clocks: Input clock specifier. Refer to common clock bindings.
+- clock-names: List of input clocks "s_axi_lite_aclk", "m_axi_mm2s_aclk"
+	       "m_axi_s2mm_aclk", "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
+	       (list of input cloks may vary based on the ip configuration.
+		see clock bindings for more info).
 
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
@@ -60,6 +65,9 @@ axi_vdma_0: axivdma at 40030000 {
 	xlnx,num-fstores = <0x8>;
 	xlnx,flush-fsync = <0x1>;
 	xlnx,addrwidth = <0x20>;
+	clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
+	clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
+		      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
 	dma-channel at 40030000 {
 		compatible = "xlnx,axi-vdma-mm2s-channel";
 		interrupts = < 0 54 4 >;
-- 
2.1.2
