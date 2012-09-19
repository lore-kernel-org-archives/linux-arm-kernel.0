From: mporter@ti.com (Matt Porter)
Date: Wed, 19 Sep 2012 10:07:05 -0400
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20120919140705.GB16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> new file mode 100644
> index 0000000..a4f59a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -0,0 +1,81 @@
> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +- #dma-cells: 		Must be at least 1. Used to provide DMA controller
> +			specific information. See DMA client binding below for
> +			more details.
> +
> +Optional properties:
> +- #dma-channels: 	Number of DMA channels supported by the controller.
> +- #dma-requests: 	Number of DMA requests signals supported by the
> +			controller.

Shouldn't these two optional properties drop the prefix #?  By
convention adopted from the various original OF/ePAPR/etc specs, the
only properties I would expect to see with this prefix are the
"*-cells" cell sizes. A quick search indicates this is the case
throughout all the current bindings.

-Matt
