From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:16 +0100
Subject: [PATCH 0/7] ARM: remove init_consistent_dma_size() stub
Message-ID: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Commit e9da6e9905e639b0 ("ARM: dma-mapping: remove custom consistent dma
region") replaced custom consistent memory handling, so setting
consistent dma memory size is not longer required. This patch series
cleans sub-architecture platform code to remove all calls to the
obsolated init_consistent_dma_size() function and finally removes the
init_consistent_dma_size() stub itself.

Arnd, Olof: could You apply it to arm-soc cleanup branch?

Best regards
Marek Szyprowski
Samsung Poland R&D Center

CC: Tony Lindgren <tony@atomide.com>
CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@ti.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Andrew Victor <linux@maxim.org.za>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Linus Walleij <linus.walleij@linaro.org>

Patch summary:

Marek Szyprowski (7):
  ARM: omap: remove obsoleted init_consistent_dma_size()
  ARM: samsung: remove obsoleted init_consistent_dma_size()
  ARM: davinci: remove obsoleted init_consistent_dma_size()
  ARM: shmobile: remove obsoleted init_consistent_dma_size()
  ARM: at91: remove obsoleted init_consistent_dma_size()
  ARM: u300: remove obsoleted init_consistent_dma_size()
  ARM: dma-mapping: remove init_consistent_dma_size() stub

 arch/arm/include/asm/dma-mapping.h     |    7 -------
 arch/arm/mach-at91/at91sam9g45.c       |    1 -
 arch/arm/mach-davinci/common.c         |    2 --
 arch/arm/mach-omap1/io.c               |    1 -
 arch/arm/mach-omap2/io.c               |   12 ------------
 arch/arm/mach-s3c64xx/common.c         |    1 -
 arch/arm/mach-s5p64x0/common.c         |    2 --
 arch/arm/mach-s5pv210/common.c         |    2 --
 arch/arm/mach-shmobile/setup-r8a7740.c |    6 ------
 arch/arm/mach-shmobile/setup-sh7372.c  |    6 ------
 arch/arm/mach-u300/core.c              |    2 --
 arch/arm/plat-omap/common.c            |    7 -------
 arch/arm/plat-omap/include/plat/dma.h  |    1 -
 13 files changed, 50 deletions(-)

-- 
1.7.9.5
