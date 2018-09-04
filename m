From: hch@lst.de (Christoph Hellwig)
Date: Tue,  4 Sep 2018 12:14:30 -0700
Subject: [PATCH 12/13] block: don't include bug.h from bio.h
In-Reply-To: <20180904191431.20102-1-hch@lst.de>
References: <20180904191431.20102-1-hch@lst.de>
Message-ID: <20180904191431.20102-13-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to pull in the BUG() defintion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3af2fea686a9..85f2e56ecdb8 100644
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
2.18.0
