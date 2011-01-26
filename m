From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 27 Jan 2011 06:09:57 +0800
Subject: [PATCH] ARM: mxs: acknowledge gpio irq
In-Reply-To: <1295970862-23679-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1295970862-23679-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110126220956.GA9820@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Jan 25, 2011 at 04:54:22PM +0100, Uwe Kleine-K?nig wrote:
> This fixes a machine hang after a gpio irq triggered.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mxs/gpio.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
> index d7ad7a6..cb0c0e8 100644
> --- a/arch/arm/mach-mxs/gpio.c
> +++ b/arch/arm/mach-mxs/gpio.c
> @@ -139,6 +139,8 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  	struct mxs_gpio_port *port = (struct mxs_gpio_port *)get_irq_data(irq);
>  	u32 gpio_irq_no_base = port->virtual_irq_start;
>  
> +	desc->irq_data.chip->irq_ack(&desc->irq_data);
> +
>  	irq_stat = __raw_readl(port->base + PINCTRL_IRQSTAT(port->id)) &
>  			__raw_readl(port->base + PINCTRL_IRQEN(port->id));
>  
Acked-by: Shawn Guo <shawn.guo@freescale.com>

The implementation were referring to mxc gpio.  We are not running
into this problem on mxc?

Regards,
Shawn
