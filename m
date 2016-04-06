From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 6 Apr 2016 09:20:22 -0700
Subject: [PATCH v3 1/5] Documentation: DT: vdma: Rename vdma-chan prefix
 to dma-chan
In-Reply-To: <1459959335-24083-2-git-send-email-appanad@xilinx.com>
References: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
 <1459959335-24083-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160406162022.GS23198@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-06 at 21:45:31 +0530, Kedareswara rao Appana wrote:
> This patch renames the vdma-mm2s-channel/vdma-s2mm-channel
> property with dma-mm2s-channel/dma-s2mm-channel to sync with
> the driver.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v3:
> ---> New patch.
> 
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> index a86737c..762938f 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> @@ -24,8 +24,8 @@ Optional properties:
>  	{3}, flush s2mm channel
>  
>  Required child node properties:
> -- compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
> -	"xlnx,axi-vdma-s2mm-channel".
> +- compatible: It should be either "xlnx,axi-dma-mm2s-channel" or
> +	"xlnx,axi-dma-s2mm-channel".

This change is not backwards compatible and breaks every user of the
current binding.

	S?ren
