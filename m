From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 22:42:03 +0200 (CEST)
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <0030b826-0eb1-4bb8-a0de-1d8dc68bd81a@TX2EHSMHS017.ehs.local>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130704033026.GX4288@tarshish>
 <0030b826-0eb1-4bb8-a0de-1d8dc68bd81a@TX2EHSMHS017.ehs.local>
Message-ID: <alpine.DEB.2.02.1307052238170.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> On Thu, Jul 04, 2013 at 06:30:26AM +0300, Baruch Siach wrote:
> > Hi Soren,
> > 
> > On Wed, Jul 03, 2013 at 02:50:16PM -0700, Soren Brinkmann wrote:
> > > Reuse the TTC clocksource timer as sched clock, too. Since only a single
> > > sched clock is supported in Linux, this feature optional and can be
> > > selected through Kconfig.
> > > 
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > 
> > [...]
> > 
> > > diff --git a/drivers/clocksource/cadence_ttc_timer.c 
> > > b/drivers/clocksource/cadence_ttc_timer.c
> > > index 4cbe28c..ef0f52b 100644
> > > --- a/drivers/clocksource/cadence_ttc_timer.c
> > > +++ b/drivers/clocksource/cadence_ttc_timer.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/of_irq.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/clk-provider.h>
> > > +#include <asm/sched_clock.h>
> > 
> > This has changed to linux/sched_clock.h in the tip tree. See 
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=38ff87f77af0b5a93fc8581cff1d6e5692ab8970.
> Is that change going into Linus' tree during the 3.11 merge window? The
> tip tree is missing some changes to the TTC which went in through the
> armsoc tree.

Yes, this is about to be sent Linuswards. Can we please coordinate
that stuff. drivers/clocksource depend on tip timers/* branches and
any modification in some other tree is going to be doomed.

We have a mechanism for that in place, if stuff goes cross trees. One
of the trees provides a set of commit for the other tree to pull, so
we do not end up with merge dependencies and conflicts.

Why is clocksource stuff going through armsoc unless it contains
related modifications in arch/arm/

Grmbl.

	tglx
