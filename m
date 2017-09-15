From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Sep 2017 18:01:13 +0200
Subject: [PATCH 1/2] [media] c8sectpfe: Delete an error message for a failed
 memory allocation in c8sectpfe_frontend_attach()
In-Reply-To: <3e5fcfbe-828a-8c15-12d4-c74e8a1f20f1@users.sourceforge.net>
References: <3e5fcfbe-828a-8c15-12d4-c74e8a1f20f1@users.sourceforge.net>
Message-ID: <04a4e480-c7a2-fe8c-ca38-8d0b32b42307@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Sep 2017 17:20:48 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
index 2c0015b1264d..1b23b188cd65 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
@@ -166,7 +166,4 @@ int c8sectpfe_frontend_attach(struct dvb_frontend **fe,
 					GFP_KERNEL);
-		if (!tda18212) {
-			dev_err(c8sectpfe->device,
-				"%s: devm_kzalloc failed\n", __func__);
+		if (!tda18212)
 			return -ENOMEM;
-		}
 
-- 
2.14.1
