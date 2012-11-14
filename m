From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 13 Nov 2012 20:34:47 -0600
Subject: [PATCH v4 0/2] OMAP: iommu: hwmod, reset handling and runtime PM
Message-ID: <1352860489-19960-1-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are needed for remoteproc to work on OMAP4.

Introduced iommu hwmod support for OMAP3 (iva, isp) and
OMAP4 (ipu, dsp), along with the corresponding runtime PM
and routines to deassert reset lines, enable/disable clocks
and configure sysc registers.

For this series I dropped the patches already included in
mainline, along with cleanup and refactoring patches for save and
restore of mmu context, and DT bindings.

Due to single Image support, I rebased these on top of k3.7-rc5 and
DEPEND on:

[PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
http://thread.gmane.org/gmane.linux.kernel/1387788

Minor rebasing might be needed if these are included on top of
linux-omap, since they are affected by changes on headers being
moved to include/linux/platform_data and arch/arm/mach-omap2.

Omar Ramirez Luna (2):
  ARM: OMAP3/4: iommu: migrate to hwmod framework
  ARM: OMAP3/4: iommu: adapt to runtime pm

 arch/arm/mach-omap2/devices.c            |    2 +-
 arch/arm/mach-omap2/omap-iommu.c         |  167 +++++++-----------------------
 drivers/iommu/omap-iommu.c               |   68 +++++++------
 drivers/iommu/omap-iommu.h               |    3 -
 drivers/iommu/omap-iommu2.c              |   36 -------
 include/linux/platform_data/iommu-omap.h |    9 ++-
 6 files changed, 82 insertions(+), 203 deletions(-)

-- 
1.7.4.1
