From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Jul 2013 21:34:30 +0200
Subject: [PATCHv3 03/10] clocksource: sun4i: rename AUTORELOAD define to RELOAD
In-Reply-To: <1373052877-29366-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1373052877-29366-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1373052877-29366-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name AUTORELOAD was actually pretty bad since it doesn't make the
register reload the previous interval when it expires, but setting this
value pushes the new programmed interval to the internal timer counter.
Rename it to RELOAD instead.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 34ab658..f5e227b 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -28,7 +28,7 @@
 #define TIMER_IRQ_ST_REG	0x04
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
 #define TIMER_CTL_ENABLE		BIT(0)
-#define TIMER_CTL_AUTORELOAD		BIT(1)
+#define TIMER_CTL_RELOAD		BIT(1)
 #define TIMER_CTL_ONESHOT		BIT(7)
 #define TIMER_INTVAL_REG(val)	(0x10 * (val) + 0x14)
 #define TIMER_CNTVAL_REG(val)	(0x10 * (val) + 0x18)
@@ -129,7 +129,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 
 	/* set mode to auto reload */
 	val = readl(timer_base + TIMER_CTL_REG(0));
-	writel(val | TIMER_CTL_AUTORELOAD, timer_base + TIMER_CTL_REG(0));
+	writel(val | TIMER_CTL_RELOAD, timer_base + TIMER_CTL_REG(0));
 
 	ret = setup_irq(irq, &sun4i_timer_irq);
 	if (ret)
-- 
1.8.3.2
