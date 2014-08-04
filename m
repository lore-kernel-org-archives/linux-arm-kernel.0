From: hans@hanshq.net (Hans Wennborg)
Date: Sun,  3 Aug 2014 17:19:01 -0700
Subject: [PATCH 05/19] media: s5p-mfs: fix %d confusingly prefixed with 0x in
 format string
Message-ID: <1407111541-14662-1-git-send-email-hans@hanshq.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index c1c12f8..e9175ab 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -525,7 +525,7 @@ static int s5p_mfc_set_enc_stream_buffer_v6(struct s5p_mfc_ctx *ctx,
 	WRITEL(addr, mfc_regs->e_stream_buffer_addr); /* 16B align */
 	WRITEL(size, mfc_regs->e_stream_buffer_size);
 
-	mfc_debug(2, "stream buf addr: 0x%08lx, size: 0x%d\n",
+	mfc_debug(2, "stream buf addr: 0x%08lx, size: 0x%x\n",
 		  addr, size);
 
 	return 0;
-- 
2.0.0.526.g5318336
