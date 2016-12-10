From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:38 +0200
Subject: [PATCH 7/7] ARM: s3c64xx: Constify wake_irqs
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-7-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

samsung_sync_wakemask() accepts pointer to const data so wake_irqs can
be made const to increase safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c64xx/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 59d91b83b03d..b0be382ff6bb 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -285,7 +285,7 @@ static int s3c64xx_cpu_suspend(unsigned long arg)
 }
 
 /* mapping of interrupts to parts of the wakeup mask */
-static struct samsung_wakeup_mask wake_irqs[] = {
+static const struct samsung_wakeup_mask wake_irqs[] = {
 	{ .irq = IRQ_RTC_ALARM,	.bit = S3C64XX_PWRCFG_RTC_ALARM_DISABLE, },
 	{ .irq = IRQ_RTC_TIC,	.bit = S3C64XX_PWRCFG_RTC_TICK_DISABLE, },
 	{ .irq = IRQ_PENDN,	.bit = S3C64XX_PWRCFG_TS_DISABLE, },
-- 
2.7.4
