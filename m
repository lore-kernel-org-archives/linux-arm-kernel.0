From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 17 Jan 2013 13:17:06 +0530
Subject: [PATCH v5 2/9] ARM: davinci: devices-da8xx.c: change pr_warning()
 to pr_warn()
In-Reply-To: <1357863807-380-3-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-3-git-send-email-rtivy@ti.com>
Message-ID: <50F7AC7A.6050107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/11/2013 5:53 AM, Robert Tivy wrote:
> Changed all pr_warning() calls to pr_warn(), as advised by checkpatch.pl.
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
> Clean up files that will be otherwise modified in subsequent patch.
> 
>  arch/arm/mach-davinci/devices-da8xx.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 2d5502d..fb2f51b 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -751,7 +751,7 @@ void __iomem * __init da8xx_get_mem_ctlr(void)
>  
>  	da8xx_ddr2_ctlr_base = ioremap(DA8XX_DDR2_CTL_BASE, SZ_32K);
>  	if (!da8xx_ddr2_ctlr_base)
> -		pr_warning("%s: Unable to map DDR2 controller",	__func__);
> +		pr_warn("%s: Unable to map DDR2 controller", __func__);
>  
>  	return da8xx_ddr2_ctlr_base;
>  }

> @@ -876,8 +876,8 @@ int __init da8xx_register_spi(int instance, const struct spi_board_info *info,
>  
>  	ret = spi_register_board_info(info, len);
>  	if (ret)
> -		pr_warning("%s: failed to register board info for spi %d :"
> -			   " %d\n", __func__, instance, ret);
> +		pr_warn("%s: failed to register board info for spi %d : %d\n",
> +			__func__, instance, ret);

This part is not required anymore since this is already fixed by Vivien
Didelot as part of his SPI fixes. I applied rest of the patch for v3.9.
As with previous patch, I fixed the past tense to present in commit text
while applying.

Thanks,
Sekhar
