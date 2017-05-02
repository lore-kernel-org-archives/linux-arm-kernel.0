From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  2 May 2017 16:15:03 +0800
Subject: [PATCH] coresight: use const for device_node structures
Message-ID: <1493712903-16726-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost low level functions from open firmware have used const to
qualify device_node structures, so add const for device_node
parameters in of_coresight related functions.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 4 ++--
 include/linux/coresight.h                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 629e031..859ad49 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -52,7 +52,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
-static void of_coresight_get_ports(struct device_node *node,
+static void of_coresight_get_ports(const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
 	struct device_node *ep = NULL;
@@ -102,7 +102,7 @@ static int of_coresight_alloc_memory(struct device *dev,
 }
 
 struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node)
+			struct device *dev, const struct device_node *node)
 {
 	int i = 0, ret = 0, cpu;
 	struct coresight_platform_data *pdata;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2a5982c..769f2c8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -264,10 +264,10 @@ static inline int coresight_timeout(void __iomem *addr, u32 offset,
 
 #ifdef CONFIG_OF
 extern struct coresight_platform_data *of_get_coresight_platform_data(
-				struct device *dev, struct device_node *node);
+	struct device *dev, const struct device_node *node);
 #else
 static inline struct coresight_platform_data *of_get_coresight_platform_data(
-	struct device *dev, struct device_node *node) { return NULL; }
+	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
 #ifdef CONFIG_PID_NS
-- 
2.7.4
