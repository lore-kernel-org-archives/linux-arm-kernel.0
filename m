From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jul 2011 10:08:46 +0200
Subject: [GIT PULL] i.MX fixes
Message-ID: <20110707080846.GD26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull the following i.MX fixes. I'd say it's not utterly important
to get these into 3.0.


The following changes since commit a2fa83faf47b514ab947cea916d3691b66525073:

  Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6 (2011-07-05 20:57:45 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git fixes

Axel Lin (1):
      ARM i.MX23/28: platform-mxsfb: Add missing include of linux/dma-mapping.h

Fabio Estevam (10):
      mx51: Let USB Storage be built by default
      ARM: mx53: Fix alternate modes for MX53_PAD_PATA_DATA6
      ARM: mx53: Fix the chip select addresses
      ARM: mach-imx/mx27_3ds: Use the standard i.MX macro for GPIO numbering
      ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
      mxc: iomuxv1: Do not use gpio_request when setting the pin as GPIO
      ARM: mach-imx/mx27_3ds: Fix regulator support
      ARM: mxc: iomux-v1: Fix build warning
      ARM: mx51: Fix the address space length for SSI
      ARM: mx53: Fix some interrupts marked as reserved.

Lothar Wa?mann (1):
      mach-mx5: fix the I2C clock parents

Marc Kleine-Budde (1):
      ARM: mx53: Fix the base addresses for the DDR memory regions

Sascha Hauer (1):
      ARM i.MX dma: Fix burstsize settings

Shawn Guo (5):
      ARM: mxs_defconfig: Change CONFIG_RTC_CLASS 'm' to 'y'
      ARM: mxc: imx-sdma device gets 16K iosize than 4K
      ARM: mxc: sdma on imx25 is a V2 block
      ARM: mxc: change imx-dma default to_version to 1
      ARM: mxc: imx-dma on imx25 has no other TO version but TO1

Troy Kisky (2):
      MXC: iomux-v3: correct NO_PAD_CTRL definition
      ARM: i.MX53: Fix IOMUX type o's

Uwe Kleine-K?nig (1):
      ARM: mxs/tx28: according to the TX28's datasheet D4-D7 are not used for MMC0

 arch/arm/configs/mx51_defconfig              |    3 +-
 arch/arm/configs/mxs_defconfig               |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |   29 ++++++++++++++++++----
 arch/arm/mach-imx/mach-mx31_3ds.c            |   10 ++++----
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    4 +-
 arch/arm/mach-mxs/devices/platform-mxsfb.c   |    1 +
 arch/arm/mach-mxs/mach-tx28.c                |    8 ------
 arch/arm/plat-mxc/devices/platform-imx-dma.c |   14 +++++-----
 arch/arm/plat-mxc/devices/platform-imx-ssi.c |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h  |   14 +++++-----
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |    1 -
 arch/arm/plat-mxc/include/mach/iomux-v3.h    |    2 +-
 arch/arm/plat-mxc/include/mach/mx53.h        |   26 ++++++++++----------
 arch/arm/plat-mxc/iomux-v1.c                 |   34 +-------------------------
 drivers/dma/imx-dma.c                        |    3 +-
 drivers/mmc/host/mxcmmc.c                    |    8 +++---
 sound/soc/imx/imx-pcm-dma-mx2.c              |    4 +-
 17 files changed, 73 insertions(+), 92 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
