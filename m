From: johnstul@us.ibm.com (john stultz)
Date: Mon, 25 Apr 2011 12:10:49 -0700
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource
	based sched_clock
In-Reply-To: <BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
References: <20110423205036.795894921@linutronix.de>
	<BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
Message-ID: <1303758649.2816.57.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-04-24 at 09:27 +0200, Linus Walleij wrote:
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

This gives me some pause, as having the clocksources in the platform
code makes it easier to know what platform needs to be tested when a
change is made. The rule so far has been if more then one arch can make
use of it, it should be moved to the drivers/clocksource dir. Otherwise,
leave it close to any arch specific code that manages the hardware.

> It must be a pain having to grep through the tree to find all of
> these (even though I bet you know them all by heart now).

Not sure if grepping backwards through config dependencies to see who
actually uses a specific clocksource would be easier. But I'll admit
that sharing code is likely more important.

thanks
-john
