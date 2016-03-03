From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Mar 2016 17:03:35 +0900
Subject: [RFC 09/15] media: platform: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1456992221-26712-10-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
direct dependencies.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/media/platform/Kconfig            | 1 +
 drivers/media/platform/exynos4-is/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 201f5c296a95..e5931e434fa2 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -79,6 +79,7 @@ config VIDEO_OMAP3
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3
 	depends on HAS_DMA && OF
 	depends on OMAP_IOMMU
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select ARM_DMA_USE_IOMMU
 	select VIDEOBUF2_DMA_CONTIG
 	select MFD_SYSCON
diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index 57d42c6172c5..c4317b99d257 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -17,6 +17,7 @@ config VIDEO_S5P_FIMC
 	tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
 	depends on I2C
 	depends on HAS_DMA
+	depends on HAS_IOMEM	# For MFD_SYSCON
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select MFD_SYSCON
-- 
2.5.0
