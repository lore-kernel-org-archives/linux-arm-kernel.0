From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:06 -0600
Subject: [PATCH 01/16] coresight-etm3x: use module_amba_driver to simplify the
 code
In-Reply-To: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
References: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1432054521-24807-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using function "module_amba_driver()" makes the code simpler by
eliminating boilerplate code.

Wei Yongjun sent out a set of patches addressing those in all the
coresight driver but missed ETMv3.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index c965f5724abd..d78fcc23c4e0 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1916,17 +1916,7 @@ static struct amba_driver etm_driver = {
 	.id_table	= etm_ids,
 };
 
-int __init etm_init(void)
-{
-	return amba_driver_register(&etm_driver);
-}
-module_init(etm_init);
-
-void __exit etm_exit(void)
-{
-	amba_driver_unregister(&etm_driver);
-}
-module_exit(etm_exit);
+module_amba_driver(etm_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Program Flow Trace driver");
-- 
1.9.1
