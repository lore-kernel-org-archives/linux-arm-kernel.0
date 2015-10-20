From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:39 +0800
Subject: [PATCH 6/7] clocksource: digicolor: don't trace
 digicolor_timer_sched_read()
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-7-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not trace digicolor_timer_sched_read() function, add notrace
attribute to this function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/timer-digicolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index e73947f0f..a536eeb 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -143,7 +143,7 @@ static irqreturn_t digicolor_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static u64 digicolor_timer_sched_read(void)
+static u64 notrace digicolor_timer_sched_read(void)
 {
 	return ~readl(dc_timer_dev.base + COUNT(TIMER_B));
 }
-- 
2.6.1
