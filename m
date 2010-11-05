From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Nov 2010 13:04:53 +0100
Subject: [PATCH 4/7] ARM i.MX irq: Allow runtime decision between AVIC
	and TZIC
In-Reply-To: <20101105103733.GI16938@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
	<1288950371-1552-5-git-send-email-s.hauer@pengutronix.de>
	<20101105103733.GI16938@pengutronix.de>
Message-ID: <20101105120453.GT6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 11:37:33AM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Nov 05, 2010 at 10:46:08AM +0100, Sascha Hauer wrote:
> > As we are on a path to support more different i.MX SoCs in a single
> > binary we have to able to support both AVIC and TZIC in a single
> > binary. This patch only introduces overhead when both controllers
> > are needed.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/plat-mxc/avic.c                     |    2 +
> >  arch/arm/plat-mxc/cpu.c                      |    3 +
> >  arch/arm/plat-mxc/include/mach/entry-macro.S |   66 ++++++++++++++++----------
> >  arch/arm/plat-mxc/include/mach/mxc.h         |    8 +++
> >  arch/arm/plat-mxc/tzic.c                     |    3 +
> >  5 files changed, 57 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> > index 7331f2a..1cb464a 100644
> > --- a/arch/arm/plat-mxc/avic.c
> > +++ b/arch/arm/plat-mxc/avic.c
> > @@ -118,6 +118,8 @@ void __init mxc_init_irq(void __iomem *irqbase)
> >  	int i;
> >  
> >  	avic_base = irqbase;
> Is avic_base still needed?
> 
> > +++ b/arch/arm/plat-mxc/tzic.c
> > @@ -122,6 +122,9 @@ void __init tzic_init_irq(void __iomem *irqbase)
> >  	int i;
> >  
> >  	tzic_base = irqbase;
> ditto for tzic_base.

The C code uses them. I only kept them to create a minimal patch. They
can be removed in a later patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
