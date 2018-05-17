From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 17 May 2018 20:07:59 +0200
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <307323036.63872.1526576126537@email.1und1.de>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
Message-ID: <20180517180758.GK12198@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 06:55:26PM +0200, Stefan Wahren wrote:
> > Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 18:34 geschrieben:
> > On Thu, 17 May 2018, Stefan Wahren wrote:
> > > > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:

> > > > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > > > arm32 can probe.
> > 
> > so how closely did you look at the a53/a7 differences?  I see some major 
> > differences, especially with the CPU_CYCLES event (0xff vs 0x11).
> > 
> > The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
> > code rather than trying to treat it as a cortex-a7.
> 
> we like to use the PMU of BCM2837 SoC (4x A53 cores) under arm32 and arm64.
> 
> What is the right way (tm) to the define the DT compatibles?
> Does the arm32 PMU driver need patching for proper A53 support?

I'm completely clueless on all of this; Mark might have ideas.
