From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 9 Jul 2010 09:02:27 +0200
Subject: [PATCH 2/5] colibri-pxa300: fix ac97 init on pxa310
In-Reply-To: <201007081904.05309.pieterg@gmx.com>
References: <201007081904.05309.pieterg@gmx.com>
Message-ID: <20100709070227.GR17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 08, 2010 at 07:04:05PM +0200, pieterg wrote:
> The wrong CONFIG defines were checked, and the <mach/audio.h>
> include was missing
> 
> Signed-off-by: pieter <p.grimmerink@inepro.com>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  arch/arm/mach-pxa/colibri-pxa300.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c 
> b/arch/arm/mach-pxa/colibri-pxa300.c
> index 45c23fd..e7762ae 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -26,6 +26,7 @@
>  #include <mach/colibri.h>
>  #include <mach/ohci.h>
>  #include <mach/pxafb.h>
> +#include <mach/audio.h>
>  
>  #include "generic.h"
>  #include "devices.h"
> @@ -145,7 +146,8 @@ static void __init colibri_pxa300_init_lcd(void)
>  static inline void colibri_pxa300_init_lcd(void) {}
>  #endif /* CONFIG_FB_PXA || CONFIG_FB_PXA_MODULE */
>  
> -#if defined(SND_AC97_CODEC) || defined(SND_AC97_CODEC_MODULE)
> +#if	defined(CONFIG_SND_AC97_CODEC) || \
> +	defined(CONFIG_SND_AC97_CODEC_MODULE)
>  static mfp_cfg_t colibri_pxa310_ac97_pin_config[] __initdata = {
>  	GPIO24_AC97_SYSCLK,
>  	GPIO23_AC97_nACRESET,
> -- 
> 1.6.5.rc1.44.ga1675
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
