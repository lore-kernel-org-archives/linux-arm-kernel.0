From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jul 2016 23:46:32 -0700
Subject: [PATCH 3/4] ARM: OMAP4+: Have _omap4_wait_target_* check for
 valid clkctrl_offs
In-Reply-To: <20160712175034.743-4-d-gerlach@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
 <20160712175034.743-4-d-gerlach@ti.com>
Message-ID: <20160722064631.GX28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [160712 10:53]:
> Previously the low-level CM call internal to the
> _omap4_wait_target_ready/disable calls was responsible for checking for
> a valid clkctrl_offs. Now we must also consider the value of the
> prcm.omap4.flags because if HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET is set in
> the flags then clkctrl_offs of 0 is valid.
> 
> Let's move this check into the _omap4_wait_target_ready/disable where we
> have access to both the clkctrl_offs and the flags values and simply
> return 0 without calling the low level CM call at all, which would have
> returned 0 anyway if the clktrl_offs was zero.

This series looks OK to me to fix the RTC regression. Paul and Tero,
do you see any issues with this or care to ack?

I'm planning to s/Let's move this check/Let's add this check/ while
committing to avoid confusion.

Regards,

Tony
