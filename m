From: alim.akhtar@samsung.com (alim akhtar)
Date: Wed, 17 Aug 2011 09:36:07 +0530
Subject: [PATCH 1/3] ARM: EXYNOS4: register the second instance of pl330 DMAC
In-Reply-To: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
References: <1313553969-14639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <1313553969-14639-2-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alim Akhtar <alim.akhtar@samsung.com>

Platform data is provided for two instance of pl330 DMAC,
but only one DMAC is register with amba_device.
This patch register the second instance.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/mach-exynos4/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-exynos4/dma.c
index d57d662..9667c61 100644
--- a/arch/arm/mach-exynos4/dma.c
+++ b/arch/arm/mach-exynos4/dma.c
@@ -243,6 +243,7 @@ struct amba_device exynos4_device_pdma1 = {
 static int __init exynos4_dma_init(void)
 {
 	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
+	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
 
 	return 0;
 }
-- 
1.7.2.3
