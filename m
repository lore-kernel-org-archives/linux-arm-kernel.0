From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:42 +0200
Subject: [PATCH 05/15] hwrng: bcm2835: fix MODULE_LICENSE tag
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MODULE_LICENSE macro invocation must use either "GPL" or "GPL v2",
but not "GPLv2" in order to be detected by the module loader.

This fixes the allmodconfig build error:

FATAL: modpost: GPL-incompatible module bcm2835-rng.ko uses GPL-only symbol 'platform_driver_unregister'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dom Cobley <popcornmix@gmail.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Matt Mackall <mpm@selenic.com>
Cc: linux-rpi-kernel at lists.infradead.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/char/hw_random/bcm2835-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index eb7f147..43577ca 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -110,4 +110,4 @@ module_platform_driver(bcm2835_rng_driver);
 
 MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
 MODULE_DESCRIPTION("BCM2835 Random Number Generator (RNG) driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.2
