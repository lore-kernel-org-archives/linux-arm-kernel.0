From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Jun 2010 10:35:22 +0200
Subject: Please pull mxc patches for -rc
Message-ID: <20100603083522.GX26820@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

please pull the following for -rc.

Sascha

The following changes since commit aef4b9aaae1decc775778903922bd0075cce7a88:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2010-06-01 14:13:14 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Amit Kucheria (1):
      arm: mxc: utilise usecount field in clock operations

Baruch Siach (3):
      mxc_nand: add support for platform defined partitions
      mx25: add platform code for imx-keypad
      mx25pdk: add keypad support

Daniel Mack (4):
      ARM: mx3: pcm037: remove unused variable
      ARM: mx3: mx31lilly: fix build error for !CONFIG_USB_ULPI
      ARM: mx3: mx31lilly: pass mc13783 SPI IRQ pin
      ARM: mx3: update mx3_defconfig

Dinh Nguyen (2):
      mx5: Add i2c to Freescale MX51 Babbage HW
      mx5: Register i2c on Freescale MX51 Babbage HW

Eric B?nard (13):
      eukrea_mbimx27-baseboard: fix typo in display name
      eukrea_mbimx27-baseboard: add generic-bl and platform-lcd controls
      eukrea_mbimx27-baseboard: add timings for DVI output
      cpuimx27 and mbimx27: allow fine control of UART4 and SDHC2 usage
      mach-cpuimx27: fix QuadUART's IRQ typo in pins'setup
      eukrea_mbimx27: fix ADS7846 support
      mach-cpuimx27: add USB Host2 and OTG support
      mach-cpuimx27: register wdt and w1_master resources
      mxcmmc: add card detect through DAT3 possibility
      eukrea_mbimx27: use card detect through DAT3 for SDHC1
      MX2X: Add Keypad device definition for MX2X arch
      eukrea_mbimx27: add support for the keyboard
      eukrea_mbimx27: add audio codec

Sascha Hauer (2):
      mxc_nand: Fix OOB handling
      arm: Add a mx25_defconfig file

Wolfram Sang (1):
      pcm037/pcm043/pca100: fix ULPI-related build warnings

 arch/arm/configs/mx25_defconfig              | 1756 ++++++++++++++++++++++++++
 arch/arm/configs/mx3_defconfig               |  695 ++++++++++-
 arch/arm/mach-mx2/Kconfig                    |   10 +-
 arch/arm/mach-mx2/devices.c                  |   18 +
 arch/arm/mach-mx2/devices.h                  |    1 +
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |  181 +++-
 arch/arm/mach-mx2/mach-cpuimx27.c            |   93 ++-
 arch/arm/mach-mx2/mach-pca100.c              |    2 +
 arch/arm/mach-mx25/clock.c                   |    2 +-
 arch/arm/mach-mx25/devices.c                 |   20 +
 arch/arm/mach-mx25/devices.h                 |    1 +
 arch/arm/mach-mx25/mach-mx25pdk.c            |   36 +
 arch/arm/mach-mx3/mach-mx31lilly.c           |   34 +-
 arch/arm/mach-mx3/mach-pcm037.c              |    3 +-
 arch/arm/mach-mx3/mach-pcm043.c              |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c       |   26 +
 arch/arm/mach-mx5/clock-mx51.c               |   11 +
 arch/arm/mach-mx5/devices.c                  |   58 +
 arch/arm/mach-mx5/devices.h                  |    3 +
 arch/arm/plat-mxc/clock.c                    |   37 +-
 arch/arm/plat-mxc/include/mach/iomux-mx25.h  |   19 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h  |   18 +-
 arch/arm/plat-mxc/include/mach/mmc.h         |    3 +
 arch/arm/plat-mxc/include/mach/mx25.h        |    2 +
 arch/arm/plat-mxc/include/mach/mxc_nand.h    |    4 +
 drivers/mmc/host/mxcmmc.c                    |   16 +-
 drivers/mtd/nand/mxc_nand.c                  |   33 +-
 27 files changed, 2949 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/configs/mx25_defconfig
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
