From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:48 -0800
Subject: [PATCH 02/14] msm: iomap: Addresses and IRQs for 2nd GFX core IOMMU
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-3-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add register addresses and IRQ numbers for the IOMMU used
for the second 2D graphics core.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/irqs-8x60.h      |    7 ++++++-
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    3 +++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/irqs-8x60.h b/arch/arm/mach-msm/include/mach/irqs-8x60.h
index 36074cf..f65841c 100644
--- a/arch/arm/mach-msm/include/mach/irqs-8x60.h
+++ b/arch/arm/mach-msm/include/mach/irqs-8x60.h
@@ -237,7 +237,12 @@
 #define GSBI11_QUP_IRQ				(GIC_SPI_START + 194)
 #define INT_UART12DM_IRQ			(GIC_SPI_START + 195)
 #define GSBI12_QUP_IRQ				(GIC_SPI_START + 196)
-/*SPI 197 to 216 arent used in 8x60*/
+
+/*SPI 197 to 209 arent used in 8x60*/
+#define SMMU_GFX2D1_CB_SC_SECURE_IRQ            (GIC_SPI_START + 210)
+#define SMMU_GFX2D1_CB_SC_NON_SECURE_IRQ        (GIC_SPI_START + 211)
+
+/*SPI 212 to 216 arent used in 8x60*/
 #define SMPSS_SPARE_1				(GIC_SPI_START + 217)
 #define SMPSS_SPARE_2				(GIC_SPI_START + 218)
 #define SMPSS_SPARE_3				(GIC_SPI_START + 219)
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
index 45bab50..7c43a9b 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
@@ -98,4 +98,7 @@
 #define MSM_IOMMU_GFX2D0_PHYS	0x07D00000
 #define MSM_IOMMU_GFX2D0_SIZE	SZ_1M
 
+#define MSM_IOMMU_GFX2D1_PHYS	0x07E00000
+#define MSM_IOMMU_GFX2D1_SIZE	SZ_1M
+
 #endif
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
