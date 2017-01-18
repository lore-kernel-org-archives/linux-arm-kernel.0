From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:37 -0500
Subject: [PATCH 07/10] soc/qbman: add QMAN_REV32
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-8-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>

Add revision 3.2 of the QBMan block.  This is the version
for LS1043A and LS1046A SoCs.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c |    2 ++
 drivers/soc/fsl/qbman/qman_priv.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 67ae073..e68793d 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -719,6 +719,8 @@ static int fsl_qman_probe(struct platform_device *pdev)
 		qman_ip_rev = QMAN_REV30;
 	else if (major == 3 && minor == 1)
 		qman_ip_rev = QMAN_REV31;
+	else if (major == 3 && minor == 2)
+		qman_ip_rev = QMAN_REV32;
 	else {
 		dev_err(dev, "Unknown QMan version\n");
 		return -ENODEV;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 53685b5..554d5d4 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -247,6 +247,7 @@ struct qm_portal_config {
 #define QMAN_REV20 0x0200
 #define QMAN_REV30 0x0300
 #define QMAN_REV31 0x0301
+#define QMAN_REV32 0x0302
 extern u16 qman_ip_rev; /* 0 if uninitialised, otherwise QMAN_REVx */
 
 #define QM_FQID_RANGE_START 1 /* FQID 0 reserved for internal use */
-- 
1.7.9.5
