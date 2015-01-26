From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Jan 2015 12:26:29 +0100
Subject: [PATCH 7/7] mfd: Add support for the MediaTek MT6397 PMIC
In-Reply-To: <20150126111119.GE11745@x1>
References: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
 <1422022202-7526-8-git-send-email-s.hauer@pengutronix.de>
 <20150123161440.GA11745@x1> <20150126105222.GM12209@pengutronix.de>
 <20150126111119.GE11745@x1>
Message-ID: <20150126112629.GP12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 11:11:19AM +0000, Lee Jones wrote:
> On Mon, 26 Jan 2015, Sascha Hauer wrote:
> > On Fri, Jan 23, 2015 at 04:14:40PM +0000, Lee Jones wrote:
> > > On Fri, 23 Jan 2015, Sascha Hauer wrote:
> > > > +	struct mt6397_chip *mt6397 = irq_get_chip_data(data->irq);
> > > > +	int shift = mt6397_irq_shift(data->hwirq);
> > > > +	int reg = mt6397_irq_reg(data->hwirq);
> > > > +	int reg_ofs = MT6397_INT_CON0 + reg * 2;
> > > > +
> > > > +	mt6397->irq_masks_cur[reg] &= ~(1 << shift);
> > > 
> > > s/(1 << shift)/BIT(shift)/
> > 
> > Is it mentioned somewhere that these BIT macros shall be used? There are
> > quadrillions of examples for both styles in the kernel and personally I
> > think 1 << x is more readable.
> 
> I haven't seen a hard and fast 'rule' per say.  I think it's left up
> to the Maintainer of any given subsystem. ;)

Ok, I know your opinion already, I hope Samuel has the same ;).
I'll change it to BIT().

Maybe I'll even change my personal opinion since I noticed that 1 << x
doesn't work for 64bit registers. Here 1UL << x must be used, but this
could easily be forgotten.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
