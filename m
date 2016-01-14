From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jan 2016 07:11:27 +0000
Subject: [PATCH 2/4] mailbox: mailbox-test: Remove unused variable
In-Reply-To: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
References: <1452755489-18736-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1452755489-18736-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even before it was unused, it always returned zero anyway.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 7d9b915..e370aa6 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -45,7 +45,6 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 				       size_t count, loff_t *ppos)
 {
 	struct mbox_test_device *tdev = filp->private_data;
-	int ret;
 
 	if (!tdev->tx_channel) {
 		dev_err(tdev->dev, "Channel cannot do Tx\n");
@@ -69,7 +68,7 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 		return -EFAULT;
 	}
 
-	return ret < 0 ? ret : count;
+	return count;
 }
 
 static const struct file_operations mbox_test_signal_ops = {
-- 
1.9.1
