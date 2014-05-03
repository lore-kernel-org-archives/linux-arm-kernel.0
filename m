From: agross@codeaurora.org (Andy Gross)
Date: Fri,  2 May 2014 20:54:29 -0500
Subject: [PATCH] i2c: qup: Fix pm_runtime_get_sync usage
Message-ID: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects the error check on the call to pm_runtime_get_sync.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 1b4cf14..2a5efb5 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -479,7 +479,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 	int ret, idx;
 
 	ret = pm_runtime_get_sync(qup->dev);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	writel(1, qup->base + QUP_SW_RESET);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
