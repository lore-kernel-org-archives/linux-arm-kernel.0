From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  2 Jan 2017 14:06:58 -0300
Subject: [PATCH 2/3] crypto: picoxcell - Remove platform device ID table
In-Reply-To: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
References: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1483376819-26726-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is only used in the picoxcell platform and this is DT-only.

So only a OF device ID table is needed and there's no need to have a
platform device ID table. This patch removes the unneeded table.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/crypto/picoxcell_crypto.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index 47576098831f..539effbbfc7a 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1803,12 +1803,6 @@ static int spacc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id spacc_id_table[] = {
-	{ "picochip,spacc-ipsec", },
-	{ "picochip,spacc-l2", },
-	{ }
-};
-
 static struct platform_driver spacc_driver = {
 	.probe		= spacc_probe,
 	.remove		= spacc_remove,
@@ -1819,7 +1813,6 @@ static struct platform_driver spacc_driver = {
 #endif /* CONFIG_PM */
 		.of_match_table	= of_match_ptr(spacc_of_id_table),
 	},
-	.id_table	= spacc_id_table,
 };
 
 module_platform_driver(spacc_driver);
-- 
2.7.4
