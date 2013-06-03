From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 23:57:37 +0200
Subject: [PATCH] crypto: sahara: fix building as module
Message-ID: <3573891.yE7nyLPekp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sahara crypto driver has an incorrect MODULE_DEVICE_TABLE, which
prevents us from actually building this driver as a loadable module.

sahara_dt_ids is a of_device_id array, so we have to use
MODULE_DEVICE_TABLE(of, ...).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index a97bb6c..c3dc1c0 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -863,7 +863,7 @@ static struct of_device_id sahara_dt_ids[] = {
 	{ .compatible = "fsl,imx27-sahara" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(platform, sahara_dt_ids);
+MODULE_DEVICE_TABLE(of, sahara_dt_ids);
 
 static int sahara_probe(struct platform_device *pdev)
 {
