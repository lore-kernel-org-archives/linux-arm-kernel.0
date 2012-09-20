From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2012 11:23:06 -0700
Subject: arm-soc/for-next: fixup compile after platform_data move
In-Reply-To: <87obl0hcp5.fsf@deeprootsystems.com>
References: <87obl0hcp5.fsf@deeprootsystems.com>
Message-ID: <20120920182306.GG28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [120920 09:39]:
> Arnd, Olof,
> 
> Not sure if this has been reported yet, but arm-soc/for-next now has a
> build error on omap due to the recent merge of the platform_data move
> series.
> 
> The arm-soc/next/soc branch contains the arm-soc/omap/am33xx branch
> which adds an include of "plat/mscpi.h" which has now moved.
> 
> Below is a simple fix.
> 
> Kevin
> 
> 
> From cae062932d1d28e499b03d31da815fc2696badfd Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 20 Sep 2012 09:28:43 -0700
> Subject: [PATCH] ARM: OMAP: AM33xx hwmod: fixup SPI after platform_data move
> 
> AM33xx hwmod data includes "mcspi.h" which has now been moved after
> the platform_data move.  Fix it.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 22433cb..59d5c1c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -17,9 +17,9 @@
>  #include <plat/omap_hwmod.h>
>  #include <plat/cpu.h>
>  #include <linux/platform_data/gpio-omap.h>
> +#include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <plat/dma.h>
>  #include <plat/mmc.h>
> -#include <plat/mcspi.h>
>  #include <plat/i2c.h>
>  
>  #include "omap_hwmod_common_data.h"
> -- 
> 1.7.9.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
