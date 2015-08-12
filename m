From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 12 Aug 2015 20:17:49 +0530
Subject: [PATCH 5/5] iommu/msm: Remove driver BROKEN
In-Reply-To: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
References: <1439390869-6347-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1439390869-6347-6-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the driver is DT adapted, bus_set_iommu gets called
only when on compatible matching. So the driver should not
break multiplatform  builds now. So remove the BROKEN config.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f1fb1d3..147de52 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -64,7 +64,6 @@ config MSM_IOMMU
 	bool "MSM IOMMU Support"
 	depends on ARM
 	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
-	depends on BROKEN
 	select IOMMU_API
 	help
 	  Support for the IOMMUs found on certain Qualcomm SOCs.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
