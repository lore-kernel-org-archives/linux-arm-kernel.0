From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Wed, 4 Jun 2014 13:41:45 +0530
Subject: [PATCH 0/1] device.h: Move out arch independent dma_iommu_mapping
 struct
Message-ID: <1401869506-48129-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

There has been various ongoing discussions on making arm iommu's dma-mapping
stuff to be common code which is arch independent[1].
Current users of this code will be arm and arm64, but later other archs
can start utilizing this as well.

Based on these discussion there has been work going on to refactor common
arch independent code of arm iommu's dma-mapping to lib/iommu-helper.c [2].

Since now dma_iommu_mapping stuff will be arch independent, so it make sense
to move out struct dma_iommu_mapping *mapping variable from arch/arm/*/device.h 
to include/linux/device.h as a first step [3].
Also, to move out complete structure definition of dma_iommu_mapping 
to include/linux/iommu-helper.h


Links:
[1]: https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg03458.html
[2]: http://www.spinics.net/lists/arm-kernel/msg336343.html
[3]: http://www.spinics.net/lists/arm-kernel/msg336682.html

Ritesh Harjani (1):
  device.h: arm,dma-iommu: Move out dma_iommu_mapping struct

 arch/arm/Kconfig                          |  4 ++++
 arch/arm/include/asm/device.h             |  9 ---------
 arch/arm/include/asm/dma-iommu.h          | 16 +---------------
 arch/arm/mm/dma-mapping.c                 | 20 ++++++++++----------
 drivers/gpu/drm/exynos/exynos_drm_iommu.c | 10 +++++-----
 include/linux/device.h                    |  4 ++++
 include/linux/iommu-helper.h              | 22 ++++++++++++++++++++++
 7 files changed, 46 insertions(+), 39 deletions(-)

-- 
1.8.1.3
