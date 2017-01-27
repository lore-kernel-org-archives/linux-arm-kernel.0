From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2017 16:44:21 +0000
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.11
Message-ID: <20170127164420.GA10758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull these arm-smmu updates for 4.11. Not much this time around:
16-bit SID support on SMMUv2 and a stream table optimisation on SMMUv3.
There's also a trivial cleanup to of_iommu_{set/get}_ops() [they are
removed] which we promised to make after the IORT stuff went in last
time around.

Thanks,

Will

--->8

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 3677a649a751c8f061ba379a98c369473ccac980:

  iommu/arm-smmu: Fix for ThunderX erratum #27704 (2017-01-26 18:16:58 +0000)

----------------------------------------------------------------
Aleksey Makarov (1):
      iommu/arm-smmu: Support for Extended Stream ID (16 bit)

Lorenzo Pieralisi (1):
      iommu: Drop the of_iommu_{set/get}_ops() interface

Nate Watterson (2):
      iommu/arm-smmu-v3: Clear prior settings when updating STEs
      iommu/arm-smmu-v3: limit use of 2-level stream tables

Tomasz Nowicki (1):
      iommu/arm-smmu: Fix for ThunderX erratum #27704

 drivers/iommu/arm-smmu-v3.c  | 31 ++++++++-----------
 drivers/iommu/arm-smmu.c     | 72 +++++++++++++++++++++++++++++++-------------
 drivers/iommu/exynos-iommu.c |  2 +-
 drivers/iommu/msm_iommu.c    |  2 +-
 drivers/iommu/mtk_iommu.c    |  2 +-
 drivers/iommu/of_iommu.c     |  4 +--
 include/linux/of_iommu.h     | 11 -------
 7 files changed, 68 insertions(+), 56 deletions(-)
