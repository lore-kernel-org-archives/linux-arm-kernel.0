From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 28 Jan 2011 07:19:30 +0800
Subject: [PATCH] ARM: mxs: fix clock base address missing
In-Reply-To: <20110126155858.GP9041@pengutronix.de>
References: <1296080796-10896-1-git-send-email-shawn.guo@freescale.com>
	<20110126155858.GP9041@pengutronix.de>
Message-ID: <20110127231929.GC14993@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 04:58:58PM +0100, Sascha Hauer wrote:
> On Thu, Jan 27, 2011 at 06:26:36AM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/clock-mx23.c |    2 +-
> >  arch/arm/mach-mxs/clock-mx28.c |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> > index b1a362e..a0296a4 100644
> > --- a/arch/arm/mach-mxs/clock-mx23.c
> > +++ b/arch/arm/mach-mxs/clock-mx23.c
> > @@ -347,7 +347,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
> >  {									\
> >  	if (parent != clk->parent) {					\
> >  		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
> > -			 HW_CLKCTRL_CLKSEQ_TOG);			\
> > +			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
> >  		clk->parent = parent;					\
> >  	}								\
> >  									\
> 
> While at it you could also add some parameter checking to this function.
> Implemented like this it behaves rather randomly.
> 
The parameters have been well checked by clk_set_parent().  What
kind of extra checking are you expecting?

Regards,
Shawn

> Sascha
> 
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index 56312c0..44c1754 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -483,7 +483,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
> >  {									\
> >  	if (parent != clk->parent) {					\
> >  		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
> > -			 HW_CLKCTRL_CLKSEQ_TOG);			\
> > +			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
> >  		clk->parent = parent;					\
> >  	}								\
> >  									\
> > -- 
> > 1.7.1
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
