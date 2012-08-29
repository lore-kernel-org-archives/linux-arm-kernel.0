From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 29 Aug 2012 10:16:24 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Set the capability of pdm0 and pdm1 as
 DMA_PRIVATE
In-Reply-To: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
References: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1346215585-31023-2-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA clients pdma0 and pdma1 are internal to the SoC and are used only
by dedicated peripherals. Since they cannot be used for generic
purpose, their capability should be set as DMA_PRIVATE.

CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index f60b66d..21d568b 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -303,10 +303,12 @@ static int __init exynos_dma_init(void)
 
 	dma_cap_set(DMA_SLAVE, exynos_pdma0_pdata.cap_mask);
 	dma_cap_set(DMA_CYCLIC, exynos_pdma0_pdata.cap_mask);
+	dma_cap_set(DMA_PRIVATE, exynos_pdma0_pdata.cap_mask);
 	amba_device_register(&exynos_pdma0_device, &iomem_resource);
 
 	dma_cap_set(DMA_SLAVE, exynos_pdma1_pdata.cap_mask);
 	dma_cap_set(DMA_CYCLIC, exynos_pdma1_pdata.cap_mask);
+	dma_cap_set(DMA_PRIVATE, exynos_pdma1_pdata.cap_mask);
 	amba_device_register(&exynos_pdma1_device, &iomem_resource);
 
 	dma_cap_set(DMA_MEMCPY, exynos_mdma1_pdata.cap_mask);
-- 
1.7.4.1
