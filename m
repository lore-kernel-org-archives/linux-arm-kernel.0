From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 28 Jan 2012 11:29:47 -0700
Subject: [PATCH 2/3] ARM: at91/tc: add device tree support to atmel_tclib
In-Reply-To: <185a4d609becfcd60bbd15b09612160cf6ea9346.1326995849.git.nicolas.ferre@atmel.com>
References: <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
 <185a4d609becfcd60bbd15b09612160cf6ea9346.1326995849.git.nicolas.ferre@atmel.com>
Message-ID: <20120128182947.GA4053@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 07:05:11PM +0100, Nicolas Ferre wrote:
> Device tree support added to atmel_tclib: the generic Timer Counter
> library. This is used by the clocksource/clockevent driver tcb_clksrc.
> 
> The current DT enabled platforms are also modified to use it:
> - .dtsi files are modified to add Timer Counter Block entries
> - alias are created to allow identification of each block
> - clkdev lookup tables are added for clocks identification.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
...
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 545bbe9..a0a217d 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -995,8 +995,25 @@ static struct platform_device at91sam9g45_tcb1_device = {
>  	.num_resources	= ARRAY_SIZE(tcb1_resources),
>  };
>  
> +#if defined(CONFIG_OF)
> +static struct of_device_id tcb_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-tcb" },
> +	{ /*sentinel*/ }
> +};
> +#endif
> +

Where is the documentation for this new binding?  Every new binding must
be documented in Documentation/devicetree/bindings, even if it is just a
short file listing all the trivial (only reg and irq) bindings used by
atmel devices.

Otherwise this looks fine and you can add my Acked-by:

g.
