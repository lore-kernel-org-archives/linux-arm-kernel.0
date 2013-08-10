From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:17 +0200
Subject: [PATCH v2 03/11] dma: mmp_pdma: fix maximum transfer length
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-4-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no reason for limiting the maximum transfer length to 0x1000.
Take the actual bit mask instead; the PDMA is able to transfer chunks of
up to SZ_8K - 1.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index f253695..9d6410e 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -71,7 +71,7 @@
 #define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
 
 #define PDMA_ALIGNMENT		3
-#define PDMA_MAX_DESC_BYTES	0x1000
+#define PDMA_MAX_DESC_BYTES	DCMD_LENGTH
 
 struct mmp_pdma_desc_hw {
 	u32 ddadr;	/* Points to the next descriptor + flags */
-- 
1.8.3.1
