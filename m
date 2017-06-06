From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:03 +0200
Subject: [PATCH v4 05/28] clocksource: owl: Add S900 support
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S900 SoC provides four 32-bit timers, TIMER0/1/2/3,
but no 2Hz timers.

An S900 datasheet can be found in 96Boards documentation:
https://github.com/96boards/documentation/blob/master/ConsumerEdition/Bubblegum-96/HardwareDocs/SoC_bubblegum96.pdf

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Dropped S900 DT data
 
 v3: new
 
 drivers/clocksource/owl-timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index 4609363a79a6..d19c53c11094 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -169,3 +169,4 @@ static int __init owl_timer_init(struct device_node *node)
 	return 0;
 }
 CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+CLOCKSOURCE_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.12.3
