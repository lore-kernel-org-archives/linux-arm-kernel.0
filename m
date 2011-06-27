From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 10:32:26 -0700
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
In-Reply-To: <20110620092341.357.14183.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:41 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin>
Message-ID: <8762nrch91.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> This removes the support for setting the wake-up timer for debugging.
>
> Later on we can reserve gptimer1 for PM code only and have similar
> functionality.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Another minor change to fold into patch: gptimer_wakeup doesn't exist
anymore, so should probably be removed from dmtimer.h

Kevin


diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 40d7936..d0f3a2d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -59,7 +59,6 @@
  */
 #define OMAP_TIMER_IP_VERSION_1                        0x1
 struct omap_dm_timer;
-extern struct omap_dm_timer *gptimer_wakeup;
 struct clk;
 
 struct omap_dm_timer *omap_dm_timer_request(void);
