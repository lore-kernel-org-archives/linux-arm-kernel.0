From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Wed, 15 Jun 2016 20:04:45 +0800
Subject: [PATCH v3 6/6] iommu/rockchip: enable rockchip iommu on ARM64 platform
In-Reply-To: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1465992285-16187-7-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Xue <xxm@rock-chips.com>

This patch makes it possible to compile the rockchip-iommu driver on
ARM64 platform to be used with 64-bit SoCs equipped with this type
of IOMMU.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
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
1.9.1
