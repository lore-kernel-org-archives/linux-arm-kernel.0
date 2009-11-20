From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 13:07:57 +0000
Subject: [PATCH 2/2] ARM: PNX4008: fix watchdog device driver name
In-Reply-To: <20091120135932.GA16920@n2100.arm.linux.org.uk>
References: <20091120135932.GA16920@n2100.arm.linux.org.uk>
Message-ID: <da1369220883f255fa6f4b773fec9a8a8b1db5cc.1258725164.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/watchdog/pnx4008_wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index f24d041..4d227b1 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -317,7 +317,7 @@ static int __devexit pnx4008_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver platform_wdt_driver = {
 	.driver = {
-		.name = "watchdog",
+		.name = "pnx4008-watchdog",
 		.owner	= THIS_MODULE,
 	},
 	.probe = pnx4008_wdt_probe,
@@ -352,4 +352,4 @@ MODULE_PARM_DESC(nowayout,
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-MODULE_ALIAS("platform:watchdog");
+MODULE_ALIAS("platform:pnx4008-watchdog");
-- 
1.6.2.5
