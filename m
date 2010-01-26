From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 08:08:23 +0000
Subject: [PULL] Please pull bjdooks' for-rmk/samsung3
Message-ID: <20100126080823.GA17378@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform moves, some minor bugfixing and updates for S3C64XX support.

The following changes since commit 54b89177ac533dc7439491afd26baf59464b425c:
  Ben Dooks (1):
        ARM: Merge next-samsung-s5p6440-iodec

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung3

Ben Dooks (6):
      ARM: SAMSUNG: Move more support into plat-samsung
      ARM: SAMSUNG: Move pmw.c to plat-samsung
      ARM: SAMSUNG: Move pm-check.c to plat-samsung
      ARM: S3C64XX: Tidy up common code in s3c64xx_spi_set_info()
      ARM: S5P6440: Add HSMMC and OTG base addresses to map.h
      ARM: SAMSUNG: Fix bad use of __initdata for s3c_register_clocks()

Mark Brown (4):
      ARM: SMDK6410: Set up interrupt range for WM835x on 1190-EV1 PMIC board
      ARM: S3C64XX: Fix dev-audio build
      ARM: S3C64XX: Staticise audio platform data
      ARM: SAMSUNG: Staticise gpiolib implementation functions

Maurus Cuelenaere (2):
      ARM: S3C64XX: Fix typo in s3c-hsotg platform data
      ARM: SAMSUNG: Fix null pointer dereference in ADC driver

Thomas Abraham (1):
      ARM: S5PV210: Add serial port support

 arch/arm/configs/mini2440_defconfig                |    4 +-
 arch/arm/configs/s3c2410_defconfig                 |    4 +-
 arch/arm/mach-s3c6410/mach-smdk6410.c              |    1 +
 arch/arm/mach-s5p6440/include/mach/map.h           |    8 +
 arch/arm/plat-s3c/Kconfig                          |   44 ------
 arch/arm/plat-s3c/Makefile                         |    5 -
 arch/arm/plat-s3c/include/plat/pm.h                |    4 +-
 arch/arm/plat-s3c/include/plat/regs-serial.h       |   30 ++++
 arch/arm/plat-s3c/pm.c                             |    6 +-
 arch/arm/plat-s3c64xx/dev-audio.c                  |   12 +-
 arch/arm/plat-s3c64xx/dev-spi.c                    |   15 +-
 arch/arm/plat-s3c64xx/include/plat/irqs.h          |    4 +
 arch/arm/plat-samsung/Kconfig                      |   45 ++++++
 arch/arm/plat-samsung/Makefile                     |    5 +
 arch/arm/plat-samsung/adc.c                        |    2 +-
 arch/arm/plat-samsung/clock.c                      |    2 +-
 arch/arm/plat-samsung/gpiolib.c                    |   16 +-
 .../include/plat/dma-core.h                        |    0
 .../include/plat/hwmon.h                           |    0
 .../include/plat/iic-core.h                        |    0
 .../{plat-s3c => plat-samsung}/include/plat/iic.h  |    0
 .../{plat-s3c => plat-samsung}/include/plat/nand.h |    0
 .../include/plat/regs-ac97.h                       |    0
 .../include/plat/regs-adc.h                        |    0
 .../include/plat/regs-iic.h                        |    0
 .../include/plat/regs-irqtype.h                    |    0
 .../include/plat/regs-nand.h                       |    0
 .../include/plat/regs-rtc.h                        |    0
 .../include/plat/regs-s3c2412-iis.h                |    0
 .../include/plat/regs-sdhci.h                      |    0
 .../include/plat/regs-timer.h                      |    0
 .../include/plat/regs-usb-hsotg-phy.h              |    0
 .../include/plat/regs-usb-hsotg.h                  |    0
 .../include/plat/regs-watchdog.h                   |    0
 .../include/plat/sdhci.h                           |    0
 .../include/plat/udc-hs.h                          |    4 +-
 .../include/plat/watchdog-reset.h                  |    0
 arch/arm/{plat-s3c => plat-samsung}/pm-check.c     |    8 +-
 arch/arm/{plat-s3c => plat-samsung}/pwm.c          |    0
 drivers/serial/Kconfig                             |    9 +-
 drivers/serial/Makefile                            |    1 +
 drivers/serial/s5pv210.c                           |  154 ++++++++++++++++++++
 42 files changed, 297 insertions(+), 86 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/dma-core.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/hwmon.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/iic-core.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/iic.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/nand.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-ac97.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-adc.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-iic.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-irqtype.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-nand.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-rtc.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-s3c2412-iis.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-sdhci.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-timer.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-usb-hsotg-phy.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-usb-hsotg.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/regs-watchdog.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/sdhci.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/udc-hs.h (93%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/watchdog-reset.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/pm-check.c (95%)
 rename arch/arm/{plat-s3c => plat-samsung}/pwm.c (100%)
 create mode 100644 drivers/serial/s5pv210.c


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
