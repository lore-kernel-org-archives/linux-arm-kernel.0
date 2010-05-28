From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 12:12:21 +0100
Subject: please pull bjdooks' for-linus/2635-updates
Message-ID: <20100528111221.GD4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following, which updates the documentation to follow
the current Samsung areas of the kernel, fixes a pair of missing clocks
and updates the defconfigs i'm directly responsible for up to the latest
kernel. Also fix a serial sparse warning.

The following changes since commit 9dda696f0de87a2e5cfabb147e28c76b7d3c6846:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/2635-updates

Ben Dooks (15):
      ARM: SAMSUNG: Documentation: update the list of SoCs supported
      ARM: SAMSUNG: Documentation: update directory layout
      ARM: S3C24XX: Documentation: update documentation overview
      ARM: S3C24XX: Documentation: update GPIO documentation
      ARM: S3C24XX: Documentation: add section on gpiolib changes
      ARM: SAMSUNG: Fix documentation for s3c_gpio_cfgpin()
      ARM: SAMSUNG: Documentation: add documentation on GPIO code
      ARM: SAMSUNG: gpio-cfg.h: update documentation
      ARM: s3c6400_defconfig: Update compiled machines
      ARM: s3c6400_defconfig: Add SPI driver
      ARM: s3c6400_defconfig: Enable USB host side
      ARM: s3c6400_defconfig: Add RTC driver support
      ARM: s3c6400_defconfig: Add framebuffer and basic LCD
      ARM: s3c2410_defconfig: Add new machines
      ARM: Merge for-2635/defconfig3

Marek Szyprowski (1):
      ARM: S5PV210: serial: Fix section mismatch warning

Thomas Abraham (2):
      ARM: S3C64XX: Add USB OTG HCLK to the list of clocks
      ARM: S5P: Regoster clk_xusbxti clock for hsotg driver

 Documentation/arm/Samsung-S3C24XX/GPIO.txt     |   81 +++++-
 Documentation/arm/Samsung-S3C24XX/Overview.txt |   15 +-
 Documentation/arm/Samsung/GPIO.txt             |   42 +++
 Documentation/arm/Samsung/Overview.txt         |   33 ++-
 arch/arm/configs/s3c2410_defconfig             |   35 ++-
 arch/arm/configs/s3c6400_defconfig             |  390 +++++++++++++++++++++++-
 arch/arm/mach-s3c64xx/clock.c                  |    6 +
 arch/arm/plat-s5p/clock.c                      |    1 +
 arch/arm/plat-samsung/include/plat/gpio-cfg.h  |   23 ++-
 drivers/serial/s5pv210.c                       |    8 +-
 10 files changed, 594 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/arm/Samsung/GPIO.txt


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
