From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:16 -0700
Subject: [PATCH 05/11] coresight-tpiu: use module_amba_driver to simplify the
 code
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

module_amba_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-tpiu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/coresight/coresight-tpiu.c b/drivers/coresight/coresight-tpiu.c
index ae101082791a..3b33af2416bb 100644
--- a/drivers/coresight/coresight-tpiu.c
+++ b/drivers/coresight/coresight-tpiu.c
@@ -201,17 +201,7 @@ static struct amba_driver tpiu_driver = {
 	.id_table	= tpiu_ids,
 };
 
-static int __init tpiu_init(void)
-{
-	return amba_driver_register(&tpiu_driver);
-}
-module_init(tpiu_init);
-
-static void __exit tpiu_exit(void)
-{
-	amba_driver_unregister(&tpiu_driver);
-}
-module_exit(tpiu_exit);
+module_amba_driver(tpiu_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Trace Port Interface Unit driver");
-- 
1.9.1
