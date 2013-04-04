From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:08 +0200
Subject: [PATCH v4 11/14] clocksource: samsung-time: Use clk_prepare_enable
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to use clk_prepare_enable instead of
clk_enable, as required to be compliant with Common Clock Framework.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung-time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index e617d37..7674882 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -383,7 +383,7 @@ static void __init samsung_timer_resources(void)
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
 
-	clk_enable(tin_source);
+	clk_prepare_enable(timerclk);
 
 	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
 	if (pwm->variant.bits == 16) {
-- 
1.8.1.5
