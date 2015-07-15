From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jul 2015 03:00:36 -0700
Subject: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
In-Reply-To: <20150715092437.GC9627@leverpostej>
References: <1436820101-2172-1-git-send-email-balbi@ti.com>
 <20150715092437.GC9627@leverpostej>
Message-ID: <20150715100035.GB17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Rutland <mark.rutland@arm.com> [150715 02:27]:
> On Mon, Jul 13, 2015 at 09:41:41PM +0100, Felipe Balbi wrote:
> > According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
> > the realtime counter sits in the Wakeup Always-On Power domain.
> > Furthermore, the counter will automatically switch the 32K clock source
> > when MPU goes into standby and automatically switch back to SYS_CLK or
> > ABE_LP when MPU goes out of standby.
> 
> While the counter is in an always-on domain (the architecture mandates
> this) I don't think that applies to the timers (i.e. the comparators
> within a CPU), which are almost certainly not in an always-on domain.
> 
> I suspect that this is incorrect, and it will be very painful to debug
> if it is...

OK good point. And there would have to be some wake-up line wired to the
IO chain or the PMIC in this case if the comparator was always on.

Dropping this patch for now anyways.

Regards,

Tony
