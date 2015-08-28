From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Aug 2015 11:18:49 -0700
Subject: [PATCH] soc: qcom: smem: Avoid NULL pointer exception on remove
Message-ID: <1440785929-22441-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't set a pointer to NULL and then dereference it in the next
line.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6603201d7fc7..4c347e7c5880 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -737,8 +737,8 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 static int qcom_smem_remove(struct platform_device *pdev)
 {
-	__smem = NULL;
 	hwspin_lock_free(__smem->hwlock);
+	__smem = NULL;
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
