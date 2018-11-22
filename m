From: tiny.windzz@gmail.com (Yangtao Li)
Date: Thu, 22 Nov 2018 07:48:54 -0500
Subject: [PATCH] soc: ti: QMSS: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122124854.24528-1-tiny.windzz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8b418379272d..67f7c003417b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -483,17 +483,7 @@ static int knav_queue_debug_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int knav_queue_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, knav_queue_debug_show, NULL);
-}
-
-static const struct file_operations knav_queue_debug_ops = {
-	.open		= knav_queue_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(knav_queue_debug);
 
 static inline int knav_queue_pdsp_wait(u32 * __iomem addr, unsigned timeout,
 					u32 flags)
@@ -1883,7 +1873,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
-			    &knav_queue_debug_ops);
+			    &knav_queue_debug_fops);
 	device_ready = true;
 	return 0;
 
-- 
2.17.0
