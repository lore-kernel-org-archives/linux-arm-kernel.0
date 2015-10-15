From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 17:16:22 +0100
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.4
Message-ID: <20151015161622.GI29301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

I'm sending this pull request now because I'm away next week, but here
are the arm-smmu updates I have for 4.4

Changes include:

  * MSI support for the SMMUv3 driver
  * Removal of the smmu_devices list from the SMMUv3 driver
  * Workaround for an SMMUv3  hardware issue on Cavium ThunderX
  * Some minor fixes and cleanups

Please pull,

Will

--->8

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 166bdbd23161160f2abcea70621adba179050bee:

  iommu/arm-smmu: Add support for MSI on SMMUv3 (2015-10-15 16:29:58 +0100)

----------------------------------------------------------------
Fabio Estevam (1):
      iommu/arm-smmu: Remove unneeded '0x' annotation

Marc Zyngier (1):
      iommu/arm-smmu: Add support for MSI on SMMUv3

Tirumalesh Chalamarla (1):
      iommu/arm-smmu: ThunderX mis-extends 64bit registers

Will Deacon (3):
      iommu/arm-smmu: Use drvdata instead of maintaining smmu_devices list
      iommu/arm-smmu: Fix error checking for ASID and VMID allocation
      iommu/arm-smmu: Remove redundant calculation of gr0 base address

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  19 +++
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/arm-smmu-v3.c                        | 154 +++++++++++++++------
 drivers/iommu/arm-smmu.c                           |  55 ++++----
 4 files changed, 159 insertions(+), 70 deletions(-)
