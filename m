From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 14 Dec 2016 21:56:10 +0200
Subject: [PATCH 1/2] xilinx_dma: Edit device tree bindings documentation
In-Reply-To: <78b8d3b8540a2310818cf0c5b05adbc29e067981.1481735244.git.roliveir@synopsys.com>
References: <cover.1481735244.git.roliveir@synopsys.com>
 <78b8d3b8540a2310818cf0c5b05adbc29e067981.1481735244.git.roliveir@synopsys.com>
Message-ID: <12776575.5mdqB62qf1@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ramiro,

Thank you for the patch.

On Wednesday 14 Dec 2016 17:18:23 Ramiro Oliveira wrote:
> Add reset property documentation for Xilinx DMA
> 
> Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt index
> a2b8bfa..7ebce72 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -40,6 +40,10 @@ Required properties for VDMA:
>  Optional properties:
>  - xlnx,include-sg: Tells configured for Scatter-mode in
>  	the hardware.
> +- resets : Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names : Must include the following entries:
> +  - reset

If the IP core has a single reset, can't we omit the name ?

>  Optional properties for AXI DMA:
>  - xlnx,mcdma: Tells whether configured for multi-channel mode in the
> hardware. Optional properties for VDMA:
> @@ -83,6 +87,8 @@ axi_vdma_0: axivdma at 40030000 {
>  	clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
>  	clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
>  		      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
> +	resets = <&rst 2>;
> +	reset-names = "reset";
>  	dma-channel at 40030000 {
>  		compatible = "xlnx,axi-vdma-mm2s-channel";
>  		interrupts = < 0 54 4 >;

-- 
Regards,

Laurent Pinchart
