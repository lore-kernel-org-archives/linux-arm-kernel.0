From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Jul 2013 21:34:29 +0200
Subject: [PATCHv3 02/10] clocksource: sun4i: Wrap macros arguments in
 parenthesis
In-Reply-To: <1373052877-29366-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1373052877-29366-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1373052877-29366-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros were not using parenthesis to escape the arguments passed to
them. It is pretty unsafe, so add those parenthesis.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index bdf34d9..34ab658 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -30,8 +30,8 @@
 #define TIMER_CTL_ENABLE		BIT(0)
 #define TIMER_CTL_AUTORELOAD		BIT(1)
 #define TIMER_CTL_ONESHOT		BIT(7)
-#define TIMER_INTVAL_REG(val)	(0x10 * val + 0x14)
-#define TIMER_CNTVAL_REG(val)	(0x10 * val + 0x18)
+#define TIMER_INTVAL_REG(val)	(0x10 * (val) + 0x14)
+#define TIMER_CNTVAL_REG(val)	(0x10 * (val) + 0x18)
 
 #define TIMER_SCAL		16
 
-- 
1.8.3.2
