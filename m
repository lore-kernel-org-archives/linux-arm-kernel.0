From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Oct 2013 10:06:58 +0900
Subject: [PATCH] ARM: shmobile: Cosmetic update of Lager DT Reference
In-Reply-To: <20131016215819.12718.54556.sendpatchset@w520>
References: <20131016215819.12718.54556.sendpatchset@w520>
Message-ID: <20131017010657.GH21728@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 06:58:19AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Clean up the Lager DT reference board code to make it match
> Koelsch DT reference including using the rcar-gen2 header.

This is getting dangerously close to churn.
Do you really want me to take this change?

> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-20131016
> 
>  arch/arm/mach-shmobile/board-lager-reference.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> +++ work/arch/arm/mach-shmobile/board-lager-reference.c	2013-10-08 15:32:05.000000000 +0900
> @@ -20,16 +20,15 @@
>  
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
> +#include <mach/rcar-gen2.h>
>  #include <mach/r8a7790.h>
>  #include <asm/mach/arch.h>
>  
>  static void __init lager_add_standard_devices(void)
>  {
> -	/* clocks are setup late during boot in the case of DT */
>  	r8a7790_clock_init();
> -
>  	r8a7790_add_dt_devices();
> -        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
>  static const char *lager_boards_compat_dt[] __initdata = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
