From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2011 11:50:54 +0300
Subject: [patch 00/16] arm: Replace arm sched_clock by clocksource
	based sched_clock
In-Reply-To: <BANLkTim9BaWLDCnSzeD-kjFwF+c+37KRjQ@mail.gmail.com>
References: <20110423205036.795894921@linutronix.de>
	<BANLkTi=5Uz_TNKOiJKDn7Mh30fxv3aY67Q@mail.gmail.com>
	<1303758649.2816.57.camel@work-vm>
	<BANLkTim9BaWLDCnSzeD-kjFwF+c+37KRjQ@mail.gmail.com>
Message-ID: <20110426085053.GH16892@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [110426 10:41]:
> 2011/4/25 john stultz <johnstul@us.ibm.com>:
> > On Sun, 2011-04-24 at 09:27 +0200, Linus Walleij wrote:
> >> Any reason why we can't simply move *all* of these to
> >> drivers/clocksource/* and proceed with consolidation there?
> >
> > This gives me some pause, as having the clocksources in the platform
> > code makes it easier to know what platform needs to be tested when a
> > change is made. The rule so far has been if more then one arch can make
> > use of it, it should be moved to the drivers/clocksource dir. Otherwise,
> > leave it close to any arch specific code that manages the hardware.
> 
> That means that by definition anything in a plat-* directory, say e.g.
> plat-nomadik/timer.c and plat-omap/dmtimer.c should go into
> drivers/clocksource I believe?

Or drivers/timers as they may be generic hardware timers? They are
not necessarily used for clocksource.

Regards,

Tony
