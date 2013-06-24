From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jun 2013 18:31:23 +0100
Subject: [PATCH v2 0/3] Add support for ARM SMMU architectures 1 and 2
Message-ID: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is version 2 of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175128.html

Changes since v1 include:
  - Dropped the first six preparatory patches, since they've been picked
    up by their respective trees.
  - Fixed arm_smmu_devices list locking and removed unnecessary use of
    _safe list iterators
  - Added calculation of compound output mask to domain initialisation,
    rather than iterate up the SMMU chain during the ->map fast path
  - Added timeout to TLB invalidation loop
  - Expanded comment about non-coherent table walking
  - Renamed arm_smmu_create_mapping to arm_smmu_handle_mapping

Thanks to everybody who was reviewed the patches so far!

All comments welcome,

Will

Will Deacon (3):
  documentation: iommu: add description of ARM System MMU binding
  iommu: add support for ARM Ltd. System MMU architecture
  MAINTAINERS: add entry for ARM system MMU driver

 .../devicetree/bindings/iommu/arm,smmu.txt         |   70 +
 MAINTAINERS                                        |    6 +
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/arm-smmu.c                           | 1969 ++++++++++++++++++++
 5 files changed, 2059 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
 create mode 100644 drivers/iommu/arm-smmu.c

-- 
1.8.2.2
