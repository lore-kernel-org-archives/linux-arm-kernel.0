From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Feb 2014 12:07:05 +0100
Subject: [PATCH] ARM: shmobile: Remove Lager DT reference legacy clock bits
In-Reply-To: <20140217071945.27066.10828.sendpatchset@w520>
References: <20140217071945.27066.10828.sendpatchset@w520>
Message-ID: <2604597.BoRkzP9NO2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Monday 17 February 2014 16:19:45 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Lager DT reference is these days built for multiplatform
> only which means that CCF comes with the package. Remove
> unused legacy code ifdefs to clean up the code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Written against renesas-devel-v3.14-rc3-20140217
> 
>  arch/arm/mach-shmobile/board-lager-reference.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> +++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-02-17
> 16:08:31.000000000 +0900 @@ -88,7 +88,6 @@ static void __init
> lager_add_du_device(v
> 
>  static void __init lager_add_standard_devices(void)
>  {
> -#ifdef CONFIG_COMMON_CLK
>  	/*
>  	 * This is a really crude hack to provide clkdev support to platform
>  	 * devices until they get moved to DT.
> @@ -126,9 +125,6 @@ static void __init lager_add_standard_de
>  			clk_put(clk);
>  		}
>  	}
> -#else
> -	r8a7790_clock_init();
> -#endif
> 
>  	r8a7790_add_dt_devices();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,

Laurent Pinchart
