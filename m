From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Mar 2016 15:01:19 -0800
Subject: [GIT PULL 2/4] omap soc changes for v4.6 merge window
In-Reply-To: <pull-1456872971-400983>
References: <pull-1456872971-400983>
Message-ID: <pull-1456872971-400983-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8fe097a3d99e22355fb8e3bcee59542bf3f46b2d:

  ARM: DRA7: hwmod: Add reset data for PCIe (2016-02-09 02:18:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/soc-signed

for you to fetch changes up to e80499190db2fd752a60468f0fa462f87f993d49:

  Merge tag 'for-v4.6/omap-hwmod-b' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.6/soc (2016-03-01 09:59:38 -0800)

----------------------------------------------------------------
SoC related changes for omaps for v4.6 merge window:

- Enable runtime revision detection for dra7 to avoid multiple dts
  files for various variants

- Add dma_slave_map for omap1/2/3 legacy mode booting

- Add RTC interconnect target data for ti81xx and am43x

- Add custom reset handler for PCIeSS

- Add eDMA interconnect target data for dra7

----------------------------------------------------------------
Keerthy (2):
      ARM: AM43XX: hwmod: Add rtc hwmod
      ARM: OMAP: DRA7: Make use of omap_revision information for soc_is* calls

Peter Ujfalusi (3):
      ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
      ARM: OMAP2+: DMA: Provide dma_slave_map to omap-dma for legacy boot
      ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1

Sekhar Nori (1):
      ARM: DRA7: hwmod: Add custom reset handler for PCIeSS

Tony Lindgren (2):
      ARM: OMAP2+: Add rtc hwmod configuration for ti81xx
      Merge tag 'for-v4.6/omap-hwmod-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/soc

 arch/arm/mach-omap1/dma.c                  |  45 +++++++++++
 arch/arm/mach-omap2/dma.c                  | 117 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  14 +++-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 111 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  38 ++++++++++
 arch/arm/mach-omap2/soc.h                  |  23 +++++-
 6 files changed, 344 insertions(+), 4 deletions(-)
