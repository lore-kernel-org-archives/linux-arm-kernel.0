From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Oct 2017 17:11:54 +0100
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.15
Message-ID: <20171020161154.GA7287@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull these ARM SMMU updates for 4.15. The main improvement here is
that we now drop the command queue lock when waiting for a CMD_SYNC to
complete on implementations that support MSIs into cacheable memory.
There are also some minor fixes and cleanups.

Cheers,

Will

--->8

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 8ff0f72371709889349a706e19bb38d9f71b1669:

  iommu/arm-smmu-v3: Use burst-polling for sync completion (2017-10-20 16:55:10 +0100)

----------------------------------------------------------------
Feng Kan (1):
      iommu/arm-smmu: Enable bypass transaction caching for ARM SMMU 500

Robin Murphy (6):
      iommu/arm-smmu: Remove ACPICA workarounds
      iommu/arm-smmu-v3: Correct COHACC override message
      iommu/arm-smmu-v3: Specialise CMD_SYNC handling
      iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
      iommu/arm-smmu-v3: Use CMD_SYNC completion MSI
      iommu/arm-smmu-v3: Use burst-polling for sync completion

Will Deacon (3):
      iommu/arm-smmu-v3: Ensure we sync STE when only changing config field
      iommu/arm-smmu-v3: Split arm_smmu_cmdq_issue_sync in half
      iommu/arm-smmu-v3: Consolidate identical timeouts

Yisheng Xie (1):
      iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD and CD.S

 drivers/iommu/arm-smmu-v3.c | 204 ++++++++++++++++++++++++++++++--------------
 drivers/iommu/arm-smmu.c    |  11 +--
 2 files changed, 141 insertions(+), 74 deletions(-)
