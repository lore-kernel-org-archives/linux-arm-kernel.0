From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Thu, 11 Sep 2014 14:46:13 +0530
Subject: [RFC PATCH] arm64:mm: delete max_mapnr init.
Message-ID: <1410426973-32393-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

setting max_mapnr results in to error, if enabled with CONFIG_NUMA,
which i have to replace with function set_max_mapnr.
However this variable is not used in arm64(with default defconfig) and better to
delete instead.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/mm/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5472c24..548bd01 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -256,7 +256,6 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
-	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 	free_unused_memmap();
-- 
1.8.1.4
