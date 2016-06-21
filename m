From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 21 Jun 2016 13:34:41 +0900
Subject: [PATCH v4 8/8] iommu/rockchip: Enable Rockchip IOMMU on ARM64
In-Reply-To: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
Message-ID: <1466483681-36110-9-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Xue <xxm@rock-chips.com>

This patch makes it possible to compile the rockchip-iommu driver on
ARM64, so that it can be used with 64-bit SoCs equipped with this type
of IOMMU.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ad08603..5572621 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -218,7 +218,7 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM
+	depends on ARM || ARM64
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
-- 
2.8.0.rc3.226.g39d4020
