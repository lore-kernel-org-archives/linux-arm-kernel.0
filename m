From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 18 Apr 2011 12:37:43 -0500
Subject: [patch 27/29] arm: Cleanup the irq namespace
In-Reply-To: <20110328170653.348149801@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170653.348149801@linutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D221CCE5@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 28, 2011 10:13 AM, Thomas Gleixner wrote:
> 
> Convert to the new function names. Automated with coccinelle.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-ep93xx/gpio.c                    |   31 +++++++++++------
>
> Index: linux-2.6-tip/arch/arm/mach-ep93xx/gpio.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-ep93xx/gpio.c
> +++ linux-2.6-tip/arch/arm/mach-ep93xx/gpio.c
> @@ -231,20 +231,29 @@ void __init ep93xx_gpio_init_irq(void)
>  
>  	for (gpio_irq = gpio_to_irq(0);
>  	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
> -		set_irq_chip(gpio_irq, &ep93xx_gpio_irq_chip);
> -		set_irq_handler(gpio_irq, handle_level_irq);
> +		irq_set_chip(gpio_irq, &ep93xx_gpio_irq_chip);
> +		irq_set_handler(gpio_irq, handle_level_irq);
>  		set_irq_flags(gpio_irq, IRQF_VALID);
>  	}
>  
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO_AB, ep93xx_gpio_ab_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO0MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO1MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO2MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO3MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO4MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO5MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO6MUX, ep93xx_gpio_f_irq_handler);
> -	set_irq_chained_handler(IRQ_EP93XX_GPIO7MUX, ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO_AB,
> +				ep93xx_gpio_ab_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO0MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO1MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO2MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO3MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO4MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO5MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO6MUX,
> +				ep93xx_gpio_f_irq_handler);
> +	irq_set_chained_handler(IRQ_EP93XX_GPIO7MUX,
> +				ep93xx_gpio_f_irq_handler);
>  }

I would suggest keeping these as one line each just for readability.

Other than that:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
