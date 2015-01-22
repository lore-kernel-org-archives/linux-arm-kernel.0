From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Jan 2015 16:25:23 +0000
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.20
Message-ID: <20150122162523.GE20826@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull the following ARM SMMU updates for 3.20. The bulk of the
changes are due to the introduction of a generic page table framework
for IOMMUs along with an ARM LPAE backend. I've moved the ARM SMMU
driver over to this and Laurent has a patch to do the same for the
IPMMU. There's also the MMIO polling macros for iopoll.h, which have
been acked by Arnd.

I've not included Laurent's patch here, as it depends on some other
IPMMU changes that you already have queued.

Cheers,

Will

--->8

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 859a732e4f713270152c78df6e09accbde006734:

  iommu/arm-smmu: add support for iova_to_phys through ATS1PR (2015-01-19 18:18:38 +0000)

----------------------------------------------------------------
Laurent Pinchart (1):
      iommu: io-pgtable-arm: add non-secure quirk

Matt Wagantall (1):
      iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (2):
      iommu/arm-smmu: don't touch the secure STLBIALL register
      iommu/arm-smmu: add support for iova_to_phys through ATS1PR

Will Deacon (4):
      iommu: introduce generic page table allocation framework
      iommu: add ARM LPAE page table allocator
      iommu: add self-consistency tests to ARM LPAE IO page table allocator
      iommu/arm-smmu: make use of generic LPAE allocator

 MAINTAINERS                    |   1 +
 arch/arm64/Kconfig             |   1 -
 drivers/iommu/Kconfig          |  32 +-
 drivers/iommu/Makefile         |   2 +
 drivers/iommu/arm-smmu.c       | 935 +++++++++++++-------------------------
 drivers/iommu/io-pgtable-arm.c | 986 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  82 ++++
 drivers/iommu/io-pgtable.h     | 143 ++++++
 include/linux/iopoll.h         | 144 ++++++
 9 files changed, 1706 insertions(+), 620 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.c
 create mode 100644 drivers/iommu/io-pgtable.c
 create mode 100644 drivers/iommu/io-pgtable.h
 create mode 100644 include/linux/iopoll.h
