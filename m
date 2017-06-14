From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 11:10:43 +0200
Subject: [PATCH 2/2] clocksource: Explicitly include linux/clocksource.h when
 needed
In-Reply-To: <1497431443-14634-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170614091021.GG2261@mai>
 <1497431443-14634-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1497431443-14634-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

The kbuild test robot reported errors in these files when doing an ia64
allmodconfig build.

drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
   struct clocksource clksrc;
                      ^~~~~~
drivers/clocksource/cadence_ttc_timer.c:92:21: error: field 'cs' has incomplete type
   struct clocksource cs;
                      ^~

(and many more errors for these files)

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/cadence_ttc_timer.c | 1 +
 drivers/clocksource/timer-sun5i.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 44e5e95..8e64b84 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 2e9c830..c4656c4 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.7.4
