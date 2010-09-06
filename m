From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 05:50:42 +0200
Subject: [PATCH 2/4] ARM: Samsung: s5p-fimc: fix dma coherent mask
In-Reply-To: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283745044-15514-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FIMC driver uses DMA_coherent allocator, which requires proper dma mask
to be set.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/dev-fimc0.c |    2 ++
 arch/arm/plat-s5p/dev-fimc1.c |    2 ++
 arch/arm/plat-s5p/dev-fimc2.c |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
index d3f1a9b..9f26096 100644
--- a/arch/arm/plat-s5p/dev-fimc0.c
+++ b/arch/arm/plat-s5p/dev-fimc0.c
@@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc0 = {
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
 	.resource	= s5p_fimc0_resource,
+	.dev.dma_mask	  = &s5p_device_fimc0.dev.coherent_dma_mask,
+	.dev.coherent_dma_mask = 0xffffffffUL,
 };
diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
index 41bd698..4149c49 100644
--- a/arch/arm/plat-s5p/dev-fimc1.c
+++ b/arch/arm/plat-s5p/dev-fimc1.c
@@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc1 = {
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
 	.resource	= s5p_fimc1_resource,
+	.dev.dma_mask	  = &s5p_device_fimc1.dev.coherent_dma_mask,
+	.dev.coherent_dma_mask = 0xffffffffUL,
 };
diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
index dfddeda..ced9097 100644
--- a/arch/arm/plat-s5p/dev-fimc2.c
+++ b/arch/arm/plat-s5p/dev-fimc2.c
@@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc2 = {
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
 	.resource	= s5p_fimc2_resource,
+	.dev.dma_mask	  = &s5p_device_fimc2.dev.coherent_dma_mask,
+	.dev.coherent_dma_mask = 0xffffffffUL,
 };
-- 
1.7.2.2
