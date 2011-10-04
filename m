From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 4 Oct 2011 11:20:15 +0200
Subject: [PULL] i.MX
Message-ID: <20111004092015.GM31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following for next. There are merge conflicts between
the cleanup and the features branch, so I decided to merge them together
so you don't have to handle the conflicts yourself. Please let me know
if this is ok for you or if we have to find another solution.

Sascha


The following changes since commit dfa690cd787c72468f8d633c0be81330e4466c08:

  Merge branch 'next/dmtimer' into for-next (2011-10-01 18:51:54 +0200)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-arnd

Arnaud Patard (2):
      Fix pata imx resource
      efika: Configure esdhc cd/wp on efika mx/sb

Fabio Estevam (3):
      ARM: mach-qong: Add watchdog support
      ARM: mach-mxs/mx28evk: Only register devices if their GPIO requests succeeded
      ARM: mxs: Consolidate mm-mx23.c and mm-mx28.c into a single file

Hui Wang (1):
      ARM i.MX avic: convert to use generic irq chip

Jason Liu (4):
      ARM: mx5/mm: move i.MX50 mm stuff into mm.c
      ARM: mx5/mm: Remove MX51_DEBUG related mapping
      ARM: mx5/mm: consolidate TZIC map code
      ARM: mx25: Add the missing IIM base definition

Philippe R?tornaz (1):
      mx31moboard: Add poweroff support

Sascha Hauer (8):
      Merge branches 'cleanups/assorted' and 'cleanups/mm-tzic' into imx-cleanup
      ARM i.MX avic: add handle_irq function
      ARM i.MX tzic: add handle_irq function
      ARM i.MX boards: use CONFIG_MULTI_IRQ_HANDLER
      ARM i.MX entry-macro.S: remove now unused code
      Merge branches 'features/assorted', 'features/imx-pata' and 'features/imx-multi-irq-v2' into imx-features
      Merge branches 'cleanups/mx3-mm-v2' and 'cleanups/mxs' into imx-cleanup
      Merge branch 'imx-features' into for-arnd

Shawn Guo (5):
      arm/imx: merge mm-imx35.c into mm-imx31.c
      arm/imx: rename mm-imx31.c to mm-imx3.c
      arm/imx: change mxc_init_l2x0() to an imx31/35 specific call
      arm/imx: remove cpu_is_xxx() from arch_idle()
      arm/imx: remove cpu_is_xxx() check from __imx_ioremap()

 arch/arm/Kconfig                                  |    1 +
 arch/arm/mach-imx/Kconfig                         |    1 +
 arch/arm/mach-imx/Makefile                        |   15 +-
 arch/arm/mach-imx/cache-l2x0.c                    |   56 -
 arch/arm/mach-imx/mach-apf9328.c                  |    1 +
 arch/arm/mach-imx/mach-armadillo5x0.c             |   19 +-
 arch/arm/mach-imx/mach-bug.c                      |    1 +
 arch/arm/mach-imx/mach-cpuimx27.c                 |    1 +
 arch/arm/mach-imx/mach-cpuimx35.c                 |    3 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c          |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c       |    1 +
 arch/arm/mach-imx/mach-imx27ipcam.c               |    1 +
 arch/arm/mach-imx/mach-imx27lite.c                |    1 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c             |    1 +
 arch/arm/mach-imx/mach-mx1ads.c                   |   17 +-
 arch/arm/mach-imx/mach-mx21ads.c                  |    1 +
 arch/arm/mach-imx/mach-mx25_3ds.c                 |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c                 |    3 +-
 arch/arm/mach-imx/mach-mx27ads.c                  |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c                 |    1 +
 arch/arm/mach-imx/mach-mx31ads.c                  |    1 +
 arch/arm/mach-imx/mach-mx31lilly.c                |    1 +
 arch/arm/mach-imx/mach-mx31lite.c                 |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c              |   18 +
 arch/arm/mach-imx/mach-mx35_3ds.c                 |    1 +
 arch/arm/mach-imx/mach-mxt_td60.c                 |    1 +
 arch/arm/mach-imx/mach-pca100.c                   |    1 +
 arch/arm/mach-imx/mach-pcm037.c                   |    1 +
 arch/arm/mach-imx/mach-pcm038.c                   |    1 +
 arch/arm/mach-imx/mach-pcm043.c                   |    1 +
 arch/arm/mach-imx/mach-qong.c                     |    2 +
 arch/arm/mach-imx/mach-scb9328.c                  |    1 +
 arch/arm/mach-imx/mach-vpr200.c                   |    3 +-
 arch/arm/mach-imx/mm-imx3.c                       |  256 ++
 arch/arm/mach-imx/mm-imx31.c                      |   91 -
 arch/arm/mach-imx/mm-imx35.c                      |  109 -
 arch/arm/mach-imx/pm-imx27.c                      |    2 +-
 arch/arm/mach-mx5/Kconfig                         |   10 +-
 arch/arm/mach-mx5/Makefile                        |    3 +-
 arch/arm/mach-mx5/board-cpuimx51.c                |   28 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c              |   26 +-
 arch/arm/mach-mx5/board-mx50_rdp.c                |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c                |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c            |   27 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c            |   14 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c            |   25 +-
 arch/arm/mach-mx5/board-mx53_ard.c                |    5 +-
 arch/arm/mach-mx5/board-mx53_evk.c                |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c               |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c                |    1 +
 arch/arm/mach-mx5/clock-mx51-mx53.c               |    2 +-
 arch/arm/mach-mx5/devices-imx51.h                 |   13 +
 arch/arm/mach-mx5/devices.c                       |  120 -
 arch/arm/mach-mx5/devices.h                       |    5 -
 arch/arm/mach-mx5/ehci.c                          |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c      |    3 +-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c      |    6 +-
 arch/arm/mach-mx5/mm-mx50.c                       |   72 -
 arch/arm/mach-mx5/mm.c                            |   90 +-
 arch/arm/mach-mx5/mx51_efika.c                    |   18 +-
 arch/arm/mach-mx5/pm-imx5.c                       |    3 +-
 arch/arm/mach-mx5/system.c                        |    1 +
 arch/arm/mach-mxs/Makefile                        |    6 +-
 arch/arm/mach-mxs/include/mach/gpio.h             |    4 -
 arch/arm/mach-mxs/include/mach/mxs.h              |    2 +
 arch/arm/mach-mxs/mach-mx23evk.c                  |    1 -
 arch/arm/mach-mxs/mach-mx28evk.c                  |   24 +-
 arch/arm/mach-mxs/mach-stmp378x_devb.c            |    1 -
 arch/arm/mach-mxs/mm-mx28.c                       |   44 -
 arch/arm/mach-mxs/{mm-mx23.c => mm.c}             |   19 +
 arch/arm/plat-mxc/audmux-v2.c                     |   18 +-
 arch/arm/plat-mxc/avic.c                          |   91 +-
 arch/arm/plat-mxc/devices.c                       |   14 -
 arch/arm/plat-mxc/devices/Kconfig                 |    2 +-
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    5 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c      |    6 +
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c     |    9 +
 arch/arm/plat-mxc/devices/platform-pata_imx.c     |    2 +-
 arch/arm/plat-mxc/include/mach/common.h           |   26 +-
 arch/arm/plat-mxc/include/mach/entry-macro.S      |   58 +-
 arch/arm/plat-mxc/include/mach/gpio.h             |    9 +-
 arch/arm/plat-mxc/include/mach/hardware.h         |   13 +-
 arch/arm/plat-mxc/include/mach/io.h               |   22 +-
 arch/arm/plat-mxc/include/mach/iomux-mx3.h        |    1 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h       | 2270 +++++---------
 arch/arm/plat-mxc/include/mach/iomux-mx53.h       | 3530 +++++++--------------
 arch/arm/plat-mxc/include/mach/iomux-v3.h         |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h             |    1 +
 arch/arm/plat-mxc/include/mach/mx51.h             |  183 +-
 arch/arm/plat-mxc/include/mach/mx53.h             |    1 +
 arch/arm/plat-mxc/include/mach/mxc.h              |    7 -
 arch/arm/plat-mxc/include/mach/system.h           |   35 +-
 arch/arm/plat-mxc/irq-common.c                    |   21 +-
 arch/arm/plat-mxc/irq-common.h                    |    3 +-
 arch/arm/plat-mxc/system.c                        |    3 +
 arch/arm/plat-mxc/tzic.c                          |   32 +-
 drivers/gpio/gpio-mxc.c                           |   12 +
 drivers/gpio/gpio-mxs.c                           |    2 +
 98 files changed, 2768 insertions(+), 4807 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cache-l2x0.c
 create mode 100644 arch/arm/mach-imx/mm-imx3.c
 delete mode 100644 arch/arm/mach-imx/mm-imx31.c
 delete mode 100644 arch/arm/mach-imx/mm-imx35.c
 delete mode 100644 arch/arm/mach-mx5/devices.c
 delete mode 100644 arch/arm/mach-mx5/devices.h
 delete mode 100644 arch/arm/mach-mx5/mm-mx50.c
 delete mode 100644 arch/arm/mach-mxs/mm-mx28.c
 rename arch/arm/mach-mxs/{mm-mx23.c => mm.c} (75%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
