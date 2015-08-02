From: joe@perches.com (Joe Perches)
Date: Sun, 02 Aug 2015 13:30:53 -0700
Subject: [TRIVIAL PATCH] [media] s5p-mfc: Correct misuse of %0x<decimal>
Message-ID: <1438547453.29569.10.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct misuse of 0x%d in logging message.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
index 12497f5..c10ad57 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
@@ -520,7 +520,7 @@ static int s5p_mfc_set_enc_stream_buffer_v6(struct s5p_mfc_ctx *ctx,
        writel(addr, mfc_regs->e_stream_buffer_addr); /* 16B align */
        writel(size, mfc_regs->e_stream_buffer_size);
 
-       mfc_debug(2, "stream buf addr: 0x%08lx, size: 0x%d\n",
+       mfc_debug(2, "stream buf addr: 0x%08lx, size: 0x%x\n",
                  addr, size);
 
        return 0;
