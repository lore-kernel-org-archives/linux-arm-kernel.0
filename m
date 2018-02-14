From: s-anna@ti.com (Suman Anna)
Date: Wed, 14 Feb 2018 12:22:33 -0600
Subject: [PATCH 1/9] dmaengine: omap-dma: include header for bool type
In-Reply-To: <20180214180714.GQ6364@atomide.com>
References: <20180213013243.8378-1-s-anna@ti.com>
 <20180213013243.8378-2-s-anna@ti.com> <20180214180714.GQ6364@atomide.com>
Message-ID: <bd380317-6892-bf97-ac10-bc672e5ec685@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2018 12:07 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [180213 01:33]:
>> The omap-dmaengine.h header file uses a bool type, so include
>> the linux types.h header file so that it is self-contained.
>> The lack of this header caused some build errors while cleaning
>> up some header files from various omap_hwmod data files.
> 
> Let's rather include types.h directly. Here's a patch
> that replaces your first two patches.

Yeah, I am ok with this as well. I went with the other approach
primarily because whoever includes those header files will need a
similar fixing or rely on others bringing in the types.h.

> 
> Regards,
> 
> Tony
> 
> 8< --------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 14 Feb 2018 09:35:20 -0800
> Subject: [PATCH] ARM: OMAP2+: Include types.h directly for hwmod data
> 
> This is needed in preparation for dropping some unused
> headers that indirectly include types.h.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      | 2 ++
>  arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 2 ++
>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c              | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/types.h>
> +
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/omap-dma.h>
>  #include <plat/dmtimer.h>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> @@ -14,6 +14,8 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/types.h>
> +
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/platform_data/hsmmc-omap.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
> @@ -15,6 +15,8 @@
>   *
>   */
>  
> +#include <linux/types.h>
> +
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/platform_data/hsmmc-omap.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> 
