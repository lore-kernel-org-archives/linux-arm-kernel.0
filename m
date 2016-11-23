From: geliangtang@gmail.com (Geliang Tang)
Date: Wed, 23 Nov 2016 23:04:21 +0800
Subject: [PATCH] soc/fsl/qe: use builtin_platform_driver
Message-ID: <2fd43af1f6666eb4ebdbaeb80aa8618b97236813.1479913430.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/soc/fsl/qe/qe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2707a82..ade168f 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -717,9 +717,5 @@ static struct platform_driver qe_driver = {
 	.resume = qe_resume,
 };
 
-static int __init qe_drv_init(void)
-{
-	return platform_driver_register(&qe_driver);
-}
-device_initcall(qe_drv_init);
+builtin_platform_driver(qe_driver);
 #endif /* defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx) */
-- 
2.9.3
