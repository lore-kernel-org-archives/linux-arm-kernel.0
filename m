From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 21 Mar 2012 11:02:11 +0100
Subject: [PATCH 3/6] mmc: atmel-mci: remove the need for
 CONFIG_MMC_ATMELMCI_DMA
In-Reply-To: <c7df6b7863557d95bb8457f5c2b4002ea44c86ff.1331826095.git.nicolas.ferre@atmel.com>
References: <cover.1331826095.git.nicolas.ferre@atmel.com>
 <c7df6b7863557d95bb8457f5c2b4002ea44c86ff.1331826095.git.nicolas.ferre@atmel.com>
Message-ID: <20120321100211.GJ11834@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 04:57:19PM +0100, Nicolas Ferre wrote:
> This Kconfig option is not needed anymore, so remove it.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Regards

Ludovic

> ---
>  drivers/mmc/host/Kconfig     |   10 ----------
>  drivers/mmc/host/atmel-mci.c |    2 --
>  2 files changed, 0 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 455a414..a6fc44a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -288,16 +288,6 @@ config MMC_ATMELMCI
>  
>  	  If unsure, say N.
>  
> -config MMC_ATMELMCI_DMA
> -	bool "Atmel MCI DMA support"
> -	depends on MMC_ATMELMCI && (AVR32 || ARCH_AT91SAM9G45) && DMA_ENGINE
> -	help
> -	  Say Y here to have the Atmel MCI driver use a DMA engine to
> -	  do data transfers and thus increase the throughput and
> -	  reduce the CPU utilization.
> -
> -	  If unsure, say N.
> -
>  config MMC_IMX
>  	tristate "Motorola i.MX Multimedia Card Interface support"
>  	depends on ARCH_MX1
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index e4449a5..b5693fd 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2164,10 +2164,8 @@ static int __exit atmci_remove(struct platform_device *pdev)
>  	atmci_readl(host, ATMCI_SR);
>  	clk_disable(host->mck);
>  
> -#ifdef CONFIG_MMC_ATMELMCI_DMA
>  	if (host->dma.chan)
>  		dma_release_channel(host->dma.chan);
> -#endif
>  
>  	free_irq(platform_get_irq(pdev, 0), host);
>  	iounmap(host->regs);
> -- 
> 1.7.9
> 
