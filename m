From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Jan 2011 08:44:41 +0100
Subject: [PATCH v2 1/2] dmaengine: imx-sdma: propagate error in
	sdma_probe() instead of returning 0
In-Reply-To: <1295435586-9538-1-git-send-email-shawn.guo@freescale.com>
References: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
	<1295435586-9538-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110119074441.GG10686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 07:13:06PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d5a5d4d..48d0197 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1348,7 +1348,7 @@ err_clk:
>  err_request_region:
>  err_irq:
>  	kfree(sdma);
> -	return 0;
> +	return ret;
>  }
>  
>  static int __exit sdma_remove(struct platform_device *pdev)
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
