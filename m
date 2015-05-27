From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 May 2015 17:26:00 +0100
Subject: [PATCH v2 3/3] drivers/vfio: Allow type-1 IOMMU instantiation on top
 of an ARM SMMUv3
In-Reply-To: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
References: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
Message-ID: <1432743960-25205-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMUv3 driver is compatible with the notion of a type-1 IOMMU in
VFIO.

This patch allows VFIO_IOMMU_TYPE1 to be selected if ARM_SMMU_V3=y.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 7d092ddc8119..454017928ed0 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -21,7 +21,7 @@ config VFIO_VIRQFD
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
-	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU)
+	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
 	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
 	select VFIO_SPAPR_EEH if (PPC_POWERNV || PPC_PSERIES)
 	select ANON_INODES
-- 
2.1.4
