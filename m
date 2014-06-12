From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 12 Jun 2014 17:15:21 +0530
Subject: [PATCH V2 0/2] ARM: OMAP2+: remove DMA interrupt if DT provided
Message-ID: <1402573523-13814-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series removes the DMA interrupt registration if DT provides interrupts,
so we have no need for hwmod provided interrupt number.

This is a pre-req for crossbar migration as DMA is the last driver to use
interrupt definition from hwmod.

[V2] Rebased on 3.15 mainline

Nishanth Menon (2):
  ARM: OMAP2+: DMA: remove requirement of irq for platform-dma driver
  ARM: DRA7: hwmod: remove interrupts for DMA

 arch/arm/mach-omap2/dma.c                 |    3 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    9 ---------
 arch/arm/plat-omap/dma.c                  |    5 +++--
 include/linux/omap-dma.h                  |    1 +
 4 files changed, 7 insertions(+), 11 deletions(-)

-- 
1.7.9.5
