From: khilman@ti.com (Kevin Hilman)
Date: Tue, 06 Mar 2012 15:55:47 -0800
Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
In-Reply-To: <20120306212605.GY12083@atomide.com> (Tony Lindgren's message of
 "Tue, 6 Mar 2012 13:26:06 -0800")
References: <20120306212605.GY12083@atomide.com>
Message-ID: <87pqcpb7y4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 5 Mar 2012 15:32:38 -0800
> Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
>
> Make omap_mpuio_alloc_gc() __devinit as omap_gpio_chip_init()
> is __devinit. Otherwise we get:
>
> WARNING: vmlinux.o(.devinit.text+0xa10): Section mismatch in reference
> from the function omap_gpio_chip_init() to the function .init.text:omap_mpuio_alloc_gc()
> The function __devinit omap_gpio_chip_init() references
> a function __init omap_mpuio_alloc_gc().
> If omap_mpuio_alloc_gc is only used by omap_gpio_chip_init then
> annotate omap_mpuio_alloc_gc with a matching annotation.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@ti.com>



> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1081,7 +1081,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
>  	}
>  }
>  
> -static __init void
> +static __devinit void
>  omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
>  		    unsigned int num)
>  {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
