From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 06 Dec 2014 11:51:49 +0800
Subject: [PATCH] soc: ti: Make knav_acc_range_ops and knav_gp_range_ops static
Message-ID: <1417837909.29417.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/ti/knav_qmss_acc.c   | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 6fbfde6e..f94d6ac 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -463,7 +463,7 @@ static int knav_acc_free_range(struct knav_range_info *range)
 	return 0;
 }
 
-struct knav_range_ops knav_acc_range_ops = {
+static struct knav_range_ops knav_acc_range_ops = {
 	.set_notify	= knav_acc_set_notify,
 	.init_queue	= knav_acc_init_queue,
 	.open_queue	= knav_acc_open_queue,
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8e6a95d..a9a565a 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -393,7 +393,7 @@ static int knav_gp_close_queue(struct knav_range_info *range,
 	return 0;
 }
 
-struct knav_range_ops knav_gp_range_ops = {
+static struct knav_range_ops knav_gp_range_ops = {
 	.set_notify	= knav_gp_set_notify,
 	.open_queue	= knav_gp_open_queue,
 	.close_queue	= knav_gp_close_queue,
-- 
1.9.1
