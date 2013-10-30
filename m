From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 30 Oct 2013 23:57:00 +0000
Subject: [PATCH] watchdog: imx2_wdt: add module device table
Message-ID: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/watchdog/imx2_wdt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 693ac3f4de5a..ae1ac198d968 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -340,3 +340,4 @@ MODULE_DESCRIPTION("Watchdog driver for IMX2 and later");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
-- 
1.7.4.4
