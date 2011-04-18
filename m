From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 18 Apr 2011 12:43:08 -0500
Subject: [patch 21/23] arm: Cleanup the irq namespace
In-Reply-To: <20110325132049.382413026@linutronix.de>
References: <20110325131617.258789658@linutronix.de>
	<20110325132049.382413026@linutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D221CD07@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 25, 2011 6:22 AM, Thomas Gleixner wrote:
> 
> Convert to the new function names. Automated with coccinelle.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
 arch/arm/mach-ep93xx/gpio.c                    |   31 +++++++++++------

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

This appears to be the same patch as [27/29] arm: Cleanup the irq namespace

Regards,
Hartley
