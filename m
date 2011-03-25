From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 Mar 2011 14:24:03 +0100
Subject: [GIT PULL] i.MX patches for 2.6.39
Message-ID: <20110325132403.GF7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following i.MX patches for 2.6.39.

The branch contains missing board pieces which couldn't be merged in the
last pull request due to platform data dependencies.
One patch which is not board specific is the addition of sched_clock for
i.MX.

Sascha

The following changes since commit 6447f55da90b77faec1697d499ed7986bb4f6de6:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx (2011-03-22 17:53:13 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Andres Salomon (1):
      ARM: mx51_efika: update platform data for new mfd changes

Dinh Nguyen (3):
      ARM: mx50: Add support to get the silicon revision
      ARM: mx51: Add entry for gpc_dvfs_clk
      ARM: mx51: Implement code to allow mx51 to enter WFI

Eric B?nard (4):
      mx3/eukrea_mbimxsd-baseboard: fix gpio request
      mx3/eukrea_mbimxsd-baseboard: add SD card detect support
      eukrea_mbimxsd25-baseboard: add SD card detect
      eukrea_mbimxsd51: add SD Card detect

Fabio Estevam (4):
      ARM: mx51: Print silicon revision on boot
      ARM: mx5/babbage: Use gpio_request_one in babbage_fec_reset
      ARM: mx5/mx53_evk: Use gpio_request_one in mx53_evk_fec_reset
      ARM: mx5/mx53_evk: Make the reset pin name more meaningful

Frank Li (1):
      ARM: mx53_loco: Add GPIO Keypad support

Huang Weiyi (1):
      ARM i.MX: remove duplicated #include

Jan Weitzel (2):
      ARM: mxc: Add dummy_get_cycles to avoid access before init is done
      ARM: mxc: Add sched_clock to mxc platform

Julien Boibessot (2):
      MX51: Add AUDMUX ports definitions
      mx2/iomux: Set direction for CSPI2 pins

Lothar Wa?mann (1):
      ARM: mxs: configure and register the second FEC device on TX28/STK5-V4

Shawn Guo (4):
      ARM: mxc: fix buggy '.end' of IORESOURCE_MEM in device codes
      ARM: mxs: dynamically allocate mmc device
      ARM: mxs/mx23evk: add mmc device
      ARM: mxs/mx28evk: add mmc device

Uwe Kleine-K?nig (1):
      ARM: imx: let MACH_IMX27_VISSTRIM_M10 select IMX_HAVE_PLATFORM_IMX_SSI

Wolfram Sang (1):
      arm: mach-mx3: pcm043: add write-protect and card-detect for SD1

 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-imx/Kconfig                       |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c  |    8 ++-
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |   14 +++-
 arch/arm/mach-mx3/mach-pcm043.c                 |   12 +++-
 arch/arm/mach-mx5/Kconfig                       |    1 +
 arch/arm/mach-mx5/Makefile                      |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c          |    5 +-
 arch/arm/mach-mx5/board-mx53_evk.c              |    9 +--
 arch/arm/mach-mx5/board-mx53_loco.c             |   25 +++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c             |    9 +++
 arch/arm/mach-mx5/cpu.c                         |   59 +++++++++++++++
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c    |    4 +
 arch/arm/mach-mx5/mx51_efika.c                  |    7 +-
 arch/arm/mach-mx5/system.c                      |   84 +++++++++++++++++++++
 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |   15 ++++
 arch/arm/mach-mxs/clock-mx28.c                  |   18 +++++
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c    |   73 +++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 ++++
 arch/arm/mach-mxs/mach-mx23evk.c                |   44 +++++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   89 +++++++++++++++++++++++
 arch/arm/mach-mxs/module-tx28.c                 |   41 +++++++++--
 arch/arm/mach-mxs/module-tx28.h                 |    1 +
 arch/arm/plat-mxc/devices/platform-fec.c        |    2 +-
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c  |    2 +-
 arch/arm/plat-mxc/include/mach/audmux.h         |   10 +++-
 arch/arm/plat-mxc/include/mach/iomux-mx2x.h     |   12 ++--
 arch/arm/plat-mxc/include/mach/mx50.h           |    4 +
 arch/arm/plat-mxc/include/mach/mx51.h           |    1 +
 arch/arm/plat-mxc/include/mach/mxc.h            |   23 ++++++
 arch/arm/plat-mxc/include/mach/system.h         |    6 ++-
 arch/arm/plat-mxc/time.c                        |   25 ++++++-
 37 files changed, 600 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-mx5/system.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-mmc.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
