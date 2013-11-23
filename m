From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:28:46 -0500
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
Message-ID: <1385249326-9089-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building ARM with NO_BOOTMEM generates below warning. Using min_t
to find the correct alignment avoids the warning.

Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 mm/nobootmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index 2c254d3..8954e43 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -85,7 +85,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min(MAX_ORDER - 1UL, __ffs(start));
+		order = min_t(size_t, MAX_ORDER - 1UL, __ffs(start));
 
 		while (start + (1UL << order) > end)
 			order--;
-- 
1.7.9.5
