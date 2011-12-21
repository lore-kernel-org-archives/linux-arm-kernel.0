From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 13:10:23 +0900
Subject: [PATCH] ARM: remove header files included more than once
In-Reply-To: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
References: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <061b01ccbf96$763f95e0$62bec1a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar Ramirez Luna wrote:
> 
> checkincludes.pl complains about these:
> 	linux/debugfs.h
> 	linux/dma-mapping.h
> 	linux/gpio.h
> 	linux/sched.h
> 	linux/slab.h
> 	plat/common.h
> 	plat/i2c.h
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-bcmring/dma.c                 |    1 -
>  arch/arm/mach-ks8695/leds.c                 |    1 -
>  arch/arm/mach-mmp/aspenite.c                |    1 -
>  arch/arm/mach-mmp/tavorevb.c                |    1 -
>  arch/arm/mach-msm/board-msm7x30.c           |    1 -
>  arch/arm/mach-msm/board-qsd8x50.c           |    1 -
>  arch/arm/mach-omap2/board-ldp.c             |    1 -
>  arch/arm/mach-omap2/io.c                    |    1 -
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    1 -
>  arch/arm/mach-pxa/pxa25x.c                  |    1 -
>  arch/arm/mach-pxa/pxa27x.c                  |    1 -
>  arch/arm/mach-pxa/saarb.c                   |    1 -
>  arch/arm/mach-shmobile/board-ag5evm.c       |    1 -
>  arch/arm/mach-ux500/board-mop500-u8500uib.c |    1 -
>  arch/arm/plat-omap/clock.c                  |    1 -
>  arch/arm/plat-samsung/dev-backlight.c       |    1 -
>  16 files changed, 0 insertions(+), 16 deletions(-)
> 

(snip)

> diff --git a/arch/arm/plat-samsung/dev-backlight.c
b/arch/arm/plat-samsung/dev-backlight.c
> index e657305..a976c02 100644
> --- a/arch/arm/plat-samsung/dev-backlight.c
> +++ b/arch/arm/plat-samsung/dev-backlight.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/pwm_backlight.h>
> -#include <linux/slab.h>
> 
>  #include <plat/devs.h>
>  #include <plat/gpio-cfg.h>
> --
> 1.7.4.1

Hi,

Above has been already fixed in mainline.
:commit d7a4c45ec24b6c6773ff302c3c9cb5ed46c8e211 ("ARM: SAMSUNG: remove
duplicated header include").

Anyway, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
