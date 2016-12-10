From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:37 +0200
Subject: [PATCH 6/7] ARM: s3c24xx: Constify wake_irqs
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-6-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

samsung_sync_wakemask() accepts pointer to const data so wake_irqs can
be made const to increase safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/pm-s3c2412.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index d75f95e487ee..0ae4d47a4663 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -53,7 +53,7 @@ static int s3c2412_cpu_suspend(unsigned long arg)
 }
 
 /* mapping of interrupts to parts of the wakeup mask */
-static struct samsung_wakeup_mask wake_irqs[] = {
+static const struct samsung_wakeup_mask wake_irqs[] = {
 	{ .irq = IRQ_RTC,	.bit = S3C2412_PWRCFG_RTC_MASKIRQ, },
 };
 
-- 
2.7.4
