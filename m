From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 17 Jan 2011 19:28:30 +0100
Subject: [PATCH 1/2] dmaengine: imx-sdma: fix return of sdma_probe()
In-Reply-To: <1295275164-7824-2-git-send-email-shawn.guo@freescale.com>
References: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
	<1295275164-7824-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110117182830.GU6917@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you make the commit log read something like:

  dmaengine: imx-sdma: propagate error in sdma_probe instead of returning 0

you can have my ack.

Uwe

On Mon, Jan 17, 2011 at 10:39:23PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
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

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
