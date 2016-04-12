From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Apr 2016 09:05:41 -0700
Subject: [PATCH] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
In-Reply-To: <570D1BC5.7000704@ti.com>
References: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
 <570D1BC5.7000704@ti.com>
Message-ID: <20160412160541.GO5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr. <fcooper@ti.com> [160412 09:02]:
> 
> 
> On 04/12/2016 05:42 AM, Grygorii Strashko wrote:
> > The commit 55ee7017ee31 ("arm: omap2: board-generic: use
> > omap4_local_timer_init for AM437x") unintentionally changes the
> > clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
> > 
> > Unfortunately, the SyncTimer32K is starving from frequency deviation
> > as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> > as clocksource") and, as reported by Franklin [1], even its monotonic
> > nature is under question (most probably there is a HW issue, but it's
> > still under investigation).
> > 
> > Taking into account above facts It's reasonable to rollback to the use
> > of omap3_gptimer_timer_init().
> 
> I tested this patch and was not able to reproduce this issue after
> rebooting the AM437 GP evm 30 times. I then tried without this patch and
> the issue showed up after rebooting the board for the 5th time.

What's the problem that happens? Would be good to have it in the
description so people know.

Regards,

Tony
