From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Apr 2014 18:34:12 +0100
Subject: [PATCH 1/3] arm64: Make default dma_ops to be noncoherent
In-Reply-To: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
References: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1398447254-18527-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Currently arm64 dma_ops is by default made coherent which makes it
opposite in default policy from arm.

Make default dma_ops to be noncoherent (same as arm), as currently there
aren't any dma-capable drivers which assumes coherent ops

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0ba347e59f06..1f65963a9c04 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -311,7 +311,7 @@ static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 
-	dma_ops = &coherent_swiotlb_dma_ops;
+	dma_ops = &noncoherent_swiotlb_dma_ops;
 
 	return swiotlb_late_init_with_default_size(swiotlb_size);
 }
