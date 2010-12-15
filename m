From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Dec 2010 18:06:36 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <201012151758.42896.arnd@arndb.de>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151722.21939.arnd@arndb.de>
	<20101215164046.GH28971@pengutronix.de>
	<201012151758.42896.arnd@arndb.de>
Message-ID: <20101215170636.GJ28971@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Wed, Dec 15, 2010 at 05:58:42PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 December 2010, Uwe Kleine-K?nig wrote:
> > On Wed, Dec 15, 2010 at 05:22:21PM +0100, Arnd Bergmann wrote:
> > > > +
> > > > +#ifndef __ASSEMBLER__
> > > > +static inline void __mxs_setl(u32 mask, void __iomem *reg)
> > > > +{
> > > > +	__raw_writel(mask, reg + MXS_SET_ADDR);
> > > > +}
> > > > +
> > > > +static inline void __mxs_clrl(u32 mask, void __iomem *reg)
> > > > +{
> > > > +	__raw_writel(mask, reg + MXS_CLR_ADDR);
> > > > +}
> > > > +
> > > > +static inline void __mxs_togl(u32 mask, void __iomem *reg)
> > > > +{
> > > > +	__raw_writel(mask, reg + MXS_TOG_ADDR);
> > > > +}
> > > > +#endif
> > > 
> > > Why __raw_writel()? All regular I/O accesses should use
> > > readl/writel etc, not the internal helpers.
> > nak, readl does little endian accesses, __raw_readl native endian.  So
> > for platform use __raw_readl is most of the time the better one.
> 
> Then we should define a proper function for this with well-defined
> behaviour. I would suggest defining a mxs_readl/mxs_writel here,
> that is defined to have the same endianess as the mxs SOC, but
> otherwise has the same properties as readl/writel.
I don't get your point here.  What are the properties of readl/writel
you want here?  The barrier?  __mem_pci?

For me __mxs_setl is a proper function with well-defined behaviour, no?
(One thing I currently consider to argue is to make these .c file local
because different IPs might have different offsets for SET, CLR and TOG
or not support it at all, but other than that I'm happy with it.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
