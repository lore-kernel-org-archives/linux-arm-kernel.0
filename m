From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 12 Jul 2016 18:33:58 -0600
Subject: [PATCH] media: s5p-mfc remove unnecessary error messages
Message-ID: <1468370038-5364-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing unnecessary error messages as appropriate error code is returned.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index b6fde20..906f80c 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -759,7 +759,6 @@ static int s5p_mfc_open(struct file *file)
 	/* Allocate memory for context */
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
-		mfc_err("Not enough memory\n");
 		ret = -ENOMEM;
 		goto err_alloc;
 	}
@@ -776,7 +775,6 @@ static int s5p_mfc_open(struct file *file)
 	while (dev->ctx[ctx->num]) {
 		ctx->num++;
 		if (ctx->num >= MFC_NUM_CONTEXTS) {
-			mfc_err("Too many open contexts\n");
 			ret = -EBUSY;
 			goto err_no_ctx;
 		}
-- 
2.7.4
