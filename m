From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 14:26:56 -0700
Subject: [PATCH] ARM: OMAP3: Beagle: fix OPP customization and initcall
 ordering
In-Reply-To: <1350938009-22716-1-git-send-email-khilman@deeprootsystems.com>
References: <1350938009-22716-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121022212656.GK4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121022 13:35]:
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -24,6 +24,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/opp.h>
> +#include <linux/cpu.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -444,12 +445,13 @@ static struct omap_board_mux board_mux[] __initdata = {
>  };
>  #endif
>  
> -static void __init beagle_opp_init(void)
> +static int __init beagle_opp_init(void)
>  {
>  	int r = 0;

Don't you need to add some check here for machine_is
to prevent this from running on other boards if you now
make this into an initcall?

Regards,

Tony
