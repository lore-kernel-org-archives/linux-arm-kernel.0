From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Sep 2011 15:24:03 -0700
Subject: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform
	device driver
In-Reply-To: <20110914214533.GA30941@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
Message-ID: <20110914222403.GR24252@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110914 14:12]:
> 
> Also, as we don't need the support for different register offsets
> for the first two omap4 timers, please rather implement support
> for the new timers and the timeouts directly in plat-omap/dmtimer.c.
> 
> That way we can still keep the minimal timer support simple
> for clocksource and clockevent. Of course this means that we'll
> be only supporting the first two timers as system timers on
> omap4, but that's fine.

Since you already have the struct timer_regs, you can make use
of that in dmtimer.c. Then maybe make the inline functions to
something like this instead:

static inline u32 __omap_dm_timer_read(void __iomem *base, u8 reg,
						u8 pend, int posted);

Where you pass the timer->context.pend depending on the pending
register offset for the timer.

Regards,

Tony
