From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 19 Oct 2016 16:50:18 -0300
Subject: [PATCH] hwrng: meson: Remove unneeded platform MODULE_ALIAS
Message-ID: <1476906618-14455-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson is a DT-only platform, which means the devices are
registered via OF and not using the legacy platform devices support.

So there's no need to have a MODULE_ALIAS("platform:meson-rng") since
the reported uevent MODALIAS to user-space will always be the OF one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/char/hw_random/meson-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
index 51864a509be7..119d698439ae 100644
--- a/drivers/char/hw_random/meson-rng.c
+++ b/drivers/char/hw_random/meson-rng.c
@@ -122,7 +122,6 @@ static struct platform_driver meson_rng_driver = {
 
 module_platform_driver(meson_rng_driver);
 
-MODULE_ALIAS("platform:meson-rng");
 MODULE_DESCRIPTION("Meson H/W Random Number Generator driver");
 MODULE_AUTHOR("Lawrence Mok <lawrence.mok@amlogic.com>");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
-- 
2.7.4
