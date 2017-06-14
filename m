From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Wed, 14 Jun 2017 11:06:56 -0700
Subject: [PATCH 2/2] remoteproc: qcom: Register segments with remoteproc
In-Reply-To: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
References: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1497463616-19868-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the firmware segments with remoteproc framework to ensure
that the coredumps can be collected in the event of fatal failures.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 drivers/remoteproc/qcom_adsp_pil.c | 1 +
 drivers/remoteproc/qcom_wcnss.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
index 335066e..f6d5ceac 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_adsp_pil.c
@@ -86,6 +86,7 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 static const struct rproc_fw_ops adsp_fw_ops = {
 	.find_rsc_table = qcom_mdt_find_rsc_table,
 	.load = adsp_load,
+	.register_segments = qcom_register_dump_segments,
 };
 
 static int adsp_start(struct rproc *rproc)
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 253f152e..efa295f 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -160,6 +160,7 @@ static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 static const struct rproc_fw_ops wcnss_fw_ops = {
 	.find_rsc_table = qcom_mdt_find_rsc_table,
 	.load = wcnss_load,
+	.register_segments = qcom_register_dump_segments,
 };
 
 static void wcnss_indicate_nv_download(struct qcom_wcnss *wcnss)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
