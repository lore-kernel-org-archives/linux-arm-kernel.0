From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jul 2016 16:59:46 +0100
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.8
Message-ID: <20160708155946.GG6493@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please pull these arm-smmu updates for 4.8. There's really not a lot
here, but the highlight is the fix to iova_to_phys which really improves
our VFIO teardown performance, where we previously did everything on a
page-by-page basis.

Whilst Robin had an SMMUv3 series in good shape for the default domain
stuff (and of_xlate binding), it's not quite ready for 4.8, so we'll
spend the extra time to get it in for 4.9.

Cheers,

Will

--->8

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to bee140044579fbfdad5fd98717c0405d7b492226:

  iommu/arm-smmu: Use devm_request_irq and devm_free_irq (2016-07-06 18:31:51 +0100)

----------------------------------------------------------------
Andrea Gelmini (1):
      iommu/arm-smmu: Fix typo in devicetree binding introductory text

Peng Fan (1):
      iommu/arm-smmu: Use devm_request_irq and devm_free_irq

Wei Chen (1):
      iommu/arm-smmu: request pcie devices to enable ACS

Will Deacon (1):
      iommu/io-pgtable-arm: Fix iova_to_phys for block entries

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  2 +-
 drivers/iommu/arm-smmu-v3.c                        |  2 ++
 drivers/iommu/arm-smmu.c                           | 28 ++++++++++------------
 drivers/iommu/io-pgtable-arm.c                     |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)
