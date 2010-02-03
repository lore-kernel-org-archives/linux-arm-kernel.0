From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 11:54:44 +0100
Subject: [PATCH 06/13] ARM: LPC32XX: Core architecture files
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020E9602@mi8nycmail19.Mi8.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-7-git-send-email-wellsk40@gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E9602@mi8nycmail19.Mi8.com>
Message-ID: <20100203105444.GG11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello 
On Thu, Jan 28, 2010 at 12:58:40PM -0500, H Hartley Sweeten wrote:
> On Wednesday, January 27, 2010 6:43 PM, wellsk40 wrote:
> > From: Kevin Wells <wellsk40@gmail.com>
> > 
> > GPIO support functions for gpiolib, irq setup and handling, serial
> > port support, and high resolution timer support used in the LPC32XX
> > architecture.
> > 
> > Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> > ---
> 
> [snip]
> 
> > +static struct gpio_regs gpio_grp_regs[] = {
> > +	{
> > +		.inp_state	= (void __iomem *) GPIO_P0_INP_STATE(GPIOBASE),
> > +		.outp_set	= (void __iomem *) GPIO_P0_OUTP_SET(GPIOBASE),
> > +		.outp_clr	= (void __iomem *) GPIO_P0_OUTP_CLR(GPIOBASE),
> > +		.dir_set	= (void __iomem *) GPIO_P0_DIR_SET(GPIOBASE),
> > +		.dir_clr	= (void __iomem *) GPIO_P0_DIR_CLR(GPIOBASE),
> > +	},
> > +	{
> > +		.inp_state	= (void __iomem *) GPIO_P1_INP_STATE(GPIOBASE),
> > +		.outp_set	= (void __iomem *) GPIO_P1_OUTP_SET(GPIOBASE),
> > +		.outp_clr	= (void __iomem *) GPIO_P1_OUTP_CLR(GPIOBASE),
> > +		.dir_set	= (void __iomem *) GPIO_P1_DIR_SET(GPIOBASE),
> > +		.dir_clr	= (void __iomem *) GPIO_P1_DIR_CLR(GPIOBASE),
> > +	},
> > +	{
> > +		.inp_state	= (void __iomem *) GPIO_P2_INP_STATE(GPIOBASE),
> > +		.outp_set	= (void __iomem *) GPIO_P2_OUTP_SET(GPIOBASE),
> > +		.outp_clr	= (void __iomem *) GPIO_P2_OUTP_CLR(GPIOBASE),
> > +		.dir_set	= (void __iomem *) GPIO_P2_DIR_SET(GPIOBASE),
> > +		.dir_clr	= (void __iomem *) GPIO_P2_DIR_CLR(GPIOBASE),
> > +	},
> > +	{
> > +		.inp_state	= (void __iomem *) GPIO_P3_INP_STATE(GPIOBASE),
> > +		.outp_set	= (void __iomem *) GPIO_P3_OUTP_SET(GPIOBASE),
> > +		.outp_clr	= (void __iomem *) GPIO_P3_OUTP_CLR(GPIOBASE),
> > +		.dir_set	= (void __iomem *) GPIO_P2_DIR_SET(GPIOBASE),
> > +		.dir_clr	= (void __iomem *) GPIO_P2_DIR_CLR(GPIOBASE),
> > +	},
> > +};
> 
> All this casting is pretty ugly.
> 
> It appears these GPIO_P* macros are only used here.  Can the macros
> be modified to create the (void __iomem *) directly?
If GPIO_P* macros are only used here, maybe better define them in this
file?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
