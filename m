From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 5 Jul 2013 08:43:11 -0700
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <alpine.DEB.2.02.1307050819000.11637@ionos.tec.linutronix.de>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1307050819000.11637@ionos.tec.linutronix.de>
Message-ID: <fbeb6f36-f07a-4518-b6f2-0b8e36028fe9@CH1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 08:30:47AM +0200, Thomas Gleixner wrote:
> On Wed, 3 Jul 2013, Soren Brinkmann wrote:
> 
> > Reuse the TTC clocksource timer as sched clock, too. Since only a single
> > sched clock is supported in Linux, this feature optional and can be
> > selected through Kconfig.
> 
> This changelog doesn't make sense.
> 
> There can be only one active sched_clock, but that does no mean, that
> you cannot have different implementations compiled in.
> 
> So if you disable this config which sched_clock is your kernel using?
Jiffies

> And if you enable it, how is guaranteed that you end up with the ttc
> sched_clock as the active one? Just due to initcall ordering?
I assumed so. Is there a different mechanism?

	S?ren
