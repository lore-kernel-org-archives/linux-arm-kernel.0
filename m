From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 12 May 2016 15:13:47 +0530
Subject: [RESEND PATCH v4 2/3] Documentation: DT: vdma: Add clock support for
 dmas
In-Reply-To: <1463046228-21651-1-git-send-email-appanad@xilinx.com>
References: <1463046228-21651-1-git-send-email-appanad@xilinx.com>
Message-ID: <1463046228-21651-3-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the binding doc with clock description
for AXI DMA's.

Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
index fcc2b65..a1f2683 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
@@ -21,6 +21,18 @@ Required properties:
 - dma-channel child node: Should have at least one channel and can have up to
 	two channels per device. This node specifies the properties of each
 	DMA channel (see child node properties below).
+- clocks: Input clock specifier. Refer to common clock bindings.
+- clock-names: List of input clocks
+	For VDMA:
+	Required elements: "s_axi_lite_aclk"
+	Optional elements: "m_axi_mm2s_aclk" "m_axi_s2mm_aclk",
+			   "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
+	For CDMA:
+	Required elements: "s_axi_lite_aclk", "m_axi_aclk"
+	FOR AXIDMA:
+	Required elements: "s_axi_lite_aclk"
+	Optional elements: "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
+			   "m_axi_sg_aclk"
 
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
@@ -60,6 +72,9 @@ axi_vdma_0: axivdma at 40030000 {
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
2.1.1
