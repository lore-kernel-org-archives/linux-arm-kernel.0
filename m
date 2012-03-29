From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 Mar 2012 08:11:29 -0700
Subject: [PATCH] omap2+: pm: fix compilation break.
In-Reply-To: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
References: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <20120329151128.GT9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj.R <govindraj.raja@ti.com> [120329 03:12]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> Fix the compilation break observed on latest mainline.
> 
> Fixes below compilation break:
> 
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
> arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
> arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
> arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'

Care to mention which commit broke the compile?

Regards,

Tony
 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index a7bdec6..70da4f7 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -16,6 +16,7 @@
>  #include <linux/opp.h>
>  #include <linux/export.h>
>  #include <linux/suspend.h>
> +#include <asm/system_misc.h>
>  
>  #include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
> -- 
> 1.7.5.4
> 
