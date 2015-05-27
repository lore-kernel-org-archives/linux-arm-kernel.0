From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 May 2015 17:25:57 +0100
Subject: [PATCH v2 0/3] iommu/arm=smmu: Add driver for ARM SMMUv3 devices
Message-ID: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches I originally posted here:

  http://www.spinics.net/lists/arm-kernel/msg416881.html

Changes since version one include:

  - Lazy allocation of the level-2 stream table on device-add
  - Limit stream table size based on SIDSIZE (maximum 21-bit atm)
  - Fixed detection of linear stream table
  - Fixed typo in RECINVSID CR2 field
  - Added cmdline option for changing default bypass behaviour to fault
  - Check IDR0.HYP before EL2 TLBI
  - Reworked stream table so that each level-2 entry resolves 256 SIDs
    (i.e. a PCI bus)

All feedback welcome,

Will

--->8

Will Deacon (3):
  Documentation: dt-bindings: Add device-tree binding for ARM SMMUv3
    IOMMU
  iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices
  drivers/vfio: Allow type-1 IOMMU instantiation on top of an ARM SMMUv3

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   37 +
 MAINTAINERS                                        |    3 +-
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/arm-smmu-v3.c                        | 2670 ++++++++++++++++++++
 drivers/vfio/Kconfig                               |    2 +-
 6 files changed, 2724 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 drivers/iommu/arm-smmu-v3.c

-- 
2.1.4
