From: colin.king@canonical.com (Colin King)
Date: Sun, 23 Sep 2018 23:14:36 +0100
Subject: [PATCH] soc: ti: fix spelling mistake "instace" -> "instance"
Message-ID: <20180923221436.7701-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err messages and comments

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/ti/knav_dma.c  | 4 ++--
 drivers/soc/ti/knav_qmss.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 224d7ddeeb76..23f09dce23e0 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -438,7 +438,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 
 	chan_num = of_channel_match_helper(dev->of_node, name, &instance);
 	if (chan_num < 0) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", name);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
 		return (void *)-EINVAL;
 	}
 
@@ -461,7 +461,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 		}
 	}
 	if (!found) {
-		dev_err(kdev->dev, "No DMA instace with name %s\n", instance);
+		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
 		return (void *)-EINVAL;
 	}
 
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 3efc47e82973..7c128132799e 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -240,14 +240,14 @@ struct knav_pool {
 };
 
 /**
- * struct knav_queue_inst:		qmss queue instace properties
+ * struct knav_queue_inst:		qmss queue instance properties
  * @descs:				descriptor pointer
  * @desc_head, desc_tail, desc_count:	descriptor counters
  * @acc:				accumulator channel pointer
  * @kdev:				qmss device pointer
  * @range:				range info
  * @qmgr:				queue manager info
- * @id:					queue instace id
+ * @id:					queue instance id
  * @irq_num:				irq line number
  * @notify_needed:			notifier needed based on queue type
  * @num_notifiers:			total notifiers
@@ -274,7 +274,7 @@ struct knav_queue_inst {
 /**
  * struct knav_queue:			qmss queue properties
  * @reg_push, reg_pop, reg_peek:	push, pop queue registers
- * @inst:				qmss queue instace properties
+ * @inst:				qmss queue instance properties
  * @notifier_fn:			notifier function
  * @notifier_fn_arg:			notifier function argument
  * @notifier_enabled:			notier enabled for a give queue
-- 
2.17.1
