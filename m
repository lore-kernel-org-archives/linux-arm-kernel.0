From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Sep 2018 09:43:55 +0200
Subject: [PATCH 10/10] block: don't include bug.h from bio.h
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
Message-ID: <20180924074355.2802-11-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to pull in the BUG() defintion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3d47862b1b4..f447b0ebb288 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/mempool.h>
 #include <linux/ioprio.h>
-#include <linux/bug.h>
 
 #ifdef CONFIG_BLOCK
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
-- 
2.19.0
