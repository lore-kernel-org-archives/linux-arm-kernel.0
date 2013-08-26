From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Aug 2013 16:09:41 -0700
Subject: [PATCH] clocksource: exynos_mct: Set IRQ affinity when the CPU
 goes online
In-Reply-To: <1377534836-21682-1-git-send-email-t.figa@samsung.com>
References: <1377534836-21682-1-git-send-email-t.figa@samsung.com>
Message-ID: <20130826230940.GI23960@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26, Tomasz Figa wrote:
> Some variants of Exynos MCT, namely exynos4210-mct at the moment, use
> normal, shared interrupts for local timers. This means that each
> interrupt must have correct affinity set to fire only on CPU
> corresponding to given local timer.
> 
> However after recent conversion of clocksource drivers to not use the
> local timer API for local timer initialization any more, the point of
> time when local timers get initialized changed and irq_set_affinity()
> fails because the CPU is not marked as online yet.
> 
> This patch fixes this by moving the call to irq_set_affinity() to
> CPU_ONLINE notification, so the affinity is being set when the CPU goes
> online.
> 
> This fixes a problem with Exynos4210 failing to boot, present since commit
> 	ee98d27df6 ARM: EXYNOS4: Divorce mct from local timer API
> due to failing irq_set_affinity().
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

Looks good to me if you want to go this route.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
