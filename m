From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 01 Mar 2012 08:45:20 +1100
Subject: ARM: ep93xx: convert vision_ep9307 to MULTI_IRQ_HANDLER
In-Reply-To: <201202291312.21318.hartleys@visionengravers.com>
References: <201202291312.21318.hartleys@visionengravers.com>
Message-ID: <4F4E9C70.70602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/12 07:12, H Hartley Sweeten wrote:

> As done for the other ep93xx machines in:
> 
> commit 9a6879bd902e2ec605fff4d9fb3247b440a1f66a
> ARM: ep93xx: convert to MULTI_IRQ_HANDLER
> 
> Now that there is a generic IRQ handler for multiple VIC devices use it
> for vision_ep9307 to help building multi platform kernels.
> 
> Signed-off-by: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Jamie Iles <jamie@jamieiles.com>


Acked-by: Ryan Mallon <rmallon@gmail.com>

> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
> index d5fb44f..d67d0b4 100644
> --- a/arch/arm/mach-ep93xx/vision_ep9307.c
> +++ b/arch/arm/mach-ep93xx/vision_ep9307.c
> @@ -34,6 +34,7 @@
>  #include <mach/ep93xx_spi.h>
>  #include <mach/gpio-ep93xx.h>
>  
> +#include <asm/hardware/vic.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
> @@ -361,6 +362,7 @@ MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
>  	.atag_offset	= 0x100,
>  	.map_io		= vision_map_io,
>  	.init_irq	= ep93xx_init_irq,
> +	.handle_irq	= vic_handle_irq,
>  	.timer		= &ep93xx_timer,
>  	.init_machine	= vision_init_machine,
>  	.restart	= ep93xx_restart,
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
