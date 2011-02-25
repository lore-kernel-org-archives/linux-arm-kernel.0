From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 25 Feb 2011 12:34:51 +0000
Subject: [PATCH] S3C64XX: Tone down SDHCI debugging
In-Reply-To: <1298578262-25391-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1298578262-25391-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110225123451.GA22646@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 08:11:02PM +0000, Mark Brown wrote:
> The MMC core calls s3c6400_setup_sdhcp_cfg_card() very frequently, causing
> the log message in there at KERN_INFO to be displayed a lot which is slow
> and overly chatty. Convert the message into a pr_debug() to tone this down.

ok, will look at merging this for next kernel
 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/setup-sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/setup-sdhci.c b/arch/arm/mach-s3c64xx/setup-sdhci.c
> index 1a94203..f344a22 100644
> --- a/arch/arm/mach-s3c64xx/setup-sdhci.c
> +++ b/arch/arm/mach-s3c64xx/setup-sdhci.c
> @@ -56,7 +56,7 @@ void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
>  	else
>  		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
>  
> -	printk(KERN_INFO "%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
> +	pr_debug("%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
>  	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
>  	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
>  }
> -- 
> 1.7.2.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
