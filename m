From: b18965@freescale.com (Alison Wang)
Date: Fri, 17 Jul 2015 17:11:52 +0800
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
Message-ID: <1437124312-44700-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hrtimer based broadcast is used on ARM platform. It can be
registered as the tick broadcast device in the absence of
a real external clock device.

Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
 arch/arm/kernel/time.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index a66e37e..a9bc73c 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -12,6 +12,7 @@
  *  reading the RTC at bootup, etc...
  */
 #include <linux/clk-provider.h>
+#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -121,5 +122,7 @@ void __init time_init(void)
 		of_clk_init(NULL);
 #endif
 		clocksource_of_init();
+
+		tick_setup_hrtimer_broadcast();
 	}
 }
-- 
2.1.0.27.g96db324
