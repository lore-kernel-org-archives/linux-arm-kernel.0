From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 25 May 2010 05:38:11 +0100
Subject: [PATCH 1/2] ARM: SAMSUNG: MMC: Fix build error when both DMA
	and PIO mode selected
In-Reply-To: <4BFB2443.1040701@vscht.cz>
References: <4BFB2443.1040701@vscht.cz>
Message-ID: <20100525043811.GD7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 03:13:39AM +0200, Pinkava J. wrote:
> 
> Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
Acked-by: Ben Dooks <ben-linux@fluff.org>

please send to the linux mmc list and/or akpm for inclusion.

> ---
>  drivers/mmc/host/s3cmci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 2fdf768..4426a4b 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct platform_device
> *pdev)
>  	host->pio_active 	= XFER_NONE;
> 
>  #ifdef CONFIG_MMC_S3C_PIODMA
> -	host->dodma		= host->pdata->dma;
> +	host->dodma		= host->pdata->use_dma;
>  #endif
> 
>  	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 1.7.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
