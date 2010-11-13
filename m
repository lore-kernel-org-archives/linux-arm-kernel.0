From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:47 -0800
Subject: [PATCH 01/14] msm: iommu: Increase maximum MID size to 5 bits
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-2-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On msm8x60, the MID field on the AXI connection to the
IOMMU can be up to five bits wide. Thus, allow the IOMMU
context platform data to map up to 32 MIDs.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/iommu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/iommu.h b/arch/arm/mach-msm/include/mach/iommu.h
index 218ef57..17fc79f 100644
--- a/arch/arm/mach-msm/include/mach/iommu.h
+++ b/arch/arm/mach-msm/include/mach/iommu.h
@@ -26,7 +26,7 @@
  * be present. These mappings are typically determined at design time and are
  * not expected to change at run time.
  */
-#define MAX_NUM_MIDS	16
+#define MAX_NUM_MIDS	32
 
 /**
  * struct msm_iommu_dev - a single IOMMU hardware instance
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
