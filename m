From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 18:41:39 -0500
Subject: [PATCH 03/24] mm/bootmem: remove duplicated declaration of
 __free_pages_bootmem()
In-Reply-To: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1383954120-24368-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The __free_pages_bootmem is used internally by MM core and
already defined in internal.h. So, remove duplicated declaration.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

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
