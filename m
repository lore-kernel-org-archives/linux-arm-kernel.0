From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:47:38 +0100
Subject: [PATCH 4/8] s3c6410: sdhci: Enable ADMA feature in 6410 sdhci
	controller.
In-Reply-To: <1252392769-31159-1-git-send-email-thomas.ab@samsung.com>
References: <1252392769-31159-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090916004737.GR13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2009 at 03:52:49PM +0900, thomas.ab at samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch enables ADMA feature in 6410 SDHCI controller
> driver.

Hmm, surely this wouldn't have wrapped and could have goine onto one line?

Also no signoff.

> ---
>  drivers/mmc/host/sdhci-s3c.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index db1bb93..7f5b64e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -329,12 +329,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	host->irq = irq;
>  
>  	/* Setup quirks for the controller */
> -
> -	/* Currently with ADMA enabled we are getting some length
> -	 * interrupts that are not being dealt with, do disable
> -	 * ADMA until this is sorted out. */
> -	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> -	host->quirks |= SDHCI_QUIRK_32BIT_ADMA_SIZE;
> +	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>  
>  #ifndef CONFIG_MMC_SDHCI_S3C_DMA
>  
> -- 
> 1.5.3.4
> 
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
