From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Jul 2015 14:57:42 +0100
Subject: [GIT PULL] iommu/arm-smmu: ARM SMMUv3 fixes for 4.2
Message-ID: <20150710135742.GA3341@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you pull these ARM SMMUv3 fixes for 4.2?
Thunder has done a good job of turning these around and they fix real
issues that he's seeing on his platform.

Thanks,

Will

--->8

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 5e92946c39ca6abc65e34775a93cc1d1a819c0e3:

  iommu/arm-smmu: Skip the execution of CMD_PREFETCH_CONFIG (2015-07-08 17:24:39 +0100)

----------------------------------------------------------------
Will Deacon (1):
      iommu/arm-smmu: Fix LOG2SIZE setting for 2-level stream tables

Zhen Lei (4):
      iommu/arm-smmu: Fix the index calculation of strtab
      iommu/arm-smmu: Fix the values of ARM64_TCR_{I,O}RGN0_SHIFT
      iommu/arm-smmu: Enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
      iommu/arm-smmu: Skip the execution of CMD_PREFETCH_CONFIG

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  3 ++
 drivers/iommu/arm-smmu-v3.c                        | 60 +++++++++++++++++-----
 2 files changed, 49 insertions(+), 14 deletions(-)
