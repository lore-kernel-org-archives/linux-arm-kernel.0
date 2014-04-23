From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 23 Apr 2014 10:59:46 +0530
Subject: [PATCH] arm64: Make default dma_ops to be noncoherent
In-Reply-To: <1398230986-2823-1-git-send-email-ritesh.harjani@gmail.com>
References: <20140422152152.GG9820@arm.com>
 <1398230986-2823-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1398230986-2823-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arm64 dma_ops is by default made coherent
which makes it opposite in default policy
from arm.

Make default dma_ops to be noncoherent (same
as arm), as currently there aren't any
dma-capable drivers which assumes coherent ops

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0ba347e..1f65963 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -311,7 +311,7 @@ static int __init swiotlb_late_init(void)
 {
 	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
 
-	dma_ops = &coherent_swiotlb_dma_ops;
+	dma_ops = &noncoherent_swiotlb_dma_ops;
 
 	return swiotlb_late_init_with_default_size(swiotlb_size);
 }
-- 
1.8.1.3
