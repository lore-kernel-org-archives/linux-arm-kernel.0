From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:32 +0200
Subject: [PATCH RFC 08/11] staging: bcm2835-audio: use
 module_platform_driver() macro
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-9-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is not much value behind this boilerplate, so use
module_platform_driver() instead.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c    | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 87d56ab..87a27fd 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -356,25 +356,7 @@ static struct platform_driver bcm2835_alsa0_driver = {
 		.of_match_table = snd_bcm2835_of_match_table,
 	},
 };
-
-static int bcm2835_alsa_device_init(void)
-{
-	int retval;
-
-	retval = platform_driver_register(&bcm2835_alsa0_driver);
-	if (retval)
-		pr_err("Error registering bcm2835_audio driver %d .\n", retval);
-
-	return retval;
-}
-
-static void bcm2835_alsa_device_exit(void)
-{
-	platform_driver_unregister(&bcm2835_alsa0_driver);
-}
-
-late_initcall(bcm2835_alsa_device_init);
-module_exit(bcm2835_alsa_device_exit);
+module_platform_driver(bcm2835_alsa0_driver);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
-- 
2.7.4
