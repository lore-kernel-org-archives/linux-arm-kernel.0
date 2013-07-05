From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  6 Jul 2013 00:18:36 +0200
Subject: [PATCHv4 01/10] clocksource: sun4i: Use the BIT macros where possible
In-Reply-To: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1373062725-19625-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1373062725-19625-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index d4674e7..bdf34d9 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -24,12 +24,12 @@
 #include <linux/of_irq.h>
 
 #define TIMER_IRQ_EN_REG	0x00
-#define TIMER_IRQ_EN(val)		(1 << val)
+#define TIMER_IRQ_EN(val)		BIT(val)
 #define TIMER_IRQ_ST_REG	0x04
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
-#define TIMER_CTL_ENABLE		(1 << 0)
-#define TIMER_CTL_AUTORELOAD		(1 << 1)
-#define TIMER_CTL_ONESHOT		(1 << 7)
+#define TIMER_CTL_ENABLE		BIT(0)
+#define TIMER_CTL_AUTORELOAD		BIT(1)
+#define TIMER_CTL_ONESHOT		BIT(7)
 #define TIMER_INTVAL_REG(val)	(0x10 * val + 0x14)
 #define TIMER_CNTVAL_REG(val)	(0x10 * val + 0x18)
 
-- 
1.8.3.2
