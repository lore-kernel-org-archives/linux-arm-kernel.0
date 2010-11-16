From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Mon, 15 Nov 2010 17:46:10 -0800
Subject: [PATCH 09/14 v2] msm: iommu: Kconfig item for cacheable page tables
In-Reply-To: <1289619000-13167-10-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-10-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289871970-18393-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig item to allow the IOMMU page tables to be
coherent in the L2 cache. This generally reduces IOTLB miss
latencies and has been shown to improve multimedia
performance.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index dbbcfeb..1c6f76b 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -122,6 +122,10 @@ config MACH_MSM8X60_FFA

 endmenu

+config IOMMU_PGTABLES_L2
+	def_bool y
+	depends on ARCH_MSM8X60 && MMU && SMP && CPU_DCACHE_DISABLE=n
+
 config MSM_DEBUG_UART
 	int
 	default 1 if MSM_DEBUG_UART1
--
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
