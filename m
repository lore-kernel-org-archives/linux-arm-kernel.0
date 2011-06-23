From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 10:13:05 -0700
Subject: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
In-Reply-To: <20110620092343.357.60445.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:43 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin>
Message-ID: <87ei2ka2u6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> There's no need to initialize the dmtimer framework early.
> Just mark the clocksource and timesource as reserved, and
> initialize dmtimer with an arch_initcall.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Also, when you are able to fully get rid of omap_dm_timer_init(), you
can probably remove it from dmtimer.h and make it static in dmtimer.c

Kevin
