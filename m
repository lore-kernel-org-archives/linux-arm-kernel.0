From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 20 Oct 2015 16:02:40 +0800
Subject: [PATCH 7/7] clocksource: fsl_ftm_timer: don't trace
 ftm_read_sched_clock
In-Reply-To: <1445328160-402-1-git-send-email-jszhang@marvell.com>
References: <1445328160-402-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445328160-402-8-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we should not trace ftm_read_sched_clock() function, add notrace
attribute to this function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clocksource/fsl_ftm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/fsl_ftm_timer.c b/drivers/clocksource/fsl_ftm_timer.c
index ef43469..10202f1 100644
--- a/drivers/clocksource/fsl_ftm_timer.c
+++ b/drivers/clocksource/fsl_ftm_timer.c
@@ -118,7 +118,7 @@ static inline void ftm_reset_counter(void __iomem *base)
 	ftm_writel(0x00, base + FTM_CNT);
 }
 
-static u64 ftm_read_sched_clock(void)
+static u64 notrace ftm_read_sched_clock(void)
 {
 	return ftm_readl(priv->clksrc_base + FTM_CNT);
 }
-- 
2.6.1
