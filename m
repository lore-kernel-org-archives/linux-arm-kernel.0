From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Mon, 28 Feb 2011 16:04:56 -0800
Subject: [PATCH 2/2] msm: iommu: Enable HTW L2 redirection on MSM8960
In-Reply-To: <1298937896-29324-1-git-send-email-stepanm@codeaurora.org>
References: <1298937896-29324-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1298937896-29324-2-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the MSM8960 IOMMU to access its page tables directly
through the L2 cache.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 997c5bd..1516896 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -162,7 +162,7 @@ config MSM_IOMMU

 config IOMMU_PGTABLES_L2
 	def_bool y
-	depends on ARCH_MSM8X60 && MMU && SMP && CPU_DCACHE_DISABLE=n
+	depends on MSM_IOMMU && MMU && SMP && CPU_DCACHE_DISABLE=n

 config MSM_DEBUG_UART
 	int
--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
