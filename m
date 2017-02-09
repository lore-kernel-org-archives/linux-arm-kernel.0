From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu,  9 Feb 2017 15:10:51 -0700
Subject: [PATCH] media: fix s5p_mfc_set_dec_frame_buffer_v6() to print buf
 size in hex
Message-ID: <20170209221051.26234-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix s5p_mfc_set_dec_frame_buffer_v6() to print buffer size in hex to be
consistent with the rest of the messages in the routine.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index d6f207e..fc45980 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -497,7 +497,7 @@ static int s5p_mfc_set_dec_frame_buffer_v6(struct s5p_mfc_ctx *ctx)
 		}
 	}
 
-	mfc_debug(2, "Buf1: %zu, buf_size1: %d (frames %d)\n",
+	mfc_debug(2, "Buf1: %zx, buf_size1: %d (frames %d)\n",
 			buf_addr1, buf_size1, ctx->total_dpb_count);
 	if (buf_size1 < 0) {
 		mfc_debug(2, "Not enough memory has been allocated.\n");
-- 
2.7.4
