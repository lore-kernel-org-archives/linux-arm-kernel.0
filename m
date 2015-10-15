From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 15 Oct 2015 18:36:42 +0800
Subject: [PATCH] of/irq: export of_irq_count
Message-ID: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Export of_irq_count, otherwise module build fail if of_irq_count is used

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 0c7f4cbe3434..0d149cc48cfe 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -448,6 +448,7 @@ int of_irq_count(struct device_node *dev)
 
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
 
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info
-- 
1.9.1
