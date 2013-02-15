From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:45:01 +0000
Subject: [PATCH 31/40] abx500-chargalg: Use module_platform_driver() rather
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-32-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

deprecate some boilerplate code by using module_platform_driver
helper macro. No functional changes.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/abx500_chargalg.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index 55c9d2e..7e4bc01 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -2083,18 +2083,7 @@ static struct platform_driver abx500_chargalg_driver = {
 	},
 };
 
-static int __init abx500_chargalg_init(void)
-{
-	return platform_driver_register(&abx500_chargalg_driver);
-}
-
-static void __exit abx500_chargalg_exit(void)
-{
-	platform_driver_unregister(&abx500_chargalg_driver);
-}
-
-module_init(abx500_chargalg_init);
-module_exit(abx500_chargalg_exit);
+module_platform_driver(abx500_chargalg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski");
-- 
1.7.10.4
