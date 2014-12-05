From: dingtianhong@huawei.com (Ding Tianhong)
Date: Fri, 5 Dec 2014 16:39:46 +0800
Subject: [PATCH] arm64: remove the unnecessary arm64_swiotlb_init()
Message-ID: <54816F52.5040206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 3690951fc6d42f3a0903987677d0e592c49dd8db
(arm64: Use swiotlb late initialisation)
switches the DMA mapping code to swiotlb_tlb_late_init_with_default_size(),
the arm64_swiotlb_init() will not used anymore, so remove this function.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/mm/mm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
index d519f4f..50c3351 100644
--- a/arch/arm64/mm/mm.h
+++ b/arch/arm64/mm/mm.h
@@ -1,2 +1 @@
 extern void __init bootmem_init(void);
-extern void __init arm64_swiotlb_init(void);
-- 
1.8.0
