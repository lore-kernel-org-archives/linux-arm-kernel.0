From: s-anna@ti.com (Suman Anna)
Date: Wed, 16 Sep 2015 18:48:18 -0500
Subject: [PATCH 0/4] Cleanup legacy OMAP IOMMU device creation
Message-ID: <1442447302-5246-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following series removes the legacy platform device creation
logic for OMAP IOMMU devices. I will cleanup the legacy support
from the OMAP IOMMU driver in a subsequent merge window after
this series makes it to mainline.

Patches are based on 4.3-rc1 + the OMAP3 ISP instantiation cleanup
patch [1]. All the patches need to be picked up sequentially,
otherwise a NULL pointer dereference crash might be seen on OMAP3
legacy boots as the dev attribute structure is deferenced directly
in mach-omap2/omap-iommu.c during platform data creation. Also, the
last patch removes the structure definition altogether, so will
cause build issues if picked separately from the hwmod cleanup
patches.

I do not have any boards where I can still perform a legacy-style
boot, so patches verified using DT-boot only.

regards
Suman

[1] https://patchwork.kernel.org/patch/6806891/

Suman Anna (4):
  ARM: OMAP2+: Remove legacy device instantiation of IOMMUs
  ARM: OMAP3: hwmod data: Remove legacy IOMMU data
  ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
  ARM: OMAP2+: Remove omap_mmu_dev_attr structure

 arch/arm/mach-omap2/omap-iommu.c           | 66 ------------------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 42 -------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 31 --------------
 include/linux/platform_data/iommu-omap.h   |  9 ----
 4 files changed, 148 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/omap-iommu.c

-- 
2.5.0
