From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 18:25:48 +0100
Subject: [PATCH/WIP/RFC 02/14] shmobile-iommu: Move IPMMU driver to
 drivers/iommu
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1355678760-27357-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/Kconfig                     |    6 ------
 arch/arm/mach-shmobile/Makefile                    |    3 ---
 drivers/iommu/Kconfig                              |    6 ++++++
 drivers/iommu/Makefile                             |    1 +
 .../ipmmu.c => drivers/iommu/shmobile-ipmmu.c      |    0
 5 files changed, 7 insertions(+), 9 deletions(-)
 rename arch/arm/mach-shmobile/ipmmu.c => drivers/iommu/shmobile-ipmmu.c (100%)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index de69ab3..8ae100c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -210,12 +210,6 @@ endmenu
 config SH_CLK_CPG
 	bool
 
-config SHMOBILE_IPMMU
-	bool
-
-config SHMOBILE_IPMMU_TLB
-	bool
-
 source "drivers/sh/Kconfig"
 
 endif
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 4ffba9d..fe2c97c 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -60,6 +60,3 @@ obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
 obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
-
-# IPMMU/IPMMUI
-obj-$(CONFIG_SHMOBILE_IPMMU)	+= ipmmu.o
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 265829f..cb2a3e8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -187,6 +187,12 @@ config EXYNOS_IOMMU_DEBUG
 
 	  Say N unless you need kernel log message for IOMMU debugging
 
+config SHMOBILE_IPMMU
+	bool
+
+config SHMOBILE_IPMMU_TLB
+	bool
+
 config SHMOBILE_IOMMU
 	bool "IOMMU for Renesas IPMMU/IPMMUI"
 	default n
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 62cf917..e65384f 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
 obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
+obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
diff --git a/arch/arm/mach-shmobile/ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
similarity index 100%
rename from arch/arm/mach-shmobile/ipmmu.c
rename to drivers/iommu/shmobile-ipmmu.c
-- 
1.7.8.6
