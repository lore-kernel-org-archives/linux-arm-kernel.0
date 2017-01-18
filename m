From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jan 2017 15:27:22 -0800
Subject: [PATCH 1/5] iommu: Generalize MSM_IOMMU config to ARCH_QCOM
In-Reply-To: <20170118232726.22876-1-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
Message-ID: <20170118232726.22876-2-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to get rid of the ARCH_MSM* configs in the future, but
this still depends on them. Generalize to the ARCH_QCOM config,
which isn't going away.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d71c7eb..a91fc7986428 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -88,7 +88,7 @@ config FSL_PAMU
 config MSM_IOMMU
 	bool "MSM IOMMU Support"
 	depends on ARM
-	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
+	depends on ARCH_QCOM || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_ARMV7S
 	help
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
