From: will.deacon@arm.com (Will Deacon)
Date: Mon,  1 Dec 2014 16:57:06 +0000
Subject: [PATCH v6 0/8] Introduce automatic DMA configuration for IOMMU masters
Message-ID: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is version 6 of the patches previously posted here:

  RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
  RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
  RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
  RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html
     v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307213.html

The only change since v5 is the addition of acks from various maintainers.

Now that the ARM bits have rmk's ack and the IOMMU bits have joro's ack,
I think this is good for merging via the arm-soc tree.

Please let me know if a pull request would be preferable.

Cheers,

Will

--->8

Marek Szyprowski (1):
  iommu: fix initialization without 'add_device' callback

Will Deacon (7):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding an OF device
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/kernel/setup.c            |  2 +
 arch/arm/mm/dma-mapping.c          | 83 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/iommu.c              |  2 +-
 drivers/iommu/of_iommu.c           | 50 +++++++++++++++++++++++
 drivers/of/platform.c              | 50 ++++++++++++-----------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/dma-mapping.h        | 13 +++---
 include/linux/iommu.h              |  8 ++++
 include/linux/of_iommu.h           | 31 ++++++++++++++
 11 files changed, 211 insertions(+), 44 deletions(-)

-- 
2.1.1
