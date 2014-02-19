From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 18:36:28 +0000 (UTC)
Subject: [PATCH] ARM: DRA7: hwmod data: correct the sysc data for spinlock
In-Reply-To: <1389397388-13247-1-git-send-email-s-anna@ti.com>
References: <1389397388-13247-1-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1402191835330.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jan 2014, Suman Anna wrote:

> The spinlock module's SYSCONFIG register on DRA7xx does not
> support smart wakeup, and also does not have the CLKACTIVITY
> field. The sysc data for spinlock module has been appropriately
> fixed up to reflect the same.
> 
> Cc: Ambresh K <ambresh@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 18f333c..810c205 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1365,11 +1365,10 @@ static struct omap_hwmod_class_sysconfig dra7xx_spinlock_sysc = {
>  	.rev_offs	= 0x0000,
>  	.sysc_offs	= 0x0010,
>  	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
> -			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
> -			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			   SIDLE_SMART_WKUP),
> +	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
> +			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> +			   SYSS_HAS_RESET_STATUS),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>  	.sysc_fields	= &omap_hwmod_sysc_type1,
>  };

Thanks, queued for v3.14-rc.

Please remember to cc the linux-arm-kernel mailing list on all OMAP 
patches.  I've added it to this message.


- Paul
