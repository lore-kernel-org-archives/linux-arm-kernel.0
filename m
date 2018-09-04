From: hch@lst.de (Christoph Hellwig)
Date: Tue,  4 Sep 2018 12:14:29 -0700
Subject: [PATCH 11/13] block: don't include io.h from bio.h
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
Message-ID: <20180904191431.20102-12-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we don't need an override for BIOVEC_PHYS_MERGEABLE there is
no need to drag this header in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index fcb5f5618ed4..3af2fea686a9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -24,9 +24,6 @@
 #include <linux/bug.h>
 
 #ifdef CONFIG_BLOCK
-
-#include <asm/io.h>
-
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 
-- 
2.18.0
