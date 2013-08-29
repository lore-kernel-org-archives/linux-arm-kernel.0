From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 29 Aug 2013 19:32:25 +0100
Subject: [PATCH v5 04/13] arm64: do not initialize arm64_swiotlb if dma_ops is
 already set
In-Reply-To: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
Message-ID: <1377801154-29215-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: will.deacon at arm.com
---
 arch/arm64/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4bd7579..a006e84 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -63,6 +63,8 @@ static struct dma_map_ops arm64_swiotlb_dma_ops = {
 
 void __init arm64_swiotlb_init(void)
 {
+	if (dma_ops != NULL)
+		return;
 	dma_ops = &arm64_swiotlb_dma_ops;
 	swiotlb_init(1);
 }
-- 
1.7.2.5
