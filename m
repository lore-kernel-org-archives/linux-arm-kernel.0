From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 07:43:38 +0200
Subject: [PATCH 04/14] mm: remove the unused device_private_entry_fault export
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
Message-ID: <20180516054348.15950-5-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/memremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index db4e1a373e5f..59ee3b604b39 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -65,7 +65,6 @@ int device_private_entry_fault(struct vm_area_struct *vma,
 	 */
 	return page->pgmap->page_fault(vma, addr, page, flags, pmdp);
 }
-EXPORT_SYMBOL(device_private_entry_fault);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 static void pgmap_radix_release(struct resource *res, unsigned long end_pgoff)
-- 
2.17.0
