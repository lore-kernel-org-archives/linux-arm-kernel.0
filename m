From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 16 Aug 2012 19:59:51 +0800
Subject: [PATCH 3/3] rtc: pxa: convert to use module_platform_driver()
Message-ID: <1345118391-10577-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
---
 drivers/rtc/rtc-pxa.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 3a060d2..b2a1c7f 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -432,18 +432,7 @@ static struct platform_driver pxa_rtc_driver = {
 	},
 };
 
-static int __init pxa_rtc_init(void)
-{
-	return platform_driver_register(&pxa_rtc_driver);
-}
-
-static void __exit pxa_rtc_exit(void)
-{
-	platform_driver_unregister(&pxa_rtc_driver);
-}
-
-module_init(pxa_rtc_init);
-module_exit(pxa_rtc_exit);
+module_platform_driver(pxa_rtc_driver);
 
 MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
 MODULE_DESCRIPTION("PXA27x/PXA3xx Realtime Clock Driver (RTC)");
-- 
1.7.0.4
