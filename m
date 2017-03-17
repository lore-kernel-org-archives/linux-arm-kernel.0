From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Fri, 17 Mar 2017 12:05:59 +0200
Subject: [PATCH 4/7] soc/qman: add macros needed by caam/qi driver
In-Reply-To: <20170317100602.2837-1-horia.geanta@nxp.com>
References: <20170317100602.2837-1-horia.geanta@nxp.com>
Message-ID: <20170317100602.2837-5-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few other things need to be added in soc/qman, such that
caam/qi won't open-code them.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 include/soc/fsl/qman.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 0252c32f7421..d4dfefdee6c1 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -168,6 +168,7 @@ static inline void qm_fd_set_param(struct qm_fd *fd, enum qm_fd_format fmt,
 #define qm_fd_set_contig_big(fd, len) \
 	qm_fd_set_param(fd, qm_fd_contig_big, 0, len)
 #define qm_fd_set_sg_big(fd, len) qm_fd_set_param(fd, qm_fd_sg_big, 0, len)
+#define qm_fd_set_compound(fd, len) qm_fd_set_param(fd, qm_fd_compound, 0, len)
 
 static inline void qm_fd_clear_fd(struct qm_fd *fd)
 {
@@ -642,6 +643,7 @@ struct qm_mcc_initcgr {
 #define QM_CGR_WE_MODE			0x0001
 
 #define QMAN_CGR_FLAG_USE_INIT	     0x00000001
+#define QMAN_CGR_MODE_FRAME          0x00000001
 
 	/* Portal and Frame Queues */
 /* Represents a managed portal */
-- 
2.12.0.264.gd6db3f216544
