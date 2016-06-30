From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 30 Jun 2016 10:02:04 +0800
Subject: [PATCH] arm64: mm: remove unnecessary BUG_ON
Message-ID: <1467252124-19625-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memblock_alloc() and memblock_alloc_base() will panic on their own
if no free memory, remove pointless BUG_ON.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/mmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0f85a46..d120abc 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -77,7 +77,6 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	void *ptr;
 
 	phys = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	BUG_ON(!phys);
 
 	/*
 	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
-- 
2.6.0.GIT
