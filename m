From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 Sep 2016 18:22:19 +0300
Subject: [PATCH 8/8] crypto: omap-sham: shrink the internal buffer size
In-Reply-To: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
References: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
Message-ID: <1474298539-23897-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current internal buffer size is way too large for crypto core, so
shrink it to be smaller. This makes the buffer to fit into the space
reserved for the export/import buffers also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 8eefd79..d0b16e5 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -135,7 +135,7 @@
 #define OMAP_ALIGN_MASK		(sizeof(u32)-1)
 #define OMAP_ALIGNED		__attribute__((aligned(sizeof(u32))))
 
-#define BUFLEN			PAGE_SIZE
+#define BUFLEN			SHA512_BLOCK_SIZE
 #define OMAP_SHA_DMA_THRESHOLD	256
 
 struct omap_sham_dev;
-- 
1.9.1
