From: colin.king@canonical.com (Colin King)
Date: Sat, 12 Nov 2016 17:01:30 +0000
Subject: [PATCH] soc/fsl: fix spelling mistakes in critical error messages
Message-ID: <20161112170130.6146-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake "uncommited" to "uncommitted" in
critical error messages.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/qbman/bman.c | 2 +-
 drivers/soc/fsl/qbman/qman.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index ffa48fd..48b7eb6 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -391,7 +391,7 @@ static void bm_rcr_finish(struct bm_portal *portal)
 
 	i = bm_in(portal, BM_REG_RCR_PI_CINH) & (BM_RCR_SIZE - 1);
 	if (i != rcr_ptr2idx(rcr->cursor))
-		pr_crit("losing uncommited RCR entries\n");
+		pr_crit("losing uncommitted RCR entries\n");
 
 	i = bm_in(portal, BM_REG_RCR_CI_CINH) & (BM_RCR_SIZE - 1);
 	if (i != rcr->ci)
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 119054b..deeacd5 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -443,7 +443,7 @@ static inline void qm_eqcr_finish(struct qm_portal *portal)
 
 	DPAA_ASSERT(!eqcr->busy);
 	if (pi != eqcr_ptr2idx(eqcr->cursor))
-		pr_crit("losing uncommited EQCR entries\n");
+		pr_crit("losing uncommitted EQCR entries\n");
 	if (ci != eqcr->ci)
 		pr_crit("missing existing EQCR completions\n");
 	if (eqcr->ci != eqcr_ptr2idx(eqcr->cursor))
-- 
2.10.2
