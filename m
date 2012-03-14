From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 15 Mar 2012 00:39:21 +0100
Subject: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS updates
Message-ID: <4F612C29.40608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here are the remaining DTS patches for 3.4.

On top of the previous pull request, I just added the MMC DTS since the driver adaptation just got queued.

It will be still be good to have that for 3.4 if possible, otherwise we will have a bunch of drivers DT adapted but no DTS file to use them :-(

This series is based on your lo/dt-part2 branch.

Thanks,
Benoit


The following changes since commit 328ae2cb50af2f96b6061eb462aa92966a462bbc:
  Ilya Yanok (1):
        arm/dts: mt_ventoux: very basic support for TeeJet Mt.Ventoux board

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dts/all

Benoit Cousson (11):
      arm/dts: twl6030: Add DTS file for twl6030 PMIC
      arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
      arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
      arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
      arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
      ARM: OMAP2+: board-generic: Remove i2c static init
      arm/dts: OMAP4: Add gpio nodes
      arm/dts: OMAP3: Add gpio nodes
      arm/dts: OMAP4: Add SPI controller nodes
      arm/dts: OMAP3: Add SPI controller nodes
      arm/dts: omap4-sdp: Add ks8851 ethernet SPI device

Rajendra Nayak (3):
      arm/dts: twl: Pass regulator data from dt
      arm/dts: OMAP4: Add mmc controller nodes and board data
      arm/dts: OMAP3: Add mmc controller nodes and board data

 arch/arm/boot/dts/omap3-beagle.dts  |   49 +++++++++++++++
 arch/arm/boot/dts/omap3.dtsi        |  102 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts   |   56 +++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts     |   97 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |  117 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi      |   39 ++++++++++++
 arch/arm/boot/dts/twl6030.dtsi      |   86 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c |   37 +----------
 arch/arm/mach-omap2/devices.c       |    4 +-
 arch/arm/mach-omap2/gpio.c          |    8 ++-
 10 files changed, 557 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/boot/dts/twl4030.dtsi
 create mode 100644 arch/arm/boot/dts/twl6030.dtsi
