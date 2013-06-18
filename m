From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 11:07:26 -0700
Subject: [GIT PULL 4/7] omap dma clean-up for v3.11 merge window
In-Reply-To: <pull-1371578847-800598>
Message-ID: <mailman.9.1371578947.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/dma-signed

for you to fetch changes up to e2081f96ba1be3aa22a44daec82af9b226a6d7d6:

  ARM: OMAP1: Remove dma.h (2013-06-18 00:12:34 -0700)

----------------------------------------------------------------
Non-critical omap DMA fixes and removal of unused legacy code.

----------------------------------------------------------------
Jarkko Nikula (8):
      ARM: OMAP2+: Remove AES crypto device DMA channel definitions
      ARM: OMAP2+: Remove duplicated DMA channel definitions
      ARM: OMAP2+: hwmod: Remove remaining DMA channel definitions
      ARM: OMAP2+: Remove dma.h
      ARM: OMAP1: Remove McBSP DMA channel definitions
      ARM: OMAP1: Remove duplicated DMA channel definitions
      ARM: OMAP1: Remove legacy irda.h and irda setup from board files
      ARM: OMAP1: Remove dma.h

R Sricharan (2):
      ARM: OMAP: dma: Remove the wrong dev_id check
      ARM: OMAP: dma: Fix the dma_chan_link_map init order

Rajendra Nayak (1):
      ARM: OMAP: dma: Remove the erroneous freeing of platform data

 arch/arm/mach-omap1/board-h2.c                     | 36 -------------
 arch/arm/mach-omap1/board-palmte.c                 | 31 -----------
 arch/arm/mach-omap1/board-palmtt.c                 | 30 -----------
 arch/arm/mach-omap1/board-palmz71.c                | 31 -----------
 arch/arm/mach-omap1/board-sx1.c                    | 36 -------------
 arch/arm/mach-omap1/devices.c                      |  9 ++--
 arch/arm/mach-omap1/dma.c                          |  2 -
 arch/arm/mach-omap1/dma.h                          | 42 ---------------
 arch/arm/mach-omap1/include/mach/irda.h            | 33 ------------
 arch/arm/mach-omap1/lcd_dma.c                      |  2 -
 arch/arm/mach-omap1/mcbsp.c                        | 33 ++++++------
 arch/arm/mach-omap2/devices.c                      |  1 -
 arch/arm/mach-omap2/dma.h                          | 61 ----------------------
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c | 21 ++++----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 19 ++++---
 arch/arm/plat-omap/dma.c                           | 11 ++--
 16 files changed, 43 insertions(+), 355 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/dma.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/irda.h
 delete mode 100644 arch/arm/mach-omap2/dma.h
