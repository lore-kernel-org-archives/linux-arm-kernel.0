From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Mar 2015 17:21:46 +0000
Subject: [GIT PULL] iommu/arm-smmu: updates for 4.1
Message-ID: <20150327172146.GM1562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull the following ARM SMMU updates for 4.1. The biggest change
here is proper support for PCI DMA aliases (tested on real hardware) but
there are a handful of minor (non-regression) fixes too.

Will

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 63979b8da30013ce58d8447f34dde60802d1ccba:

  iommu/io-pgtable-arm: avoid speculative walks through TTBR1 (2015-03-27 13:39:36 +0000)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/arm-smmu: set a more appropriate DMA mask

Will Deacon (3):
      iommu/arm-smmu: ensure CBA2R is initialised before CBAR on SMMUv2
      iommu/arm-smmu: handle multi-alias IOMMU groups for PCI devices
      iommu/io-pgtable-arm: avoid speculative walks through TTBR1

 drivers/iommu/arm-smmu.c       | 125 ++++++++++++++++++++++++++---------------
 drivers/iommu/io-pgtable-arm.c |   5 ++
 2 files changed, 85 insertions(+), 45 deletions(-)
