From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Mar 2014 08:34:31 +0000
Subject: [linux-sunxi] Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
In-Reply-To: <20140322165132.GC20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
Message-ID: <20140324083431.GH8541@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +static struct mfd_cell axp20x_cells[] = {
> > > +	{
> > > +		.name		= "axp20x-pek",
> > > +		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> > > +		.resources	= axp20x_pek_resources,
> > > +	}, {
> > > +		.name		= "axp20x-regulator",
> > > +	},
> > > +};
> > 
> > nit: The format of these two structs are inconsistent.
> 
> Uhm, what do you mean?

Well you've removed the struct above this one in your reply. Take a
look at my reply to you and see the differences between this _two_
structs, this being only one of them.

[...]

> > > +static const struct i2c_device_id axp20x_i2c_id[] = {
> > > +	{ "axp202", AXP202_ID },
> > > +	{ "axp209", AXP209_ID },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
> > 
> > Isn't this redundant now that you're using of_id?
> 
> It is not. Even it is unused it has to be in the driver otherwise the
> driver is not loaded. Probably it is something wrong in the I2C core.

Sorry, I should have been more specific. The I2C core requires this
struct, but the IDs are unused and redundant. Best remove them in
order to mitigate any confusion.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
