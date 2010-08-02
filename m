From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 2 Aug 2010 10:46:43 +0300
Subject: [PATCH] ARM: imx: Fix build failure when including
	<mach/gpio.h> without <linux/spinlock.h>
In-Reply-To: <1280734183-4315-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100729064241.GB11268@pengutronix.de>
	<1280734183-4315-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100802074643.GB25825@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Aug 02, 2010 at 09:29:43AM +0200, Uwe Kleine-K?nig wrote:
> This is a follow up to
> 
> 	14cb0de (arm/imx/gpio: add spinlock protection)
> 
> and fixes the following build failure:
> 
> 	  CC      arch/arm/mach-imx/pcm970-baseboard.o
> 	In file included from arch/arm/include/asm/gpio.h:6,
> 			 from include/linux/gpio.h:8,
> 			 from arch/arm/mach-imx/pcm970-baseboard.c:20:
> 	arch/arm/plat-mxc/include/mach/gpio.h:40: error: expected specifier-qualifier-list before 'spinlock_t'
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> Cc: stable at kernel.org
> ---
> Kernel-Version: v2.6.35-rc1-133-g14cb0de
> 
> Hello,
> 
> as 14cb0de has a Cc: for stable, I added it here, too.
> 
> Thanks
> Uwe
> 
>  arch/arm/plat-mxc/include/mach/gpio.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
> index 661fbc6..af33b74 100644
> --- a/arch/arm/plat-mxc/include/mach/gpio.h
> +++ b/arch/arm/plat-mxc/include/mach/gpio.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASM_ARCH_MXC_GPIO_H__
>  #define __ASM_ARCH_MXC_GPIO_H__
>  
> +#include <linux/spinlock.h>
>  #include <mach/hardware.h>
>  #include <asm-generic/gpio.h>

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
