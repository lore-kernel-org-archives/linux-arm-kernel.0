From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 30 Jul 2013 17:07:52 +0800
Subject: [PATCH 1/2] arm: prima2: pm: enable rtc alarm0 and alarm1 as wakeup
 source
Message-ID: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xianglong Du <Xianglong.Du@csr.com>

this patch also enables RTC alarm as wakeup source after system suspends

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 02cc3438..3a944ed 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -34,7 +34,10 @@ static void sirfsoc_set_wakeup_source(void)
 	pwr_trigger_en_reg = sirfsoc_rtc_iobrg_readl(sirfsoc_pwrc_base +
 		SIRFSOC_PWRC_TRIGGER_EN);
 #define X_ON_KEY_B (1 << 0)
-	sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B,
+#define RTC_ALARM0_B (1 << 2)
+#define RTC_ALARM1_B (1 << 3)
+	sirfsoc_rtc_iobrg_writel(pwr_trigger_en_reg | X_ON_KEY_B |
+		RTC_ALARM0_B | RTC_ALARM1_B,
 		sirfsoc_pwrc_base + SIRFSOC_PWRC_TRIGGER_EN);
 }
 
-- 
1.8.2.3
