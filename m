From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 17 Sep 2015 09:14:20 +0300
Subject: [PATCH 6/6] dmaengine: xilinx: Fix module autoload for OF
 platform driver
In-Reply-To: <20150916210017.GA5933@goodgumbo.baconseed.org>
References: <20150916210017.GA5933@goodgumbo.baconseed.org>
Message-ID: <2273902.ke3oao0baF@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 September 2015 23:00:17 Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/xilinx/xilinx_vdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> b/drivers/dma/xilinx/xilinx_vdma.c index d8434d4..6f4b501 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -1349,6 +1349,7 @@ static const struct of_device_id xilinx_vdma_of_ids[]
> = { { .compatible = "xlnx,axi-vdma-1.00.a",},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids);
> 
>  static struct platform_driver xilinx_vdma_driver = {
>  	.driver = {

-- 
Regards,

Laurent Pinchart
