From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:38 +0800
Subject: [PATCH 5/7] clocksource: vf_pit_timer: don't trace
 pit_read_sched_clock()
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not trace pit_read_sched_clock() function, add notrace
attribute to this function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/vf_pit_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index f07ba99..a0e6c68 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -52,7 +52,7 @@ static inline void pit_irq_acknowledge(void)
 	__raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
 }
 
-static u64 pit_read_sched_clock(void)
+static u64 notrace pit_read_sched_clock(void)
 {
 	return ~__raw_readl(clksrc_base + PITCVAL);
 }
-- 
2.6.1
