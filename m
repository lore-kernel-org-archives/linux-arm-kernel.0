From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Apr 2016 09:04:49 -0700
Subject: [PATCH] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
In-Reply-To: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
References: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160412160448.GN5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160412 03:44]:
> The commit 55ee7017ee31 ("arm: omap2: board-generic: use
> omap4_local_timer_init for AM437x") unintentionally changes the
> clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
> 
> Unfortunately, the SyncTimer32K is starving from frequency deviation
> as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> as clocksource") and, as reported by Franklin [1], even its monotonic
> nature is under question (most probably there is a HW issue, but it's
> still under investigation).
> 
> Taking into account above facts It's reasonable to rollback to the use
> of omap3_gptimer_timer_init().

I thought only the ePOS EVM does not have the 32k clock available?
Maybe this is the the old sync timer autocorrection drift issue?

Regards,

Tony
