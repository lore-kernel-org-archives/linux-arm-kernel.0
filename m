From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Thu, 11 Sep 2014 19:07:41 +0530
Subject: [PATCH] arm64:mm: initialize max_mapnr using function set_max_mapnr
Message-ID: <1410442661-3383-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some config cases, max_mapnr is not defined and direct reference
results in to compilation error.
This is fixed by using set_max_mapnr() helper.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5472c24..271e654 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -256,7 +256,7 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
-	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 	free_unused_memmap();
-- 
1.8.1.4
