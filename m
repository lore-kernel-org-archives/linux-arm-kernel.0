From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 5 Oct 2012 08:58:51 -0500
Subject: [PATCH 07/16] ARM: OMAP: Make plat/sram.h local to plat-omap
In-Reply-To: <20121004220449.26676.54281.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220449.26676.54281.stgit@muffinssi.local>
Message-ID: <506EE79B.8040507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 10/04/2012 05:04 PM, Tony Lindgren wrote:
> We can move this from plat to be local to plat-omap
> for common ARM zImage support.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/clock.c                  |    3 -
>  arch/arm/mach-omap1/clock_data.c             |    3 -
>  arch/arm/mach-omap1/devices.c                |    2 
>  arch/arm/mach-omap1/pm.c                     |    3 -
>  arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    3 -
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    3 -
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |    3 -
>  arch/arm/mach-omap2/io.c                     |    3 -
>  arch/arm/mach-omap2/omap4-common.c           |    4 -
>  arch/arm/mach-omap2/pm24xx.c                 |    3 -
>  arch/arm/mach-omap2/pm34xx.c                 |    3 -
>  arch/arm/mach-omap2/sdrc.c                   |    2 
>  arch/arm/mach-omap2/sdrc2xxx.c               |    2 
>  arch/arm/mach-omap2/sleep34xx.S              |    2 
>  arch/arm/plat-omap/common.h                  |    2 
>  arch/arm/plat-omap/include/plat/sram.h       |  105 -------------------------
>  arch/arm/plat-omap/sram.c                    |    1 
>  arch/arm/plat-omap/sram.h                    |  109 +++++++++++++++++++++++++-
>  18 files changed, 130 insertions(+), 126 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/plat/sram.h
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 638f407..b15d4ee 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -24,11 +24,12 @@
>  #include <plat/cpu.h>
>  #include <plat/usb.h>
>  #include <plat/clock.h>
> -#include <plat/sram.h>
>  #include <plat/clkdev_omap.h>
>  
>  #include <mach/hardware.h>
>  
> +#include "../plat-omap/sram.h"

Any reason why you did not put this in
arch/arm/plat-omap/include/plat-omap/ like we were discussing for dma
and dmtimers headers? Then it can be just "#include <plat-omap/sram.h>".
Just curious ...

Cheers
Jon
