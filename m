From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Jul 2010 22:00:05 +0200
Subject: [PATCH 2/5] colibri-pxa300: fix ac97 init on pxa310
In-Reply-To: <201007081904.05309.pieterg@gmx.com>
References: <201007081904.05309.pieterg@gmx.com>
Message-ID: <201007082200.05319.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 19:04:05 pieterg napsal(a):
> The wrong CONFIG defines were checked, and the <mach/audio.h>
> include was missing
> 
> Signed-off-by: pieter <p.grimmerink@inepro.com>
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

It looks correct ...

Acked-by: Marek Vasut <marek.vasut@gmail.com>
