From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 13:58:54 -0800
Subject: [PATCH] ARM: OMAP2+: GPMC: Export gpmc_enable_hwecc and
 gpmc_calculate_ecc
In-Reply-To: <1329489859-23929-1-git-send-email-walle@corscience.de>
References: <1329489859-23929-1-git-send-email-walle@corscience.de>
Message-ID: <20120305215853.GW12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bernhard Walle <walle@corscience.de> [120217 06:15]:
> To be able to compile kernel/drivers/mtd/nand/omap2.ko as module, that
> two symbols need to be exported. Otherwise, I get following error
> message
> 
>     ERROR: "gpmc_calculate_ecc" [drivers/mtd/nand/omap2.ko] undefined!
>     ERROR: "gpmc_enable_hwecc" [drivers/mtd/nand/omap2.ko] undefined!
> 
> Signed-off-by: Bernhard Walle <walle@corscience.de>

Thanks applying into fixes-non-critical-part2.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/gpmc.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index dfffbbf..00d5108 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -888,6 +888,7 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
>  	gpmc_write_reg(GPMC_ECC_CONFIG, val);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(gpmc_enable_hwecc);
>  
>  /**
>   * gpmc_calculate_ecc - generate non-inverted ecc bytes
> @@ -918,3 +919,4 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
>  	gpmc_ecc_used = -EINVAL;
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
> -- 
> 1.7.9.1
> 
