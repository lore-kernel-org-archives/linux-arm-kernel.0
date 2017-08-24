From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 24 Aug 2017 16:37:52 -0400
Subject: [v4 08/11] soc/fsl/qbman: add QMAN_REV32
In-Reply-To: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1503607075-28970-9-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>

Add revision 3.2 of the QBMan block.  This is the version
for LS1043A and LS1046A SoCs.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
 drivers/soc/fsl/qbman/qman_priv.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 20a1ebd..bbe3975 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -720,6 +720,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
 		qman_ip_rev = QMAN_REV30;
 	else if (major == 3 && minor == 1)
 		qman_ip_rev = QMAN_REV31;
+	else if (major == 3 && minor == 2)
+		qman_ip_rev = QMAN_REV32;
 	else {
 		dev_err(dev, "Unknown QMan version\n");
 		return -ENODEV;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index bab7f15..8f715fa 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -185,6 +185,7 @@ struct qm_portal_config {
 #define QMAN_REV20 0x0200
 #define QMAN_REV30 0x0300
 #define QMAN_REV31 0x0301
+#define QMAN_REV32 0x0302
 extern u16 qman_ip_rev; /* 0 if uninitialised, otherwise QMAN_REVx */
 
 #define QM_FQID_RANGE_START 1 /* FQID 0 reserved for internal use */
-- 
2.7.4
