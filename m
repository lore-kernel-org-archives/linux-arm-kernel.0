From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Feb 2014 12:07:28 +0100
Subject: [PATCH] ARM: shmobile: Remove Koelsch DT reference legacy clock
 bits
In-Reply-To: <20140217072128.27086.81905.sendpatchset@w520>
References: <20140217072128.27086.81905.sendpatchset@w520>
Message-ID: <1596799.v8LFvK73gu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Monday 17 February 2014 16:21:28 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Koelsch DT reference is these days built for multiplatform
> only which means that CCF comes with the package. Remove
> unused legacy code ifdefs to clean up the code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Written against renesas-devel-v3.14-rc3-20140217
> 
>  arch/arm/mach-shmobile/board-koelsch-reference.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-02-17
> 16:10:07.000000000 +0900 @@ -84,7 +84,6 @@ static void __init
> koelsch_add_du_device
> 
>  static void __init koelsch_add_standard_devices(void)
>  {
> -#ifdef CONFIG_COMMON_CLK
>  	/*
>  	 * This is a really crude hack to provide clkdev support to the CMT and
>  	 * DU devices until they get moved to DT.
> @@ -125,9 +124,7 @@ static void __init koelsch_add_standard_
>  			clk_put(clk);
>  		}
>  	}
> -#else
> -	r8a7791_clock_init();
> -#endif
> +
>  	r8a7791_add_dt_devices();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,

Laurent Pinchart
