From: alexanders83@web.de (Alexander Stein)
Date: Sat, 12 Apr 2014 11:08:24 +0200
Subject: [PATCH 1/4] ALSA: sound/atmel/ac97c.c: Convert to
 module_platform_driver
In-Reply-To: <1397293707-26890-1-git-send-email-alexanders83@web.de>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
Message-ID: <1397293707-26890-2-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THis reduces some boilerplate code.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 sound/atmel/ac97c.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index c5f0ddd..9a13875 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1202,6 +1202,7 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_ac97c_driver = {
+	.probe		= atmel_ac97c_probe,
 	.remove		= atmel_ac97c_remove,
 	.driver		= {
 		.name	= "atmel_ac97c",
@@ -1209,19 +1210,7 @@ static struct platform_driver atmel_ac97c_driver = {
 		.pm	= ATMEL_AC97C_PM_OPS,
 	},
 };
-
-static int __init atmel_ac97c_init(void)
-{
-	return platform_driver_probe(&atmel_ac97c_driver,
-			atmel_ac97c_probe);
-}
-module_init(atmel_ac97c_init);
-
-static void __exit atmel_ac97c_exit(void)
-{
-	platform_driver_unregister(&atmel_ac97c_driver);
-}
-module_exit(atmel_ac97c_exit);
+module_platform_driver(atmel_ac97c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for Atmel AC97 controller");
-- 
1.9.2
