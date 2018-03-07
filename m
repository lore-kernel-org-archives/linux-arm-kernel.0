From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Wed,  7 Mar 2018 23:36:01 +0530
Subject: [PATCH] mfd: ab8500-debugfs: Use kasprintf
Message-ID: <1520445961-12160-1-git-send-email-himanshujha199640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use kasprintf instead of combination of kmalloc and sprintf.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/mfd/ab8500-debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 8ba4107..831a1ce 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2519,11 +2519,10 @@ static ssize_t ab8500_subscribe_write(struct file *file,
 	if (!dev_attr[irq_index])
 		return -ENOMEM;
 
-	event_name[irq_index] = kmalloc(count, GFP_KERNEL);
+	event_name[irq_index] = kasprintf(GFP_KERNEL, "%lu", user_val);
 	if (!event_name[irq_index])
 		return -ENOMEM;
 
-	sprintf(event_name[irq_index], "%lu", user_val);
 	dev_attr[irq_index]->show = show_irq;
 	dev_attr[irq_index]->store = NULL;
 	dev_attr[irq_index]->attr.name = event_name[irq_index];
-- 
2.7.4
