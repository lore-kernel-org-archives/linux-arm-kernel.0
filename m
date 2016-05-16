From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 16 May 2016 12:19:01 +0530
Subject: [PATCH V4 7/7] iommu/msm: Remove driver BROKEN
In-Reply-To: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1463381341-30498-8-git-send-email-sricharan@codeaurora.org>
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
