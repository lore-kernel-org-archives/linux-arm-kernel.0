From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Nov 2016 11:55:32 +0530
Subject: [GIT PULL 1/4] DaVinci cleanup for v4.10
Message-ID: <20161104062535.9593-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/cleanup

for you to fetch changes up to 766763dbdc1dca11deabdb00077a1c19e2803f0a:

  ARM: davinci: da8xx: Remove duplicated defines (2016-10-31 16:51:56 +0530)

----------------------------------------------------------------
Clean-up some unnecessary code from mach-davinci.

- Remove now unneeded dma resources where drivers
  are already converted to use the dma_slave_map[]
  structure.

- Remove some duplicated defines related to USB support.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: davinci: da8xx: Remove duplicated defines

Peter Ujfalusi (4):
      ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
      ARM: davinci: devices: Remove DMA resources for MMC
      ARM: davinci: dm355: Remove DMA resources for SPI
      ARM: davinci: dm365: Remove DMA resources for SPI

 arch/arm/mach-davinci/board-da830-evm.c     |  5 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c |  3 ++-
 arch/arm/mach-davinci/devices-da8xx.c       | 29 -----------------------------
 arch/arm/mach-davinci/devices.c             |  3 ---
 arch/arm/mach-davinci/dm355.c               |  8 --------
 arch/arm/mach-davinci/dm365.c               |  8 --------
 include/linux/platform_data/usb-davinci.h   | 23 -----------------------
 7 files changed, 5 insertions(+), 74 deletions(-)
