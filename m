From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Oct 2012 17:36:30 -0700
Subject: [PATCH 0/4] repost of the omap iommu header changes to remove plat
 includes
Message-ID: <20121016003513.19701.71718.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks like Joerg was not cc:d in the original series, so I'm reposting
these updated against v3.7-rc1.

Regards,

Tony

---

Ido Yariv (4):
      ARM: OMAP: Merge iommu2.h into iommu.h
      ARM: OMAP2+: Make some definitions local
      ARM: OMAP2+: Move iommu/iovmm headers to platform_data
      ARM: OMAP2+: Move iopgtable header to drivers/iommu/


 arch/arm/mach-omap2/devices.c               |    2 
 arch/arm/mach-omap2/iommu2.c                |    8 ++
 arch/arm/mach-omap2/omap-iommu.c            |    2 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  |    2 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    2 
 arch/arm/plat-omap/include/plat/iommu2.h    |   96 -----------------------
 drivers/iommu/omap-iommu-debug.c            |    7 +-
 drivers/iommu/omap-iommu.c                  |    5 +
 drivers/iommu/omap-iommu.h                  |   59 ++++++++++++++
 drivers/iommu/omap-iopgtable.h              |    0 
 drivers/iommu/omap-iovmm.c                  |    7 +-
 drivers/media/platform/omap3isp/isp.h       |    5 +
 drivers/media/platform/omap3isp/ispvideo.c  |    5 -
 include/linux/platform_data/iommu-omap.h    |  115 ++++++++++++++++-----------
 include/linux/platform_data/iovmm-omap.h    |    0 
 15 files changed, 155 insertions(+), 160 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/iommu2.h
 create mode 100644 drivers/iommu/omap-iommu.h
 rename arch/arm/plat-omap/include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h (100%)
 rename arch/arm/plat-omap/include/plat/iommu.h => include/linux/platform_data/iommu-omap.h (69%)
 rename arch/arm/plat-omap/include/plat/iovmm.h => include/linux/platform_data/iovmm-omap.h (100%)

-- 
Signature
