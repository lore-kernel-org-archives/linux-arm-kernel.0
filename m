From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Apr 2011 09:53:51 +0100
Subject: [RFC PATCH 06/12] ARM: ux500: use remapped PPI interrupts for
	local timer
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00AEE891699@EXDCVYMBSTM005.EQ1STM.local>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-7-git-send-email-marc.zyngier@arm.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AEE891699@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <1303376031.27148.59.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-21 at 10:44 +0200, Srinidhi KASAGAR wrote:
> > -----Original Message-----
> > From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> > Sent: Thursday, April 21, 2011 12:38 AM
> > To: LAK
> > Cc: Srinidhi KASAGAR; Linus WALLEIJ
> > Subject: [RFC PATCH 06/12] ARM: ux500: use remapped PPI interrupts for
> > local timer
> > 
> > Use the normal interrupt scheme for the local timers by using
> > a remapped PPI interrupt.
> > 
> > Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/mach-ux500/Kconfig      |    1 +
> >  arch/arm/mach-ux500/localtimer.c |    3 ++-
> >  2 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> > index 5862601..6f3eb99 100644
> > --- a/arch/arm/mach-ux500/Kconfig
> > +++ b/arch/arm/mach-ux500/Kconfig
> > @@ -4,6 +4,7 @@ config UX500_SOC_COMMON
> >  	bool
> >  	default y
> >  	select ARM_GIC
> > +	select ARM_GIC_VPPI
> 
> Here you added VPPI and in the other patch 12/12 you remove this
> again and make it one time selectable based on CONFIG_SMP.
> is that done just for readability purpose?

This is in the interest of having a bisectable tree. Because I convert
each platform one at a time, I cannot immediately make CONFIG_SMP select
VPPI (that would break all the not-yet-converted platforms). Once all
platforms are using VPPI, patch #12 does the cleanup for configuration.

> Otherwise, for mach-ux500:
> Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>

Thanks,

	M.
-- 
Reality is an implementation detail.
