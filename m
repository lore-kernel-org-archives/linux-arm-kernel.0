From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:45 +0200
Subject: [PATCH 10/39] rtc: coh901331: add devicetree support
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-11-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This add devicetree probe support to the COH 901 331 RTC
driver.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Alessandro, I'm seeking an ACK to take this patch through
the ARM SoC tree along with the code making use of it.
---
 drivers/rtc/rtc-coh901331.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 93c0658..ad6863a 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -274,11 +274,17 @@ static void coh901331_shutdown(struct platform_device *pdev)
 	clk_disable_unprepare(rtap->clk);
 }
 
+static const struct of_device_id coh901331_dt_match[] = {
+	{ .compatible = "stericsson,coh901331" },
+	{},
+};
+
 static struct platform_driver coh901331_driver = {
 	.driver = {
 		.name = "rtc-coh901331",
 		.owner = THIS_MODULE,
 		.pm = &coh901331_pm_ops,
+		.of_match_table = coh901331_dt_match,
 	},
 	.remove = __exit_p(coh901331_remove),
 	.shutdown = coh901331_shutdown,
-- 
1.7.11.3
