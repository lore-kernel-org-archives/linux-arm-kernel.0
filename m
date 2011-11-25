From: jtzhou@marvell.com (Jett.Zhou)
Date: Fri, 25 Nov 2011 18:53:26 +0800
Subject: [V1 1/3] RTC: sa1100: Clean out ost register
Message-ID: <1322218408-1674-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These registers are used in old ioctl of UIE and PIE, now they are
emulated by rtc generic code of hrtimer, so it can be removed.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 0b40bb8..6f22c1f 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -36,7 +36,6 @@
 
 #ifdef CONFIG_ARCH_PXA
 #include <mach/regs-rtc.h>
-#include <mach/regs-ost.h>
 #endif
 
 #define RTC_DEF_DIVIDER		(32768 - 1)
@@ -188,8 +187,6 @@ static void sa1100_rtc_release(struct device *dev)
 {
 	spin_lock_irq(&sa1100_rtc_lock);
 	RTSR = 0;
-	OIER &= ~OIER_E1;
-	OSSR = OSSR_M1;
 	spin_unlock_irq(&sa1100_rtc_lock);
 
 	free_irq(IRQ_RTCAlrm, dev);
-- 
1.7.0.4
