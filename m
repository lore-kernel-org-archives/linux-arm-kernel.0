From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Tue,  6 Mar 2018 10:29:23 +0530
Subject: [RFC 0/5] DT property to reserve IOMMU regions
Message-ID: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SoCs need a way to reserve IOMMU regions. Some address ranges used 
by devices sitting behind IOMMU are treated specially. To prevent these
ranges from getting mapped in IOVA space, use the existing framework and
code to reserve the ranges using DT properties.

This patch set is created against 4.15-rc7.

Jitendra Bhivare (5):
  dt-bindings: iommu: Add reserved-dma-region for IOMMU device
  dt-bindings: brcm: Add reserved-dma-region for iPROC
  dt-bindings: arm-smmu: Add reserved-msi-region
  iommu/of: Reserve IOMMU DMA regions using DT
  iommu/arm-smmu: Allow direct mapping for MSI region

 .../devicetree/bindings/iommu/arm,smmu.txt         |  12 +++
 Documentation/devicetree/bindings/iommu/iommu.txt  |  17 ++++
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |   3 +
 drivers/iommu/arm-smmu.c                           |  14 ++-
 drivers/iommu/dma-iommu.c                          |   6 ++
 drivers/iommu/of_iommu.c                           | 100 +++++++++++----------
 include/linux/iommu.h                              |   3 +
 include/linux/of_iommu.h                           |  25 ++++--
 8 files changed, 126 insertions(+), 54 deletions(-)

-- 
2.7.4
