From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 21 Nov 2018 13:41:07 +0200
Subject: [PATCH v3 1/3] soc: fsl: qbman: read ithresh from HW
In-Reply-To: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
References: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
Message-ID: <1542800469-6802-2-git-send-email-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read the DQRR interrupt threshold directly from the hardware.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 5ce24718c2fd..ce7c03052e33 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1025,7 +1025,7 @@ EXPORT_SYMBOL(qman_dqrr_set_ithresh);
 void qman_dqrr_get_ithresh(struct qman_portal *portal, u8 *ithresh)
 {
 	if (portal && ithresh)
-		*ithresh = portal->p.dqrr.ithresh;
+		*ithresh = qm_in(&portal->p, QM_REG_DQRR_ITR);
 }
 EXPORT_SYMBOL(qman_dqrr_get_ithresh);
 
-- 
2.1.0
