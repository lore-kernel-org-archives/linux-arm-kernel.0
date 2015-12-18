From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:51 +0100
Subject: [PATCH 38/69] clocksource/drivers/h8300_timer8: Fix compilation error
 with dev_warn
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-38-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev_warn is using the platform driver which was removed in the previous
patch.

Let's replace dev_warn by pr_warn.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index f0680eb..35b0e8f 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -98,7 +98,7 @@ static void timer8_set_next(struct timer8_priv *p, unsigned long delta)
 
 	raw_spin_lock_irqsave(&p->lock, flags);
 	if (delta >= 0x10000)
-		dev_warn(&p->pdev->dev, "delta out of range\n");
+		pr_warn("delta out of range\n");
 	now = timer8_get_counter(p);
 	p->tcora = delta;
 	ctrl_outb(ctrl_inb(p->mapbase + _8TCR) | 0x40, p->mapbase + _8TCR);
-- 
1.9.1
