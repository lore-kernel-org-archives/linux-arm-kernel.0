From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Nov 2012 08:27:05 -0800
Subject: [PATCH 1/7] ARM: omap: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-2-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
 <1352360783-17523-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20121108162705.GB6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Szyprowski <m.szyprowski@samsung.com> [121107 23:48]:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/io.c              |    1 -
>  arch/arm/mach-omap2/io.c              |   12 ------------
>  arch/arm/plat-omap/common.c           |    7 -------
>  arch/arm/plat-omap/include/plat/dma.h |    1 -
>  4 files changed, 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
> index 6a5baab..b3d0fb3 100644
> --- a/arch/arm/mach-omap1/io.c
> +++ b/arch/arm/mach-omap1/io.c
> @@ -134,7 +134,6 @@ void __init omap1_init_early(void)
>  	 */
>  	omap1_clk_init();
>  	omap1_mux_init();
> -	omap_init_consistent_dma_size();
>  }
>  
>  void __init omap1_init_late(void)
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 4234d28..2597846 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -354,11 +354,6 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
>  	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
>  }
>  
> -static void __init omap_common_init_early(void)
> -{
> -	omap_init_consistent_dma_size();
> -}
> -
>  static void __init omap_hwmod_init_postsetup(void)
>  {
>  	u8 postsetup_state;
...

Thanks we already have a similar patch from Tomi Valkeinen queued in
the omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 branch, so
this patch can be dropped.

Regards,

Tony
