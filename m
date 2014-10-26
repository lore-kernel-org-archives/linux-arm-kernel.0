From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 26 Oct 2014 17:39:26 +0800
Subject: [PATCH 3/3] soc: ti: knav_qmss_queue: Return proper error if
 devm_kzalloc fails
In-Reply-To: <1414316264.4290.2.camel@phoenix>
References: <1414316264.4290.2.camel@phoenix>
Message-ID: <1414316366.4290.4.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return -ENOMEM if devm_kzalloc fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index d66aaf2..6f22d56 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1640,7 +1640,7 @@ static int knav_queue_init_queues(struct knav_device *kdev)
 	size = (1 << kdev->inst_shift) * kdev->num_queues_in_use;
 	kdev->instances = devm_kzalloc(kdev->dev, size, GFP_KERNEL);
 	if (!kdev->instances)
-		return -1;
+		return -ENOMEM;
 
 	for_each_queue_range(kdev, range) {
 		if (range->ops && range->ops->init_range)
-- 
1.9.1
