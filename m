From: sricharan@codeaurora.org (Sricharan R)
Date: Wed,  6 Apr 2016 19:59:35 +0530
Subject: [PATCH V2 5/5] iommu/msm: Remove driver BROKEN
In-Reply-To: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1459952975-1250-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver is DT adapted, bus_set_iommu gets called only
when on compatible matching. So the driver should not break multiplatform
builds now. So remove the BROKEN config.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f5d496..b81a0bb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -90,7 +90,6 @@ config MSM_IOMMU
 	bool "MSM IOMMU Support"
 	depends on ARM
 	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
-	depends on BROKEN
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_ARMV7S
 	help
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
