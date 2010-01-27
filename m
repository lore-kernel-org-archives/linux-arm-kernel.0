From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 27 Jan 2010 19:28:51 +0100
Subject: [PATCH 03/10] ARM: LPC32XX: core architecture files
In-Reply-To: <20100127010335.GH9153@trinity.fluff.org>
References: <1264551591.6528.6@usb10132>
	<20100127010335.GH9153@trinity.fluff.org>
Message-ID: <083DF309106F364B939360100EC290F805C8A0A065@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
> > +	{
> > +		.chip = {
> > +			.label			= "gpio_p0",
> > +			.direction_input	= lpc32xx_gpio_dir_input,
> > +			.get			= lpc32xx_gpio_get_value,
> > +			.direction_output	= lpc32xx_gpio_dir_output,
> > +			.set			= lpc32xx_gpio_set_value,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPIO_P0_GRP,
> > +			.ngpio			= GPIO_P0_MAX,
> > +			.names			= gpio_p0_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[0],
> > +	},
> > +	{
> > +		.chip = {
> > +			.label			= "gpio_p1",
> > +			.direction_input	= lpc32xx_gpio_dir_input,
> > +			.get			= lpc32xx_gpio_get_value,
> > +			.direction_output	= lpc32xx_gpio_dir_output,
> > +			.set			= lpc32xx_gpio_set_value,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPIO_P1_GRP,
> > +			.ngpio			= GPIO_P1_MAX,
> > +			.names			= gpio_p1_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[1],
> > +	},
> > +	{
> > +		.chip = {
> > +			.label			= "gpio_p2",
> > +			.direction_input	= lpc32xx_gpio_dir_input,
> > +			.get			= lpc32xx_gpio_get_value,
> > +			.direction_output	= lpc32xx_gpio_dir_output,
> > +			.set			= lpc32xx_gpio_set_value,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPIO_P2_GRP,
> > +			.ngpio			= GPIO_P2_MAX,
> > +			.names			= gpio_p2_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[2],
> > +	},
> > +	{
> > +		.chip = {
> > +			.label			= "gpio_p3",
> > +			.direction_input	= lpc32xx_gpio_dir_input,
> > +			.get			= lpc32xx_gpio_get_value,
> > +			.direction_output	= lpc32xx_gpio_dir_output,
> > +			.set			= lpc32xx_gpio_set_value,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPIO_P3_GRP,
> > +			.ngpio			= GPIO_P3_MAX,
> > +			.names			= gpio_p3_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[3],
> > +	},
> > +	{
> > +		.chip = {
> > +			.label			= "gpi_p3",
> > +			.direction_input	= lpc32xx_gpio_dir_in_always,
> > +			.get			= lpc32xx_gpi_get_value,
> > +			.direction_output	= lpc32xx_gpio_dir_out_none,
> > +			.set			= lpc32xx_gpo_set_none,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPI_P3_GRP,
> > +			.ngpio			= GPI_P3_MAX,
> > +			.names			= gpi_p3_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[3],
> 
> if you've got 1:1 mapping of gpio_grp to chip, then why not have the
> initialisation here and avoid an extra array?

Thanks for your feedback - I'll check gpiolib and update.

The mapping is only 1:1 for the first 4 indices of
lpc32xx_gpiochip[0..3].gpio_grp, while lpc32xx_gpiochip[4..5].gpio_grp
reuse gpio_grp_regs[3]. This was done to save a few bytes of memory.

> 
> > +	},
> > +	{
> > +		.chip = {
> > +			.label			= "gpo_p3",
> > +			.direction_input	= lpc32xx_gpio_dir_in_none,
> > +			.get			= lpc32xx_gpio_get_none,
> > +			.direction_output	= lpc32xx_gpio_dir_out_always,
> > +			.set			= lpc32xx_gpo_set_value,
> > +			.request		= lpc32xx_gpio_request,
> > +			.base			= GPO_P3_GRP,
> > +			.ngpio			= GPO_P3_MAX,
> > +			.names			= gpo_p3_names,
> > +			.can_sleep		= 0,
> > +		},
> > +		.gpio_grp = &gpio_grp_regs[3],
> > +	},
> > +};
> > +
