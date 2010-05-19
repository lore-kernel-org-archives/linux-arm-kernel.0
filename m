From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 May 2010 15:26:37 +0200
Subject: Please pull mxc branch
Message-ID: <20100519132637.GQ31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Please pull the following. I know I'm a bit late, sorry for this.

Sascha

The following changes since commit 537b60d17894b7c19a6060feae40299d7109d6e7:
  Linus Torvalds (1):
        Merge branch 'x86-uv-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6 for-rmk

Alberto Panizzo (2):
      MX3X: Add Keypad device definition for MX3X arch
      mx31_3ds: Support the keypad situated in the personality board

Amit Kucheria (1):
      mxc: Change gpt timer code to be more generic by using V2 instead of MX3

Daniel Mack (5):
      ARM: mx3/lilly1131: add USB support
      ARM: MXC: mxcmmc: misc cleanups
      ARM: MXC: mxcmmc: Teach the driver SDIO operations
      ARM: MXC: mxcmmc: work around a bug in the SDHC busy line handling
      ARM: mx3: Fix a race condition in mxcmmc

Dinh Nguyen (9):
      mx5: Add registration of GPIOs for MX5 devices
      mxc: Update GPIO for USB support on Freescale MX51 Babbage HW
      mx5: Add USB device definitions for Freescale MX51 Babbage HW
      mx5: Enable board specific functions for enabling USB host on Babbage
      mxc: Add generic USB HW initialization for MX51
      mx5: Add USB to Freescale MX51 defconfig
      mx5: change usb clock source from pll3 to pll2
      mx5: enable usb gadget for freescale mx51 babbage board
      mx5: bring usb phy out of reset on freescale mx51 babbage hw

Ivo Clarysse (2):
      MXC: mxc_nand: set NFC registers after reset
      MXC: mxc_nand: support i.MX21

Magnus Lilja (1):
      MXC: Add USB OTG (device) for i.MX31 PDK (3DS) board.

Philippe R?tornaz (3):
      mx31moboard: Fix usb PHY reset
      mx31moboard: Move usb OTG device registration
      mx31moboard: OTG host support for smartbot board

Valentin Longchamp (1):
      mx31smartbot: change the config of a gpio

Vladimir Zapolskiy (2):
      imx3: Add rtc platform device support
      imx31: add rtc device on litekit board.

Wolfram Sang (6):
      arm/plat-mxc: Fix forgotten renaming in timer.c
      arm/mach-mx2/3: Fix watchdog-devices to match the current driver
      arm/mach-mx3: add watchdog device to Phytec-boards
      arm/mach-mx2: add watchdog device to Phytec-boards
      arm/mx25: add watchdog device
      arm/mx51: add watchdog device

 arch/arm/configs/mx51_defconfig                    |   17 ++-
 arch/arm/mach-mx2/devices.c                        |    9 +-
 arch/arm/mach-mx2/mach-pca100.c                    |    1 +
 arch/arm/mach-mx2/mach-pcm038.c                    |    1 +
 arch/arm/mach-mx25/devices.c                       |   15 ++
 arch/arm/mach-mx25/devices.h                       |    1 +
 arch/arm/mach-mx3/Kconfig                          |    1 +
 arch/arm/mach-mx3/devices.c                        |   40 +++++-
 arch/arm/mach-mx3/devices.h                        |    2 +
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |   87 ++++++++++
 arch/arm/mach-mx3/mach-mx31lilly.c                 |  145 +++++++++++++++++
 arch/arm/mach-mx3/mach-mx31moboard.c               |  104 +++++--------
 arch/arm/mach-mx3/mach-pcm037.c                    |    1 +
 arch/arm/mach-mx3/mach-pcm043.c                    |    1 +
 arch/arm/mach-mx3/mx31lite-db.c                    |    1 +
 arch/arm/mach-mx3/mx31moboard-devboard.c           |    9 +
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |    8 +
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   53 ++++++-
 arch/arm/mach-mx5/board-mx51_babbage.c             |  167 ++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51.c                     |   45 ++++++
 arch/arm/mach-mx5/devices.c                        |  109 +++++++++++++-
 arch/arm/mach-mx5/devices.h                        |    4 +
 arch/arm/plat-mxc/ehci.c                           |  100 ++++++++++++-
 arch/arm/plat-mxc/gpio.c                           |    5 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    3 +-
 arch/arm/plat-mxc/include/mach/iomux-mx3.h         |   17 ++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |   34 +++--
 arch/arm/plat-mxc/include/mach/mxc_ehci.h          |   14 ++-
 arch/arm/plat-mxc/time.c                           |   46 +++---
 arch/arm/plat-mxc/tzic.c                           |    4 +-
 drivers/mmc/core/sdio.c                            |    6 +
 drivers/mmc/host/mxcmmc.c                          |  114 ++++++++++++--
 drivers/mtd/nand/mxc_nand.c                        |  125 ++++++++-------
 drivers/usb/host/ehci-mxc.c                        |    4 +-
 include/linux/mmc/host.h                           |    3 +
 35 files changed, 1097 insertions(+), 199 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
