From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Oct 2010 16:21:53 +0200
Subject: Pull request for i.MX
Message-ID: <20101019142153.GV28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the seocnd bunch of patches for the next merge window

Sascha


The following changes since commit b9969f6525c9c00b042441acb0e1c0ee95560b63:

  Merge branch 'devel-stable' into devel (2010-10-18 22:34:52 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Dinh Nguyen (1):
      ARM: imx: Add iram allocator functions

Eric B?nard (28):
      mx25: fix clock's calculation
      mx25: fix compile error in platform-imx-dma.c
      i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
      cpuimx25 & cpuimx35: fix OTG port registration in host mode
      eukrea_mbimxsd: add support for DVI displays
      clock-mx51: factorize clk_set_parent and clk_get_rate
      clock-mx51: rename CLOCK1 to CLOCK_CCGR for better readability
      iomux-mx51: fix SD1 and SD2's iomux configuration
      mx51: add resources for SD/MMC on i.MX51
      imx-esdhc: update devices registration
      iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
      mx5: add cpuimx51sd module and its baseboard
      cpuimx51: update board support
      mach-pcm037_eet: fix compile errors
      cpuimx27: fix compile when ULPI is selected
      mx25: fix clock's calculation
      mx25: fix compile error in platform-imx-dma.c
      i.MX31 and i.MX35 : fix errate TLSbo65953 and ENGcm09472
      cpuimx25 & cpuimx35: fix OTG port registration in host mode
      eukrea_mbimxsd: add support for DVI displays
      clock-mx51: factorize clk_set_parent and clk_get_rate
      clock-mx51: rename CLOCK1 to CLOCK_CCGR for better readability
      iomux-mx51: fix SD1 and SD2's iomux configuration
      mx51: add resources for SD/MMC on i.MX51
      imx-esdhc: update devices registration
      iomux-mx51: fix GPIO_1_xx 's IOMUX configuration
      mx5: add cpuimx51sd module and its baseboard
      cpuimx51: update board support

Fabio Estevam (1):
      eukrea_mbimxsd-baseboard: Pass the correct GPIO to gpio_free

Ian Lartey (2):
      Fixing ethernet driver compilation error for i.MX31 ADS board
      Fixing ethernet driver compilation error for i.MX31 ADS board

Marc Kleine-Budde (1):
      ARM: imx: add lost 3rd imx-i2c device for mx35

Sascha Hauer (1):
      Merge branch 'imx-for-2.6.37' of /home/ukl/gsrc/linux-2.6 into imx-for-2.6.37

 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-mx25/clock.c                         |    6 +-
 arch/arm/mach-mx25/devices-imx25.h                 |    7 +-
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |   34 ++-
 arch/arm/mach-mx25/mach-cpuimx25.c                 |   14 +-
 arch/arm/mach-mx3/devices-imx35.h                  |    9 +-
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |   42 +++-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |   14 +-
 arch/arm/mach-mx3/mach-mx31ads.c                   |    7 +-
 arch/arm/mach-mx3/mach-pcm037_eet.c                |    3 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |    2 +-
 arch/arm/mach-mx5/Kconfig                          |   28 ++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-cpuimx51.c                 |    9 +
 arch/arm/mach-mx5/board-cpuimx51sd.c               |  333 ++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51.c                     |  244 +++++++++------
 arch/arm/mach-mx5/devices-imx51.h                  |    4 +
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |   23 ++-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |  166 ++++++++++
 arch/arm/plat-mxc/Kconfig                          |    4 +
 arch/arm/plat-mxc/Makefile                         |    1 +
 arch/arm/plat-mxc/devices/platform-esdhc.c         |   56 +++-
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |    1 +
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |   33 ++
 arch/arm/plat-mxc/include/mach/devices-common.h    |   10 +-
 arch/arm/plat-mxc/include/mach/eukrea-baseboards.h |    5 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |   59 +++--
 arch/arm/plat-mxc/include/mach/iram.h              |   41 +++
 arch/arm/plat-mxc/include/mach/mx25.h              |    6 +-
 arch/arm/plat-mxc/include/mach/mx35.h              |    6 +-
 arch/arm/plat-mxc/include/mach/mx51.h              |   16 +-
 arch/arm/plat-mxc/include/mach/system.h            |   32 ++-
 arch/arm/plat-mxc/include/mach/uncompress.h        |    1 +
 arch/arm/plat-mxc/iram_alloc.c                     |   73 +++++
 34 files changed, 1102 insertions(+), 190 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-cpuimx51sd.c
 create mode 100644 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h
 create mode 100644 arch/arm/plat-mxc/include/mach/iram.h
 create mode 100644 arch/arm/plat-mxc/iram_alloc.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
