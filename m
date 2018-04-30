From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 18:35:54 +0200
Subject: [PATCH 1/3] clocksource: timer-ti-dm: remove the early platform
 driver registration
In-Reply-To: <20180430163556.2560-1-brgl@bgdev.pl>
References: <20180430163556.2560-1-brgl@bgdev.pl>
Message-ID: <20180430163556.2560-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..595124074821 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -991,7 +991,6 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-early_platform_init("earlytimer", &omap_dm_timer_driver);
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-- 
2.17.0
