From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 07 Jun 2016 13:32:16 +0200
Subject: [PATCH] media: s5p-mfc: fix compilation issue on archs other than ARM
 (32bit)
In-Reply-To: <20160607105823.GT7510@sirena.org.uk>
References: <20160607105823.GT7510@sirena.org.uk>
Message-ID: <1465299136-8596-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes build break caused by lack of dma-iommu API on ARM64
(this API is specific to ARM 32bit architecture).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h b/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
index 5d1d1c2..6962132 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
@@ -14,7 +14,7 @@
 #define S5P_MFC_IOMMU_DMA_BASE	0x20000000lu
 #define S5P_MFC_IOMMU_DMA_SIZE	SZ_256M
 
-#ifdef CONFIG_EXYNOS_IOMMU
+#if defined(CONFIG_EXYNOS_IOMMU) && defined(CONFIG_ARM_DMA_USE_IOMMU)
 
 #include <asm/dma-iommu.h>
 
-- 
1.9.2
