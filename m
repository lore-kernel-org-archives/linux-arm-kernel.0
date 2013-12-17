From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 18:08:54 +0000
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.14
Message-ID: <20131217180854.GG349@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg, Alex,

Please pull the arm-smmu updates below for 3.14. The main changes are adding
an IOMMU_EXEC flag to allow for non-executable mappings (in response to work
that rmk has done for the CPU-side of things) and automatically adding
devices to an IOMMU group.

Thanks,

Will

--->8

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to cf2d45b19ddb361241f36d8c9f3d0b234a18459b:

  iommu/arm-smmu: add support for IOMMU_EXEC (2013-12-16 19:30:32 +0000)

----------------------------------------------------------------
Antonios Motakis (1):
      iommu/arm-smmu: add devices attached to the SMMU to an IOMMU group

Will Deacon (3):
      iommu/arm-smmu: use VA_BITS to determine arm64 virtual address space
      iommu: add IOMMU_EXEC flag for safely allowing XN mappings
      iommu/arm-smmu: add support for IOMMU_EXEC

 drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
 include/linux/iommu.h    |  7 ++++---
 2 files changed, 30 insertions(+), 10 deletions(-)
