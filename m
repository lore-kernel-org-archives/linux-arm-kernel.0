From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:13 -0700
Subject: [PATCH 02/11] coresight-etb: use module_amba_driver to simplify the
 code
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-etb10.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-etb10.c b/drivers/coresight/coresight-etb10.c
index c922d4aded8a..a1da7020201b 100644
--- a/drivers/coresight/coresight-etb10.c
+++ b/drivers/coresight/coresight-etb10.c
@@ -521,17 +521,7 @@ static struct amba_driver etb_driver = {
 	.id_table	= etb_ids,
 };
 
-static int __init etb_init(void)
-{
-	return amba_driver_register(&etb_driver);
-}
-module_init(etb_init);
-
-static void __exit etb_exit(void)
-{
-	amba_driver_unregister(&etb_driver);
-}
-module_exit(etb_exit);
+module_amba_driver(etb_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Embedded Trace Buffer driver");
-- 
1.9.1
