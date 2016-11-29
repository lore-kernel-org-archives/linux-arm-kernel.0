From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 16:45:13 +0300
Subject: [PATCH v3 08/13] clocksource/drivers/rockchip_timer: drop unused
 rk_base() and rk_ctrl()
In-Reply-To: <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480427118-5126-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480427118-5126-9-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of functions has been ceased by previous commit.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/rockchip_timer.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index aa9ccd1..a17dc61 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -53,16 +53,6 @@ static inline struct rk_timer *rk_timer(struct clock_event_device *ce)
 	return &rk_clock_event_device(ce)->timer;
 }
 
-static inline void __iomem *rk_base(struct clock_event_device *ce)
-{
-	return rk_timer(ce)->base;
-}
-
-static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
-{
-	return rk_timer(ce)->ctrl;
-}
-
 static inline void rk_timer_disable(struct rk_timer *timer)
 {
 	writel_relaxed(TIMER_DISABLE, timer->ctrl);
-- 
1.7.9.5
