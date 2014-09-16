From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Tue, 16 Sep 2014 23:23:54 +0530
Subject: [PATCH RESEND] arm64:mm: initialize max_mapnr using function
 set_max_mapnr
Message-ID: <1410890034-27228-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initializing max_mapnr using set_max_mapnr() helper function instead
of direct reference. Also not adding PHYS_PFN_OFFSET to max_pfn,
since it already contains it.

Acked-by: Will Deacon <will.deacon@arm.com>
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
