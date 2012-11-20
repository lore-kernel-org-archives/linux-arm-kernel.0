From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Mon, 19 Nov 2012 19:05:47 -0600
Subject: [PATCH v5 0/5] OMAP: iommu: hwmod, reset handling and runtime PM
Message-ID: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are needed for remoteproc to work on OMAP4.

Introduced iommu hwmod support for OMAP3 (iva, isp) and
OMAP4 (ipu, dsp), along with the corresponding runtime PM
and routines to deassert reset lines, enable/disable clocks
and configure sysc registers.

A couple of patches were added (first two) to be clearer on
the reasons for such changes, they were previosuly bundled as part
of runtime PM changes. The last patch corresponds to a change in the
leaf clocks used and it depends on this series to work properly.

Due to single Image support, I rebased these on top of k3.7-rc5 and
DEPEND on:

[PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
http://thread.gmane.org/gmane.linux.kernel/1387788

Minor rebasing might be needed if these are included on top of
linux-omap, since they are affected by changes on headers being
moved to include/linux/platform_data and arch/arm/mach-omap2.

Omar Ramirez Luna (5):
  iommu/omap: remove redundant clock handling on ISR
  iommu/omap: keep mmu enabled when requested
  iommu/omap: migrate to hwmod framework
  iommu/omap: adapt to runtime pm
  ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks instead of
    leaf clocks

 arch/arm/mach-omap2/clock44xx_data.c       |   22 ----
 arch/arm/mach-omap2/devices.c              |    2 +-
 arch/arm/mach-omap2/omap-iommu.c           |  167 ++++++---------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +-
 drivers/iommu/omap-iommu.c                 |   68 ++++++-----
 drivers/iommu/omap-iommu.h                 |    3 -
 drivers/iommu/omap-iommu2.c                |   36 ------
 include/linux/platform_data/iommu-omap.h   |    9 +-
 8 files changed, 84 insertions(+), 227 deletions(-)

-- 
1.7.4.1
