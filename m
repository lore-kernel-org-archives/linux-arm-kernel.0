From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 13 Aug 2013 11:43:10 -0300
Subject: [PATCH v4 1/6] clocksource: armada-370-xp: Use BIT()
In-Reply-To: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1376404995-24548-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a purely cosmetic commit: we replace hardcoded values that
representing bits by BIT(), which is slightly more readable.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index efdca32..ab22873 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -35,13 +35,13 @@
  * Timer block registers.
  */
 #define TIMER_CTRL_OFF		0x0000
-#define  TIMER0_EN		 0x0001
-#define  TIMER0_RELOAD_EN	 0x0002
-#define  TIMER0_25MHZ            0x0800
+#define  TIMER0_EN		 BIT(0)
+#define  TIMER0_RELOAD_EN	 BIT(1)
+#define  TIMER0_25MHZ            BIT(11)
 #define  TIMER0_DIV(div)         ((div) << 19)
-#define  TIMER1_EN		 0x0004
-#define  TIMER1_RELOAD_EN	 0x0008
-#define  TIMER1_25MHZ            0x1000
+#define  TIMER1_EN		 BIT(2)
+#define  TIMER1_RELOAD_EN	 BIT(3)
+#define  TIMER1_25MHZ            BIT(12)
 #define  TIMER1_DIV(div)         ((div) << 22)
 #define TIMER_EVENTS_STATUS	0x0004
 #define  TIMER0_CLR_MASK         (~0x1)
-- 
1.8.1.5
