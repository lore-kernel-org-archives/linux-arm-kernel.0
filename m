From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 20 Feb 2014 16:20:32 +0000
Subject: [PATCH 0/2] Avoid to use Xen DMA ops when the device is protected by
 an IOMMU
Message-ID: <1392913234-25429-1-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all

This small patch series allows Xen guest to be used when Xen is programming
the IOMMUs.

For this purpose, I have added a new optional property "protected-devices" which
list the devices protected by an IOMMU.

The first patch create a new helper which will contain Xen specific check
to know if we might need to use swiotlb-xen. The second patch is implementing
the goal of this patch series.

Regards,

Julien Grall (2):
  arm/xen: Introduce need_xen_dma_ops and use it in get_dma_ops
  arm/xen: Don't use xen DMA ops when the device is protected by an
    IOMMU

 Documentation/devicetree/bindings/arm/xen.txt |    2 +
 arch/arm/include/asm/dma-mapping.h            |    5 +-
 arch/arm/include/asm/xen/dma-mapping.h        |   22 ++++++++
 arch/arm/include/asm/xen/hypervisor.h         |    2 -
 arch/arm/xen/enlighten.c                      |   75 +++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/xen/dma-mapping.h

-- 
1.7.10.4
