From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 19 Nov 2010 19:02:32 -0800
Subject: [PATCH 1/3] msm: iommu: Add bus clocks to platform data
In-Reply-To: <1290222154-11096-1-git-send-email-stepanm@codeaurora.org>
References: <1290222154-11096-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1290222154-11096-2-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the IOMMU bus clock and the IOMMU bus interconnect
clocks to the platform data for an IOMMU device. These
clocks are needed to access the IOMMU registers.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
Please hold off on this until the clock driver is in.
 arch/arm/mach-msm/include/mach/iommu.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/iommu.h b/arch/arm/mach-msm/include/mach/iommu.h
index 296c0f1..62f6699 100644
--- a/arch/arm/mach-msm/include/mach/iommu.h
+++ b/arch/arm/mach-msm/include/mach/iommu.h
@@ -19,6 +19,7 @@
 #define MSM_IOMMU_H

 #include <linux/interrupt.h>
+#include <linux/clk.h>

 /* Sharability attributes of MSM IOMMU mappings */
 #define MSM_IOMMU_ATTR_NON_SH		0x0
@@ -74,13 +75,17 @@ struct msm_iommu_ctx_dev {
  * struct msm_iommu_drvdata - A single IOMMU hardware instance
  * @base:	IOMMU config port base address (VA)
  * @irq:	Interrupt number
-  *
+ * @clk:	The bus clock for this IOMMU hardware instance
+ * @pclk:	The clock for the IOMMU bus interconnect
+ *
  * A msm_iommu_drvdata holds the global driver data about a single piece
  * of an IOMMU hardware instance.
  */
 struct msm_iommu_drvdata {
 	void __iomem *base;
 	int irq;
+	struct clk *clk;
+	struct clk *pclk;
 };

 /**
--
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
