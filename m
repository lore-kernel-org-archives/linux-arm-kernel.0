From: Ramiro.Oliveira@synopsys.com (Ramiro Oliveira)
Date: Mon,  6 Mar 2017 12:17:38 +0000
Subject: [PATCH v2 1/2] dma: xilinx: Edit device tree bindings documentation
In-Reply-To: <cover.1488801913.git.roliveir@synopsys.com>
References: <cover.1488801913.git.roliveir@synopsys.com>
Message-ID: <ce2a9ee846013b452e53e05c2be3c7861fa6d169.1488801913.git.roliveir@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset property documentation for Xilinx DMA

Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..96c469a4717f 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -40,6 +40,7 @@ Required properties for VDMA:
 Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
+- resets : External reset specifier. See ../../reset/reset.txt for details.
 Optional properties for AXI DMA:
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
@@ -83,6 +84,7 @@ axi_vdma_0: axivdma at 40030000 {
 	clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
 	clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
 		      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
+	resets = <&rst 2>;
 	dma-channel at 40030000 {
 		compatible = "xlnx,axi-vdma-mm2s-channel";
 		interrupts = < 0 54 4 >;
-- 
2.11.0
