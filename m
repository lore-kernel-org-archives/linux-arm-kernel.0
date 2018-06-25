From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 11:29:24 -0600
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
In-Reply-To: <20180625092724.22164-2-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-2-andrea.merello@gmail.com>
Message-ID: <20180625172924.GA398@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 11:27:21AM +0200, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add DOC for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- change property name
> 	- property is now optional
> 	- cc DT maintainer
> Changes in v3:
> 	- reword
> 	- cc DT maintainerS and ML
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfaec43c..c894abe28baa 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -41,6 +41,7 @@ Optional properties:
>  - xlnx,include-sg: Tells configured for Scatter-mode in
>  	the hardware.
>  Optional properties for AXI DMA:
> +- xlnx,sg-length-width: Should be the width of the length register as configured in h/w.

What are the units? What are valid values? What is the default if the 
property is not present?

>  - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
>  Optional properties for VDMA:
>  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> -- 
> 2.17.1
> 
