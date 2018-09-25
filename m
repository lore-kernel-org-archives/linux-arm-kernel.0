From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Sep 2018 13:30:06 -0700
Subject: [PATCH 2/5] xen: remove the xen_biovec_phys_mergeable export
In-Reply-To: <20180925203009.1838-1-hch@lst.de>
References: <20180925203009.1838-1-hch@lst.de>
Message-ID: <20180925203009.1838-3-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BIOVEC_PHYS_MERGEABLE is only called from core block code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/biomerge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 55ed80c3a17c..399c4e30f723 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -20,4 +20,3 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 	return false;
 #endif
 }
-EXPORT_SYMBOL(xen_biovec_phys_mergeable);
-- 
2.19.0
