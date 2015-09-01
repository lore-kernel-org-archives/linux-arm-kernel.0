From: kuleshovmail@gmail.com (Alexander Kuleshov)
Date: Tue,  1 Sep 2015 20:29:48 +0600
Subject: [PATCH 5/5 v2] arm/mmu: Use memblock_first_region_size() helper
In-Reply-To: <1441117527-30466-1-git-send-email-kuleshovmail@gmail.com>
References: <1441117527-30466-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <1441117788-30822-1-git-send-email-kuleshovmail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 0a11142e commit (mm/memblock: Introduce memblock_first_region_size()
helper) introduced memblock_first_region_size() helper for the getting
size of the first memblock region. Let's use it instead of directly access
to structure.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 870838a..fc60882 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1176,7 +1176,7 @@ static inline void prepare_page_table(void)
 	/*
 	 * Find the end of the first block of lowmem.
 	 */
-	end = memblock.memory.regions[0].base + memblock.memory.regions[0].size;
+	end = memblock.memory.regions[0].base + memblock_first_region_size();
 	if (end >= arm_lowmem_limit)
 		end = arm_lowmem_limit;
 
-- 
2.5.0
