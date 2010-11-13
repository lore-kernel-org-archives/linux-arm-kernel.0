From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:46 -0800
Subject: [PATCH 00/14] Improvements to the MSM IOMMU driver
Message-ID: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update IOMMU M2VCBMT assignments based on new analysis, add
support for the IOMMU for the second 2D graphics core,
improve performance under certain situations, add support
for cache-coherent operations, and generally clean up the
code.

Stepan Moskovchenko (14):
  msm: iommu: Increase maximum MID size to 5 bits
  msm: iomap: Addresses and IRQs for 2nd GFX core IOMMU
  msm: iommu: Use more consistent naming in platform data
  msm: iommu: Revise GFX3D IOMMU contexts and M2V mappings
  msm: iommu: Revise GFX2D0 IOMMU contexts and M2V mappings
  msm: iommu: Support for the 2nd gfx core's IOMMU
  msm: iommu: Mark functions with the right section names
  msm: iommu: Don't flush page tables if no devices attached
  msm: iommu: Kconfig option for cacheable page tables
  msm: iommu: Check if device is already attached
  msm: iommu: Kconfig dependency for the IOMMU API
  msm: iommu: Definitions for extended memory attributes
  msm: iommu: Support cache-coherent memory access
  msm: iommu: Miscellaneous code cleanup

 arch/arm/mach-msm/Kconfig                       |   19 ++
 arch/arm/mach-msm/devices-msm8x60-iommu.c       |  243 +++++++++++++----------
 arch/arm/mach-msm/include/mach/iommu.h          |   13 ++-
 arch/arm/mach-msm/include/mach/iommu_hw-8xxx.h  |   22 ++-
 arch/arm/mach-msm/include/mach/irqs-8x60.h      |    7 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    3 +
 arch/arm/mach-msm/iommu.c                       |  144 +++++++++++---
 arch/arm/mach-msm/iommu_dev.c                   |    4 +-
 8 files changed, 310 insertions(+), 145 deletions(-)

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
