From: khilman@ti.com (Kevin Hilman)
Date: Mon, 14 Mar 2011 11:11:11 -0700
Subject: [GIT PULL] davinci platform updates for 2.6.39
Message-ID: <87aagxlghs.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following davinci updates for the upcoming 2.6.39 merge
window.  

This davinci-next branch has already been included in linux-next, so
should not have merge problems with your devel branch.

Kevin

The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-next

Kevin Hilman (1):
      MAINTAINERS: update TI DaVinci machine support entry

Michael Williamson (13):
      davinci: Support various speedgrades for MityDSP-L138 and MityARM-1808 SoMs
      davinci: da850: remove unused pinmux array
      davinci: da850: remove unused emif pinmux array
      davinci: da850: move da850_evm specific mcasp pins to board file.
      davinci: da850: move da850_evm specific mmcsd pinmux array to board file.
      davinci: da850: remove unused uart pinmux arrays.
      davinci: spi: move event queue parameter to platform data
      davinci: remove unused DA830_edma_ch enum
      davinci: da8xx: clean up magic numbers in devices-da8xx.c
      davinci: da830: fix driver name for spi clocks
      davinci: da850: add spi device clock definitions
      davinci: da8xx: add spi resources and registration routine
      davinci: add spi devices support for MityDSP-L138/MityARM-1808 platform

Sekhar Nori (2):
      davinci: add spi devices support for da850/omap-l138/am18x evm
      davinci: add spi devices support for da830/omap-l137/am17x evm

Sergei Shtylyov (1):
      davinci: DA850 EVM: kill useless variable

Subhasish Ghosh (1):
      davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS.

Sudhakar Rajashekhara (1):
      davinci: Add additional JTAG code for AM-1808 and OMAP-L138 Rev 2.0 SoCs

Victor Rodriguez (6):
      davinci: EMAC support for Omapl138-Hawkboard
      davinci: EDMA support for Omapl138-Hawkboard
      davinci: MMC/SD and USB-OHCI configuration for Omapl138-Hawkboard
      davinci: MMC/SD support for Omapl138-Hawkboard
      davinci: USB clocks for Omapl138-Hawkboard
      davinci: USB1.1 support for Omapl138-Hawkboard

 MAINTAINERS                                 |    3 +-
 arch/arm/mach-davinci/board-da830-evm.c     |   67 +++++++
 arch/arm/mach-davinci/board-da850-evm.c     |   96 +++++++++-
 arch/arm/mach-davinci/board-mityomapl138.c  |  167 +++++++++++++++-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  284 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/da830.c               |    6 +-
 arch/arm/mach-davinci/da850.c               |   99 ++++------
 arch/arm/mach-davinci/devices-da8xx.c       |  125 +++++++++++-
 arch/arm/mach-davinci/dm355.c               |    5 +-
 arch/arm/mach-davinci/dm365.c               |    5 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |   11 +-
 arch/arm/mach-davinci/include/mach/edma.h   |   36 ----
 arch/arm/mach-davinci/include/mach/mux.h    |    4 +
 arch/arm/mach-davinci/include/mach/psc.h    |    2 +-
 arch/arm/mach-davinci/include/mach/spi.h    |   15 +-
 drivers/spi/davinci_spi.c                   |   11 +-
 16 files changed, 789 insertions(+), 147 deletions(-)
