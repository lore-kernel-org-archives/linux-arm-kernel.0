From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 6 Jun 2013 10:24:19 +0200
Subject: [PATCH v3 6/7] pcmcia: at91_cf: use module_platform_driver_probe()
In-Reply-To: <cover.1370506678.git.nicolas.ferre@atmel.com>
References: <cover.1370506678.git.nicolas.ferre@atmel.com>
Message-ID: <83a19de2ec83a4210b11b3ac49e3652d90e00a04.1370506678.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Porcedda <fabio.porcedda@gmail.com>

Use module_platform_driver_probe() macro which makes the code smaller
and simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pcmcia/at91_cf.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 149b95c..8ddc57c 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -411,17 +411,7 @@ static struct platform_driver at91_cf_driver = {
 
 /*--------------------------------------------------------------------------*/
 
-static int __init at91_cf_init(void)
-{
-	return platform_driver_probe(&at91_cf_driver, at91_cf_probe);
-}
-module_init(at91_cf_init);
-
-static void __exit at91_cf_exit(void)
-{
-	platform_driver_unregister(&at91_cf_driver);
-}
-module_exit(at91_cf_exit);
+module_platform_driver_probe(at91_cf_driver, at91_cf_probe);
 
 MODULE_DESCRIPTION("AT91 Compact Flash Driver");
 MODULE_AUTHOR("David Brownell");
-- 
1.8.2.2
