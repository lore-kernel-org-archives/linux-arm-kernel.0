From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jul 2014 11:33:47 +0100
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.17
Message-ID: <20140710103347.GJ2449@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you pull the following ARM SMMU updates for 3.17?

The main changes are:

 - Removal of unused SMMU chaining code
 - Initial support for PCI masters
 - Misc. non-critical fixes to the capability checking code and TCR
   configuration

This has largely come out of work enabling passthrough of PCI devices
to a KVM virtual machine with VFIO, so I anticipate further patches in
this area in the near future.

Cheers,

Will

Cc: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Mitchel Humpherys <mitchelh@codeaurora.org> 

--->8

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 2907320df3189420cb66178a86b2917f4b64018f:

  iommu/arm-smmu: fix some checkpatch issues (2014-07-09 10:38:23 +0100)

----------------------------------------------------------------
Mitchel Humpherys (1):
      iommu/arm-smmu: fix some checkpatch issues

Will Deacon (6):
      iommu/arm-smmu: fix calculation of TCR.T0SZ
      iommu/arm-smmu: add support for PCI master devices
      iommu/arm-smmu: caps: add IOMMU_CAP_INTR_REMAP capability
      iommu/arm-smmu: remove support for chained SMMUs
      iommu/arm-smmu: prefer stage-1 mappings where we have a choice
      iommu/arm-smmu: fix capability checking prior to device attach

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 -
 drivers/iommu/arm-smmu.c                           | 493 ++++++++++-----------
 2 files changed, 240 insertions(+), 259 deletions(-)
