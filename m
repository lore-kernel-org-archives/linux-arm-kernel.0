From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 May 2011 13:14:59 +0200
Subject: [GIT PULL] i.MX
Message-ID: <20110519111459.GD2429@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Until we get the mentioned maintainer tree for arm, please pull the
following. The diffstat looks frightening, but this is mostly due
to the move of the i.MX3 code to mach-imx. It's the last patch of this
series, so please skip it if you find this inappropriate for this merge
window.

Otherwise this branch contains:

- removal of the unchanged-since-beginning mxc91231 subarchitecture
- several ifdef and other multi-soc related cleanups
- support for the apf938 board
- several small board enhancements

Sascha


The following changes since commit 6221f222c0ebf1acdf7abcf927178f40e1a65e2a:

  Linux 2.6.39-rc2 (2011-04-05 18:30:43 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Baruch Siach (1):
      ARM: imx/mx25: add NAND chip select pins to iomux

Dave Martin (1):
      ARM: mxc: Correct data alignment in headsmp.S for CONFIG_THUMB2_KERNEL

Fabio Estevam (6):
      ARM: mx53: Print silicon revision on boot
      ARM: mx5/babbage: Use gpio_request_one in babbage_usbhub_reset
      ARM: mxs/mach-mx2[38]evk: Set the initial value on gpio_request_one
      ARM: mx5/mx53_smd: Add esdhc support
      ARM: mx5/mx53_loco: Fix build warning related to gpio_keys_button structure
      ARM: mx51: Remove imx51_add_gpio_keys

Gwenhael Goavec-Merou (1):
      MX1: Add ARMadeus Systems APF9328 board support

Peter Korsgaard (1):
      mx23: register clocks for mmc

Richard Zhao (1):
      ARM: imx: clean up the section marks of extern data

Sascha Hauer (1):
      video i.MX: remove mx1 compile time dependencies

Shawn Guo (1):
      ARM: mach-imx: mx25_3ds: add write-protect and card-detect for SD

Uwe Kleine-K?nig (16):
      ARM: imx: fix usb related build failure for mach-vpr200
      ARM: mxs/clock-mx28: fix up name##_set_rate
      ARM: imx: use imx_add_gpio_keys to register "gpio-keys" devices
      ARM: imx: remove #includes already available from devices-common.h
      ARM: mx3: dynamically allocate "mxc_rtc" devices
      ARM: mx3/pcm037: properly allocate memory for mx3-camera
      ARM: mx3/mx31moboard: properly allocate memory for mx3-camera
      ARM: mx3: dynamically allocate "ipu-core" devices
      ARM: mxs: fix naming of struct holding info for mxs-i2c devices
      ARM: imx51: use platform id 2 for imx51-cspi
      ARM: remove support for mxc91231
      ARM: mxc: don't use the symbols in the CPU family choice to select others
      ARM: mxc: don't allow to compile together i.MX51 and i.MX53
      ARM: mx3: make ioremap quirk ready for multi-SoC kernels
      ARM: imx: remove some deprecated and unused #defines
      ARM: imx: move mx3 support to mach-imx

Wolfram Sang (3):
      ARM: mx27: fix gpt4/5 base address
      ARM: mxs/i.MX23: make i2c defines consistent and match the reference manual
      arm: mach-imx/mxs: drop 'default' boards

 arch/arm/Makefile                                  |    3 +-
 arch/arm/configs/mx1_defconfig                     |    1 +
 arch/arm/configs/mx51_defconfig                    |    2 +-
 arch/arm/mach-imx/Kconfig                          |  286 +++++++++
 arch/arm/mach-imx/Makefile                         |   38 +-
 arch/arm/mach-imx/Makefile.boot                    |    4 +
 arch/arm/mach-imx/cache-l2x0.c                     |   56 ++
 arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c      |    3 +-
 arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c      |    1 -
 arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c}  |   38 +--
 arch/arm/mach-imx/cpu-imx35.c                      |   44 ++
 .../crm_regs.h => mach-imx/crmregs-imx31.h}        |    0
 arch/arm/mach-imx/devices-imx1.h                   |    8 +-
 arch/arm/mach-imx/devices-imx21.h                  |   22 +-
 arch/arm/mach-imx/devices-imx25.h                  |   35 +-
 arch/arm/mach-imx/devices-imx27.h                  |   30 +-
 arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h    |   36 +-
 arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h    |   37 +-
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c       |    1 -
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c       |    1 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   17 +-
 .../eukrea_mbimxsd35-baseboard.c}                  |   29 +-
 arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c      |    0
 arch/arm/mach-imx/mach-apf9328.c                   |  144 +++++
 .../arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c |   29 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-bug.c         |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c                  |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c    |    2 -
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   14 +-
 .../arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c |    1 -
 arch/arm/mach-imx/mach-mx1ads.c                    |    1 -
 arch/arm/mach-imx/mach-mx21ads.c                   |    1 -
 arch/arm/mach-imx/mach-mx25_3ds.c                  |   13 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c    |   50 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c     |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c   |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c |   75 ++-
 arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c    |    1 -
 arch/arm/mach-imx/mach-mxt_td60.c                  |    1 -
 arch/arm/mach-imx/mach-pca100.c                    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c      |   65 ++-
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c  |   17 +-
 arch/arm/mach-imx/mach-pcm038.c                    |    1 -
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c      |   17 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-qong.c        |   15 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c      |   36 +-
 arch/arm/mach-imx/mm-imx31.c                       |   66 ++
 arch/arm/mach-imx/mm-imx35.c                       |   63 ++
 arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c     |   13 +-
 arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c      |    3 +-
 .../{mach-mx3 => mach-imx}/mx31moboard-devboard.c  |    1 -
 .../{mach-mx3 => mach-imx}/mx31moboard-marxbot.c   |    2 -
 .../{mach-mx3 => mach-imx}/mx31moboard-smartbot.c  |    1 -
 arch/arm/{mach-mx3 => mach-imx}/pcm037.h           |    0
 arch/arm/mach-mx3/Kconfig                          |  257 --------
 arch/arm/mach-mx3/Makefile                         |   26 -
 arch/arm/mach-mx3/Makefile.boot                    |    3 -
 arch/arm/mach-mx3/devices.c                        |  115 ----
 arch/arm/mach-mx3/devices.h                        |    4 -
 arch/arm/mach-mx3/mm.c                             |  141 -----
 arch/arm/mach-mx5/Kconfig                          |   58 ++-
 arch/arm/mach-mx5/board-cpuimx51.c                 |    2 -
 arch/arm/mach-mx5/board-cpuimx51sd.c               |    2 -
 arch/arm/mach-mx5/board-mx50_rdp.c                 |    1 -
 arch/arm/mach-mx5/board-mx51_babbage.c             |   18 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c             |    5 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c             |    5 +-
 arch/arm/mach-mx5/board-mx53_evk.c                 |    2 -
 arch/arm/mach-mx5/board-mx53_loco.c                |    4 +-
 arch/arm/mach-mx5/board-mx53_smd.c                 |   30 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |    1 +
 arch/arm/mach-mx5/cpu.c                            |   23 +
 arch/arm/mach-mx5/devices-imx50.h                  |    6 +-
 arch/arm/mach-mx5/devices-imx51.h                  |   25 +-
 arch/arm/mach-mx5/devices-imx53.h                  |   13 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |    2 -
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |   16 +-
 arch/arm/mach-mx5/mx51_efika.c                     |    3 -
 arch/arm/mach-mxc91231/Kconfig                     |   11 -
 arch/arm/mach-mxc91231/Makefile                    |    2 -
 arch/arm/mach-mxc91231/Makefile.boot               |    3 -
 arch/arm/mach-mxc91231/clock.c                     |  640 --------------------
 arch/arm/mach-mxc91231/crm_regs.h                  |  394 ------------
 arch/arm/mach-mxc91231/devices.c                   |  251 --------
 arch/arm/mach-mxc91231/devices.h                   |   13 -
 arch/arm/mach-mxc91231/iomux.c                     |  177 ------
 arch/arm/mach-mxc91231/magx-zn5.c                  |   62 --
 arch/arm/mach-mxc91231/mm.c                        |   62 --
 arch/arm/mach-mxc91231/system.c                    |   51 --
 arch/arm/mach-mxs/Kconfig                          |    2 -
 arch/arm/mach-mxs/clock-mx23.c                     |    2 +
 arch/arm/mach-mxs/clock-mx28.c                     |    7 +-
 arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c       |    5 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |    5 +-
 arch/arm/mach-mxs/include/mach/mx23.h              |    2 +-
 arch/arm/mach-mxs/mach-mx23evk.c                   |    2 +-
 arch/arm/mach-mxs/mach-mx28evk.c                   |    4 +-
 arch/arm/plat-mxc/Kconfig                          |   28 +-
 arch/arm/plat-mxc/devices/Kconfig                  |    7 +-
 arch/arm/plat-mxc/devices/Makefile                 |    2 +
 arch/arm/plat-mxc/devices/platform-ipu-core.c      |  129 ++++
 arch/arm/plat-mxc/devices/platform-mxc_rtc.c       |   40 ++
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |    2 +-
 arch/arm/plat-mxc/include/mach/common.h            |    8 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    7 -
 arch/arm/plat-mxc/include/mach/devices-common.h    |   27 +
 arch/arm/plat-mxc/include/mach/hardware.h          |   17 +-
 arch/arm/plat-mxc/include/mach/io.h                |   23 +-
 arch/arm/plat-mxc/include/mach/iomux-mx25.h        |    3 +
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h    |  283 ---------
 arch/arm/plat-mxc/include/mach/irqs.h              |    2 -
 arch/arm/plat-mxc/include/mach/memory.h            |    3 -
 arch/arm/plat-mxc/include/mach/mx27.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx53.h              |   13 -
 arch/arm/plat-mxc/include/mach/mxc.h               |   22 +-
 arch/arm/plat-mxc/include/mach/mxc91231.h          |  256 --------
 arch/arm/plat-mxc/include/mach/system.h            |    6 -
 arch/arm/plat-mxc/include/mach/timex.h             |    2 -
 arch/arm/plat-mxc/ssi-fiq.S                        |    2 +
 arch/arm/plat-mxc/system.c                         |    6 -
 arch/arm/plat-mxc/time.c                           |    2 +-
 drivers/video/Kconfig                              |    5 +-
 drivers/video/imxfb.c                              |   28 +-
 128 files changed, 1360 insertions(+), 3360 deletions(-)
 create mode 100644 arch/arm/mach-imx/cache-l2x0.c
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c (99%)
 rename arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c} (72%)
 create mode 100644 arch/arm/mach-imx/cpu-imx35.c
 rename arch/arm/{mach-mx3/crm_regs.h => mach-imx/crmregs-imx31.h} (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h (67%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h (69%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c (99%)
 rename arch/arm/{mach-mx3/eukrea_mbimxsd-baseboard.c => mach-imx/eukrea_mbimxsd35-baseboard.c} (92%)
 rename arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c (100%)
 create mode 100644 arch/arm/mach-imx/mach-apf9328.c
 rename arch/arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c (95%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-bug.c (98%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c (96%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c (92%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c (94%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c (92%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c (97%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-qong.c (95%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c (92%)
 create mode 100644 arch/arm/mach-imx/mm-imx31.c
 create mode 100644 arch/arm/mach-imx/mm-imx35.c
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c (95%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c (98%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-devboard.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-marxbot.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-smartbot.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/pcm037.h (100%)
 delete mode 100644 arch/arm/mach-mx3/Kconfig
 delete mode 100644 arch/arm/mach-mx3/Makefile
 delete mode 100644 arch/arm/mach-mx3/Makefile.boot
 delete mode 100644 arch/arm/mach-mx3/devices.c
 delete mode 100644 arch/arm/mach-mx3/devices.h
 delete mode 100644 arch/arm/mach-mx3/mm.c
 delete mode 100644 arch/arm/mach-mxc91231/Kconfig
 delete mode 100644 arch/arm/mach-mxc91231/Makefile
 delete mode 100644 arch/arm/mach-mxc91231/Makefile.boot
 delete mode 100644 arch/arm/mach-mxc91231/clock.c
 delete mode 100644 arch/arm/mach-mxc91231/crm_regs.h
 delete mode 100644 arch/arm/mach-mxc91231/devices.c
 delete mode 100644 arch/arm/mach-mxc91231/devices.h
 delete mode 100644 arch/arm/mach-mxc91231/iomux.c
 delete mode 100644 arch/arm/mach-mxc91231/magx-zn5.c
 delete mode 100644 arch/arm/mach-mxc91231/mm.c
 delete mode 100644 arch/arm/mach-mxc91231/system.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-ipu-core.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rtc.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/mxc91231.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
