From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 17 May 2013 11:08:27 +0000
Subject: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
 GFX hwmod
In-Reply-To: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
References: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8C092@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Sunday, May 05, 2013 12:18 AM
> To: linux-omap at vger.kernel.org
> Cc: tony at atomide.com; linux-arm-kernel at lists.infradead.org; Hiremath,
> Vaibhav; Paul Walmsley
> Subject: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
> GFX hwmod
> 
> GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> so update the GFX hwmod data with .rstst_off and .st_shift
> information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index d1cf3ab..38c7b04 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -329,7 +329,7 @@ static struct omap_hwmod_class
> am33xx_gfx_hwmod_class = {
>  };
> 
>  static struct omap_hwmod_rst_info am33xx_gfx_resets[] = {
> -	{ .name = "gfx", .rst_shift = 0 },
> +	{ .name = "gfx", .rst_shift = 0, .st_shift = 0},
>  };
> 
>  static struct omap_hwmod_irq_info am33xx_gfx_irqs[] = {
> @@ -347,6 +347,7 @@ static struct omap_hwmod am33xx_gfx_hwmod = {
>  		.omap4	= {
>  			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
>  			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
> +			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
>  			.modulemode	= MODULEMODE_SWCTRL,
>  		},
>  	},
> --

Tony and Paul,

Any Update on this one as well?

Thanks,
Vaibhav
