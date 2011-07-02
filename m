From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 02 Jul 2011 02:44:44 -0600
Subject: [PATCH 0/7] OMAP: hwmod: consolidate duplicate data across
	OMAP2xxx/3xxx files
Message-ID: <20110702084348.582.65635.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series combines some duplicate omap_hwmod data across the OMAP2420,
OMAP2430, and OMAP3 data files.  The intention here is to reduce the amount
of kernel source code in arch/arm/mach-omap2/, although there is also a small
kernel size reduction.

Further cleanup and reorganization is forthcoming in later series; this is
simply the first round.

Boot-tested on OMAP4430 ES2 PandaBoard and OMAP3530 BeagleBoard.


- Paul

---

Paul Walmsley (7):
      omap_hwmod: use a null structure record to terminate omap_hwmod_addr_space arrays
      omap_hwmod: share identical omap_hwmod_addr_space arrays
      omap_hwmod: use a terminator record with omap_hwmod_mpu_irqs arrays
      omap_hwmod: share identical omap_hwmod_mpu_irqs arrays
      omap_hwmod: use a terminator record with omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_dma_info arrays
      omap_hwmod: share identical omap_hwmod_class, omap_hwmod_class_sysconfig arrays


 arch/arm/mach-omap2/Makefile                       |   16 
 arch/arm/mach-omap2/omap_hwmod.c                   |  101 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  832 ++----------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  910 +++-----------------
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  173 ++++
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  322 +++++++
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  130 +++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  150 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  654 +++-----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  357 ++++----
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |   20 
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   93 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   18 
 13 files changed, 1508 insertions(+), 2268 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
