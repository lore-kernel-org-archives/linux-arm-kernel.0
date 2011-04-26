From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Tue, 26 Apr 2011 18:27:26 +0200
Subject: [PATCH v3] [ARM] MX1: Add ARMadeus Systems APF9328 board support
In-Reply-To: <20110426132033.GT31131@pengutronix.de>
References: <1302022268-42787-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20110426132033.GT31131@pengutronix.de>
Message-ID: <20110426182726.0f5d8ada@trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Apr 2011 15:20:33 +0200
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > +static struct platform_device apf9328_flash_device = {
> > +	.name		= "physmap-flash",
> > +	.id		= 0,
> > +	.dev = {
> > +		.platform_data = &apf9328_flash_data,
> > +	},
> > +	.resource = &flash_resource,
> > +	.num_resources = 1,
> ARRAY_SIZE(flash_resource) please
>
ARRAY_SIZE() is not usable for flash_resource because this is not an array. This
way to set the FLASH resource size is commonly used on others boards. 
> 
> > +};
> > +
> > +/*
> > + * APF9328 has a DM9000 Ethernet controller
> > + */
> > +static const struct dm9000_plat_data dm9000_setup __initconst = {
> > +	.flags          = DM9000_PLATF_16BITONLY
> > +};
> ditto here (no init, no const)
> 
> > +
> > +static const struct resource dm9000_resources[] __initconst = {
> > +	[0] = {
> > +		.start  = (MX1_CS4_PHYS + 0x00C00000),
> > +		.end    = (MX1_CS4_PHYS + 0x00C00001),
> hmm, are you sure about the sizes here? The parenthesis are not needed.
>
Yes. Chip is mapped that way on apf9328 board.
>
> > +		.flags  = IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start  = (MX1_CS4_PHYS + 0x00C00002),
> > +		.end    = (MX1_CS4_PHYS + 0x00C00003),
> > +		.flags  = IORESOURCE_MEM,
> > +	},
> > +	[2] = {
> > +		.start  = (IRQ_GPIOB(14)),
> > +		.end    = (IRQ_GPIOB(14)),
> > +		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> > +	},
> > +};
> > +
> Best regards
> Uwe
> 
Regards 
Gwenha?l
