From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:32 +0800
Subject: [PATCH v2 03/14] clocksource: sp804: append CONFIG_OF
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_matching_node() & of_device_is_available() are depend on CONFIG_OF
macro. If CONFIG_OF isn't defined for non-DT mode, the build error
occurs.

So add CONFIG_OF for those DT functions.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clocksource/timer-sp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-sp.c b/drivers/clocksource/timer-sp.c
index f8c2c54..5f2d700 100644
--- a/drivers/clocksource/timer-sp.c
+++ b/drivers/clocksource/timer-sp.c
@@ -197,6 +197,7 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 }
 
+#ifdef CONFIG_OF
 static struct device_node *from = NULL;
 
 static struct of_device_id sp804_timer_match[] __initdata = {
@@ -294,3 +295,4 @@ err:
 	iounmap(base);
 }
 CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_dt_init);
+#endif
-- 
1.7.10.4
