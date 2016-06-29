From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 29 Jun 2016 15:35:00 -0500
Subject: [PATCH] firmware: qcom_scm: Add missing is_available API
Message-ID: <1467232500-23866-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add back function that was dropped when reworking the SCM code.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 drivers/firmware/qcom_scm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 84330c5..89c3775 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -308,6 +308,14 @@ static const struct reset_control_ops qcom_scm_pas_reset_ops = {
 	.deassert = qcom_scm_pas_reset_deassert,
 };
 
+/**
+ * qcom_scm_is_available() - Checks if SCM is available
+ */
+bool qcom_scm_is_available(void)
+{
+	return !!__scm;
+}
+EXPORT_SYMBOL(qcom_scm_is_available);
 
 static int qcom_scm_probe(struct platform_device *pdev)
 {
-- 
1.9.1
