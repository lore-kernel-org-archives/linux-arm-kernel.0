From: ayaka@soulik.info (Randy Li)
Date: Sat,  9 Jul 2016 17:23:44 +0800
Subject: [PATCH 1/3] Revert "drivers/rtc/rtc-s3c.c: add .needs_src_clk to
 s3c6410 RTC data"
In-Reply-To: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
References: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Message-ID: <1468056226-19128-2-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 8792f7772f4f40ffc68bad5f28311205584b734d.
The s3c6410 rtc don't use rtc_src property, that property is designed
for Exynos5250 and Exynos5440. The problem reported in the commit
I mentioned should be fixed in the other way.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/rtc/rtc-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d01ad7e..5dc18ca 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -801,7 +801,6 @@ static struct s3c_rtc_data const s3c2443_rtc_data = {
 
 static struct s3c_rtc_data const s3c6410_rtc_data = {
 	.max_user_freq		= 32768,
-	.needs_src_clk		= true,
 	.irq_handler		= s3c6410_rtc_irq,
 	.set_freq		= s3c6410_rtc_setfreq,
 	.enable_tick		= s3c6410_rtc_enable_tick,
-- 
2.7.4
