From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:59:51 -0700
Subject: [PATCH v2] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
In-Reply-To: <1349604805.6017.1.camel@phoenix>
References: <1349604805.6017.1.camel@phoenix>
Message-ID: <20121008215950.GV13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Lin <axel.lin@ingics.com> [121007 03:14]:
> This fixes below build error when CONFIG_LEDS_CLASS is not set.
> 
>   LD      init/built-in.o
> arch/arm/plat-omap/built-in.o: In function `fpga_probe':
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> arch/arm/plat-omap/built-in.o:arch/arm/plat-omap/debug-leds.c:113: more undefined references to `led_classdev_register' follow
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks looks like I have already an earlier version of the same
patch from you already queued.

Regards,

Tony

> ---
>  arch/arm/plat-omap/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ca83a76..c262781 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -43,6 +43,7 @@ config OMAP_DEBUG_DEVICES
>  
>  config OMAP_DEBUG_LEDS
>  	def_bool y if NEW_LEDS
> +	select LEDS_CLASS
>  	depends on OMAP_DEBUG_DEVICES
>  
>  config POWER_AVS_OMAP
> -- 
> 1.7.9.5
> 
> 
> 
