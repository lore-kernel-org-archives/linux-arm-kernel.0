From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jul 2014 09:10:45 -0500
Subject: [PATCH 30/35] irqchip: add irq-omap-intc.h header
In-Reply-To: <20140729120133.GQ29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
 <20140729120133.GQ29045@atomide.com>
Message-ID: <20140729141045.GA17808@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 05:01:33AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140728 14:19]:
> > OMAP INTC irqchip driver will be moved under
> > drivers/irqchip/ soon but we still have a dependency
> > with mach-omap2 when it comes to idle functions.
> > 
> > In order to make it easy to share those function
> > prototypes with OMAP PM code, we introduce this new
> > header.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c        |  1 +
> >  arch/arm/mach-omap2/board-am3517crane.c    |  1 +
> >  arch/arm/mach-omap2/board-am3517evm.c      |  1 +
> >  arch/arm/mach-omap2/board-cm-t35.c         |  1 +
> >  arch/arm/mach-omap2/board-cm-t3517.c       |  1 +
> >  arch/arm/mach-omap2/board-devkit8000.c     |  1 +
> >  arch/arm/mach-omap2/board-ldp.c            |  1 +
> >  arch/arm/mach-omap2/board-omap3beagle.c    |  1 +
> >  arch/arm/mach-omap2/board-omap3logic.c     |  1 +
> >  arch/arm/mach-omap2/board-omap3pandora.c   |  1 +
> >  arch/arm/mach-omap2/board-omap3stalker.c   |  1 +
> >  arch/arm/mach-omap2/board-omap3touchbook.c |  1 +
> >  arch/arm/mach-omap2/board-overo.c          |  1 +
> >  arch/arm/mach-omap2/board-rx51.c           |  1 +
> >  arch/arm/mach-omap2/board-ti8168evm.c      |  1 +
> >  arch/arm/mach-omap2/common.h               |  9 ---------
> >  arch/arm/mach-omap2/cpuidle34xx.c          |  1 +
> >  arch/arm/mach-omap2/irq.c                  |  1 +
> >  arch/arm/mach-omap2/pm24xx.c               |  1 +
> >  arch/arm/mach-omap2/pm34xx.c               |  1 +
> >  include/linux/irqchip/irq-omap-intc.h      | 32 ++++++++++++++++++++++++++++++
> ...
> 
> > +void omap2_init_irq(void);
> > +void omap3_init_irq(void);
> > +void ti81xx_init_irq(void);
> 
> I think these will all go away with DT based booting?
> So it might be worth waiting for that rather than churn
> all these files, or..

you just asked me to rebase this series because now we had OMAP3 idle
working with DT. And now, you're asking me to hold on to this series
because not everything is DT-based yet.

This is the third time I rebase the series after a long hiatus and it
always comes out to the same result -> "let's wait some more".

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/66ce25ba/attachment.sig>
