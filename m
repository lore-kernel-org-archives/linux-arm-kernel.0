From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Jan 2011 10:23:27 +0100
Subject: Pull request i.MX
Message-ID: <20110114092327.GE24373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following i.MX patches. These are mostly compile fixes
plus some patches to make the recently merged i.MX features usable.

Sascha

The following changes since commit 52cfd503ad7176d23a5dd7af3981744feb60622f:

  Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6 (2011-01-13 20:15:35 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Arnaud Patard (2):
      Fix pwm-related build failure
      mx51: add support for pwm

Fabio Estevam (3):
      ARM: imx/mx27_3ds: Add debug board support
      ARM: mx5: dynamically allocate pwm devices
      ARM: mx5: dynamically allocate imx-keypad devices

Richard Zhao (1):
      arm: mxc: move IOMUX_CONFIG_SION definition to iomux-v3.h

Sascha Hauer (3):
      ARM i.MX27 3ds: Fix mc13783 regulator names
      ARM i.MX mx31_3ds: Fix MC13783 regulator names
      ARM mxs: clkdev related compile fixes

Shawn Guo (3):
      ARM: mx28: update clock and device name for dual fec support
      ARM: mx28: add the second fec device registration
      ARM: mxs: Change duart device to use amba-pl011

Yong Shen (10):
      ARM i.MX53: enable fec driver on EVK board
      ARM i.MX53 enable i2c on EVK board
      ARM i.MX53 enable sdhc support on EVK board
      ARM i.MX53 enable spi on EVK board
      ARM i.MX5 uart clock bug fix
      ARM: i.MX53: add IOMUX pad for ecspi
      ARM: i.MX53 EVK: add ecspi IOMUX setting
      ARM: i.MX53 EVK: add spi nor device
      ARM i.MX53 enable SMD board bootup
      ARM i.MX53 enable LOCO board bootup

 arch/arm/Kconfig                                   |    2 +-
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   10 ++-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |    4 +-
 arch/arm/mach-mx5/Kconfig                          |   20 ++++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-mx51_3ds.c                 |    5 +-
 arch/arm/mach-mx5/board-mx53_evk.c                 |   74 +++++++++++++
 arch/arm/mach-mx5/board-mx53_loco.c                |  111 ++++++++++++++++++++
 arch/arm/mach-mx5/board-mx53_smd.c                 |  111 ++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   18 +++-
 arch/arm/mach-mx5/devices-imx51.h                  |    8 ++
 arch/arm/mach-mx5/devices-imx53.h                  |   18 +++
 arch/arm/mach-mx5/devices.c                        |   19 ----
 arch/arm/mach-mx5/devices.h                        |    1 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |    5 +-
 arch/arm/mach-mxs/Kconfig                          |    4 +-
 arch/arm/mach-mxs/clock-mx23.c                     |   13 ++-
 arch/arm/mach-mxs/clock-mx28.c                     |   14 +++-
 arch/arm/mach-mxs/devices-mx23.h                   |    4 +-
 arch/arm/mach-mxs/devices-mx28.h                   |    4 +-
 arch/arm/mach-mxs/devices.c                        |   17 +++-
 arch/arm/mach-mxs/devices/Kconfig                  |    3 +-
 arch/arm/mach-mxs/devices/Makefile                 |    2 +-
 arch/arm/mach-mxs/devices/amba-duart.c             |   40 +++++++
 arch/arm/mach-mxs/devices/platform-duart.c         |   48 ---------
 arch/arm/mach-mxs/devices/platform-fec.c           |    2 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |   11 +--
 arch/arm/mach-mxs/mach-mx28evk.c                   |   26 ++++-
 arch/arm/plat-mxc/devices/Kconfig                  |    2 +-
 arch/arm/plat-mxc/devices/platform-fec.c           |    5 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |    9 ++
 arch/arm/plat-mxc/devices/platform-imx-keypad.c    |    5 +
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c       |    9 ++
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 ++
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        |    4 +-
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |    1 +
 arch/arm/plat-mxc/include/mach/mx51.h              |    6 +-
 arch/arm/plat-mxc/include/mach/mx53.h              |   28 +++---
 arch/arm/plat-mxc/pwm.c                            |    2 +-
 41 files changed, 567 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx53_loco.c
 create mode 100644 arch/arm/mach-mx5/board-mx53_smd.c
 create mode 100644 arch/arm/mach-mxs/devices/amba-duart.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-duart.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
