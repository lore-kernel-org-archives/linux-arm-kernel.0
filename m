From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 00:51:02 -0700
Subject: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
In-Reply-To: <87ei2ka2u6.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin> <87ei2ka2u6.fsf@ti.com>
Message-ID: <20110627075101.GE23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110623 10:08]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > There's no need to initialize the dmtimer framework early.
> > Just mark the clocksource and timesource as reserved, and
> > initialize dmtimer with an arch_initcall.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
> Also, when you are able to fully get rid of omap_dm_timer_init(), you
> can probably remove it from dmtimer.h and make it static in dmtimer.c

Good catch. That can be made static now.

Tony
