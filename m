From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 3 Aug 2018 14:26:27 +0800
Subject: [PATCH] ARM: dmabounce: remove unnecessary NULL check before
 dma_pool_destroy
Message-ID: <20180803062627.22572-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_pool_destroy will do NULL check,thus the check before
the call is not needed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9a92de6..dcdd80c 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -569,10 +569,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}
 
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);
 
 #ifdef STATS
 	if (device_info->attr_res == 0)
-- 
2.7.0
