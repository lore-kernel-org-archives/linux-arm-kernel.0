From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 14 Jul 2016 08:40:22 -0600
Subject: [PATCH v2] media: s5p-mfc remove unnecessary error messages
Message-ID: <1468507222-5314-1-git-send-email-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed unnecessary error message as appropriate error code is returned.
Changed error message into a debug.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---

Changes since v1:
- Changed EBUSY error message to a debug message.

 drivers/media/platform/s5p-mfc/s5p_mfc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index b6fde20..eeb1db2 100644
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
@@ -776,7 +775,7 @@ static int s5p_mfc_open(struct file *file)
 	while (dev->ctx[ctx->num]) {
 		ctx->num++;
 		if (ctx->num >= MFC_NUM_CONTEXTS) {
-			mfc_err("Too many open contexts\n");
+			mfc_debug(2, "Too many open contexts\n");
 			ret = -EBUSY;
 			goto err_no_ctx;
 		}
-- 
2.7.4
