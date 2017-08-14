From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 09:50:17 +0100
Subject: [PATCH] ARM: dma-mapping: Do not pass data to gen_pool_set_algo()
Message-ID: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gen_pool_first_fit_order_align() does not make use of additional data,
so pass plain NULL there.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index fcf1473..785606e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -443,7 +443,7 @@ static int __init atomic_pool_init(void)
 
 		gen_pool_set_algo(atomic_pool,
 				gen_pool_first_fit_order_align,
-				(void *)PAGE_SHIFT);
+				NULL);
 		pr_info("DMA: preallocated %zu KiB pool for atomic coherent allocations\n",
 		       atomic_pool_size / 1024);
 		return 0;
-- 
2.0.0
