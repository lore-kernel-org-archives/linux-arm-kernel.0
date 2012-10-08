From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 11:09:00 -0700
Subject: [PATCH 1/2] ARM: OMAP: Trivial driver changes to remove
 include plat/cpu.h
In-Reply-To: <20121008173557.10603.18539.stgit@muffinssi>
References: <20121008173452.10603.53886.stgit@muffinssi>
 <20121008173557.10603.18539.stgit@muffinssi>
Message-ID: <20121008180900.GL3874@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121008 10:37]:
> Drivers should not use cpu_is_omap or cpu_class_is_omap macros,
> they should be private to the platform init code. And we'll be
> removing plat/cpu.h and only have a private soc.h for the
> arch/arm/*omap* code.
> 
> This patch is intended as preparation for the core omap changes
> and removes the need to include plat/cpu.h from several drivers.
> This is needed for the ARM common zImage support.
> 
> These changes are OK to do because:
> 
> - omap-rng.c and hsmmc.c don't need plat/cpu.h
> 
> - omap-aes.c and omap-sham.c get the proper platform_data
>   passed to them so they don't need extra checks in the driver
> 
> - omap-dma.c and omap-pcm.c can test the arch locally as
>   omap1 and omap2 cannot be compiled together because of
>   conflicting compiler flags


> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -40,7 +40,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/mmc-omap.h>
>  #include <mach/hardware.h>
> -#include <plat/cpu.h>
>  
>  /* OMAP HSMMC Host Controller Registers */
>  #define OMAP_HSMMC_SYSSTATUS	0x0014

Actually I'll fold this mmc change into an earlier patch
I've posted as "ARM: OMAP: Split plat/mmc.h into local headers
and platform_data".

Regards,

Tony
