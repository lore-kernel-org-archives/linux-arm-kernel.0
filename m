From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Jan 2015 13:54:12 +0000
Subject: [PATCH v2 0/5] Generic IOMMU page table framework
Message-ID: <1420811657-21321-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version two of the patch series I originally posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html

Changes since v1 include:

 - Separated 32-bit and 64-bit regimes
 - Limited pgd allocation when a full page is not required
 - Addition of NS quirk, needed by Laurent for the Renesas IOMMU
 - Added kerneldoc for the API to IOMMU drivers
 - A few minor changes after feedback on the list

All feedback welcome,

Will

--->8

Laurent Pinchart (1):
  iommu: io-pgtable-arm: add non-secure quirk

Will Deacon (4):
  iommu: introduce generic page table allocation framework
  iommu: add ARM LPAE page table allocator
  iommu: add self-consistency tests to ARM LPAE IO page table allocator
  iommu/arm-smmu: make use of generic LPAE allocator

 MAINTAINERS                    |   1 +
 arch/arm64/Kconfig             |   1 -
 drivers/iommu/Kconfig          |  32 +-
 drivers/iommu/Makefile         |   2 +
 drivers/iommu/arm-smmu.c       | 886 +++++++++++-------------------------
 drivers/iommu/io-pgtable-arm.c | 986 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  82 ++++
 drivers/iommu/io-pgtable.h     | 143 ++++++
 8 files changed, 1506 insertions(+), 627 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.c
 create mode 100644 drivers/iommu/io-pgtable.c
 create mode 100644 drivers/iommu/io-pgtable.h

-- 
2.1.4
