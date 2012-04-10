From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 11:17:15 +0200
Subject: [PATCH 1/3] ARM i.MX27: Add devicetree support
In-Reply-To: <87lim5zne5.fsf@laptop.org>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
 <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de>
 <87lim5zne5.fsf@laptop.org>
Message-ID: <20120410091715.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Sun, Apr 08, 2012 at 09:48:02PM -0400, Chris Ball wrote:
> >
> > [...]
> > +static int __init imx27_avic_add_irq_domain(struct device_node *np,
> > +				struct device_node *interrupt_parent)
> > +{
> > +	irq_domain_add_simple(np, 0);
> > +	return 0;
> > +}
> > +
> > +static int __init imx27_gpio_add_irq_domain(struct device_node *np,
> > +				struct device_node *interrupt_parent)
> > +{
> > +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> > +
> > +	irq_domain_add_simple(np, gpio_irq_base);
> > +
> > +	return 0;
> > +}
> 
> This patch was merged for 3.4-rc1, but it fails to compile because Grant
> removed irq_domain_add_simple() in 3.4-rc1.

Thanks for noting. I assume that irq_domain_add_legacy is the right
approach here, just like the other i.MX boards do, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
