From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 16:50:36 -0500
Subject: [PATCH v3 03/23] mm/bootmem: remove duplicated declaration of
 __free_pages_bootmem()
In-Reply-To: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386625856-12942-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The __free_pages_bootmem is used internally by MM core and
already defined in internal.h. So, remove duplicated declaration.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 include/linux/bootmem.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index f1f07d3..55d52fb 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -52,7 +52,6 @@ extern void free_bootmem_node(pg_data_t *pgdat,
 			      unsigned long size);
 extern void free_bootmem(unsigned long physaddr, unsigned long size);
 extern void free_bootmem_late(unsigned long physaddr, unsigned long size);
-extern void __free_pages_bootmem(struct page *page, unsigned int order);
 
 /*
  * Flags for reserve_bootmem (also if CONFIG_HAVE_ARCH_BOOTMEM_NODE,
-- 
1.7.9.5
