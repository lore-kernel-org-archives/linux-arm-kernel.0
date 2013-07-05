From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 18:05:14 +0200 (CEST)
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <fbeb6f36-f07a-4518-b6f2-0b8e36028fe9@CH1EHSMHS012.ehs.local>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1307050819000.11637@ionos.tec.linutronix.de>
 <fbeb6f36-f07a-4518-b6f2-0b8e36028fe9@CH1EHSMHS012.ehs.local>
Message-ID: <alpine.DEB.2.02.1307051802560.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> On Fri, Jul 05, 2013 at 08:30:47AM +0200, Thomas Gleixner wrote:
> > On Wed, 3 Jul 2013, Soren Brinkmann wrote:
> > 
> > > Reuse the TTC clocksource timer as sched clock, too. Since only a single
> > > sched clock is supported in Linux, this feature optional and can be
> > > selected through Kconfig.
> > 
> > This changelog doesn't make sense.
> > 
> > There can be only one active sched_clock, but that does no mean, that
> > you cannot have different implementations compiled in.
> > 
> > So if you disable this config which sched_clock is your kernel using?
> Jiffies
> 
> > And if you enable it, how is guaranteed that you end up with the ttc
> > sched_clock as the active one? Just due to initcall ordering?
> I assumed so. Is there a different mechanism?

jiffies is the default one. If you setup an explicit sched clock then
this is used. initcall ordering only matters if you have two possible
sched clocks which might replace jiffies. The one which gets
registered last wins.

So the question is, why you want to disable your sched clock at
compile time.

Thanks,

	tglx
