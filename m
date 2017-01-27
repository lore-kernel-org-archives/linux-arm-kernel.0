From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2017 16:46:21 +0000
Subject: [GIT PULL] iommu: IOMMU_PRIV support for 4.11
Message-ID: <20170127164621.GB10758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull the following IOMMU changes for 4.11. These patches from
Sricharan add support for "privileged" IOMMU mappings, which are useful
with master devices that support transactions at different privilege
levels and want to control the permissions independently.

Cheers,

Will

--->8

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git iommu/iommu-priv

for you to fetch changes up to fa8c57db44068a77903d9688382b461a836eee68:

  iommu: Better document the IOMMU_PRIV flag (2017-01-27 13:49:35 +0000)

----------------------------------------------------------------
Jeremy Gebben (1):
      iommu/io-pgtable-arm: add support for the IOMMU_PRIV flag

Mitchel Humpherys (4):
      iommu: add IOMMU_PRIV attribute
      common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
      arm64/dma-mapping: Implement DMA_ATTR_PRIVILEGED
      dmaengine: pl330: Make sure microcode is privileged

Robin Murphy (3):
      iommu/io-pgtable-arm-v7s: Add support for the IOMMU_PRIV flag
      Revert "iommu/arm-smmu: Set PRIVCFG in stage 1 STEs"
      iommu: Better document the IOMMU_PRIV flag

Sricharan R (2):
      arm/dma-mapping: Implement DMA_ATTR_PRIVILEGED
      iommu/arm-smmu: Set privileged attribute to 'default' instead of 'unprivileged'

 Documentation/DMA-attributes.txt   | 10 +++++++
 arch/arm/mm/dma-mapping.c          | 60 +++++++++++++++++++-------------------
 arch/arm64/mm/dma-mapping.c        |  6 ++--
 drivers/dma/pl330.c                |  5 ++--
 drivers/iommu/arm-smmu-v3.c        |  7 +----
 drivers/iommu/arm-smmu.c           |  2 +-
 drivers/iommu/dma-iommu.c          | 12 ++++++--
 drivers/iommu/io-pgtable-arm-v7s.c |  6 +++-
 drivers/iommu/io-pgtable-arm.c     |  5 +++-
 include/linux/dma-iommu.h          |  3 +-
 include/linux/dma-mapping.h        |  7 +++++
 include/linux/iommu.h              | 10 +++++++
 12 files changed, 85 insertions(+), 48 deletions(-)
