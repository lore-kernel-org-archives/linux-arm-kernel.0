From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 26 Apr 2011 10:02:11 +0200 (CEST)
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource based
	sched_clock
In-Reply-To: <BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
References: <20110423205036.795894921@linutronix.de>
	<BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1104261001030.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Apr 2011, Linus Walleij wrote:

> 2011/4/23 Thomas Gleixner <tglx@linutronix.de>:
> 
> > Most of ARM sched_clocks is using the timekeeping clocksource as the
> > sched_clock. Only versatile uses a different clock for it, but there
> > is no real reason why it can't use the clocksource as well.
> 
> Excellent patch set!
> 
> > Another 650 lines gone :)
> 
> Any reason why we can't simply move *all* of these to
> drivers/clocksource/* and proceed with consolidation there?
> 
> It must be a pain having to grep through the tree to find all of
> these (even though I bet you know them all by heart now).

Russell has a patch which creates clocksource_mmio. That will replace
all the mmio (read some random register) based clocksources all over
the place.

Thanks,

	tglx
