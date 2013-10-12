From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Oct 2013 17:59:03 -0400
Subject: [RFC 20/23] mm/firmware: Use memblock apis for early memory
 allocations
In-Reply-To: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1381615146-20342-21-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to memblock interfaces for early memory allocator

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/firmware/memmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index e2e04b0..fa8a789 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -324,7 +324,7 @@ int __init firmware_map_add_early(u64 start, u64 end, const char *type)
 {
 	struct firmware_map_entry *entry;
 
-	entry = alloc_bootmem(sizeof(struct firmware_map_entry));
+	entry = memblock_early_alloc(sizeof(struct firmware_map_entry));
 	if (WARN_ON(!entry))
 		return -ENOMEM;
 
-- 
1.7.9.5
