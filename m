From: colin.king@canonical.com (Colin King)
Date: Sun, 14 May 2017 17:47:41 +0100
Subject: [PATCH] [media] s5p-mfc: fix spelling mistake: "destionation" ->
 "destination"
Message-ID: <20170514164741.6483-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in mfc_err error messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c | 2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
index b41ee608c171..0913881219ff 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
@@ -1293,7 +1293,7 @@ static int s5p_mfc_run_init_dec_buffers(struct s5p_mfc_ctx *ctx)
 	 * First set the output frame buffers
 	 */
 	if (ctx->capture_state != QUEUE_BUFS_MMAPED) {
-		mfc_err("It seems that not all destionation buffers were mmaped\nMFC requires that all destination are mmaped before starting processing\n");
+		mfc_err("It seems that not all destination buffers were mmaped\nMFC requires that all destination are mmaped before starting processing\n");
 		return -EAGAIN;
 	}
 	if (list_empty(&ctx->src_queue)) {
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 85880e9106be..88dbb9c341ec 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1650,7 +1650,7 @@ static inline int s5p_mfc_run_init_dec_buffers(struct s5p_mfc_ctx *ctx)
 	 * s5p_mfc_alloc_dec_buffers(ctx); */
 
 	if (ctx->capture_state != QUEUE_BUFS_MMAPED) {
-		mfc_err("It seems that not all destionation buffers were\n"
+		mfc_err("It seems that not all destination buffers were\n"
 			"mmaped.MFC requires that all destination are mmaped\n"
 			"before starting processing.\n");
 		return -EAGAIN;
-- 
2.11.0
