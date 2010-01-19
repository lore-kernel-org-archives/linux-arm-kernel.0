From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 19 Jan 2010 10:12:19 +0000
Subject: [PULL] Please pull bjdooks' for-rmk/samsung2
Message-ID: <20100119101219.GA1072@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following tree which contains further updates since the
last set of machine additions (and thus should go via RMK's trees)

The following changes since commit 501dae90b3ae4dd3d8efdacfcb072c3d65eb5a33:
  Kukjin Kim (1):
        ARM: S5P6440: Add serial port support

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/samsung2

Andy Green (4):
      ARM: S3C64XX: Add SROM register definitions
      ARM: SMDK6410: Add nC1 chipselect SROM setup
      ARM: S3C64XX: Add virtual mapping for S3C64XX SROM area
      ARM: SMDK6410: Add comments on ethernet connectivity

Ben Dooks (25):
      ARM: S3C: Rename s3c_device_usb to s3c_device_ohci
      ARM: S3C2412: Fixup commented out device in SMDK2413
      ARM: Merge next-s3c64xx
      ARM: S5PC1XX: Register pd0 and hd0 clocks, remove unecessary dummy_enable
      ARM: SAMSUNG: Fix clksrc-clk's checks for bad register settings
      ARM: SAMSUNG: Fix bug in clksrc-clk round_rate call.
      ARM: SAMSUNG: Make UART device code common
      ARM: SAMSUNG: Add platform data registration for OHCI
      ARM: MINI2440: Remove commented out devices from device array
      ARM: S3C24XX: Add mci platform data set call s3c24xx_mci_set_platdata().
      ARM: Merge next-samsung-mc-adc
      ARM: Merge next-s3c6410-andygreen
      ARM: Merge next-jassi-spi
      ARM: Merge next-samsung-devupdates1
      ARM: Merge next-samsung-clock2
      ARM: Merge next-jassi-spi
      ARM: Merge next-samsung-devupdates1
      ARM: Merge next-samsung-clock2
      ARM: Merge next-samsung-serial1
      ARM: SAMSUNG: Move pm-gpio into plat-samsung
      ARM: SAMSUNG: Move gpiolib support in gpio.c to plat-samsung
      ARM: SAMSUNG: Move GPIO headers to plat-samsung
      ARM: SAMSUNG: Remove empty gpio-core.h and use central plat/gpio-core.h
      ARM: SAMSUNG: Add initial documentation directory and overview
      ARM: Merge next-samsung-s5p6440-iodec

Jassi Brar (5):
      ARM: S3C64XX: Add I2S resources in platform code
      ARM: S3C64XX: SPI: Add SPI controller register base
      ARM: S3C64XX: SPI: Define SPI-48M clock sources
      ARM: S3C64XX: SPI: Header for passing platform data
      ARM: S3C64XX: SPI: Define SPI controller devices

Kukjin Kim (3):
      ARM: SAMSUNG: Move GPIO common functions to plat-samsung
      ARM: S5P6440: Add S5P6440 GPIO support
      ARM: S5P6440: Add IO descriptor for ChipID block.

Maurus Cuelenaere (3):
      ARM: S3C64XX: Add S3C64XX RTC platform driver
      ARM: SAMSUNG: Move S3C24XX ADC driver to plat-samsung
      ARM: S3C64XX: Add S3C64XX support to the generic Samsung ADC driver

Thomas Abraham (2):
      ARM: SAMSUNG: Add check to ensure that clksrc_clk does have multiple clock sources
      ARM: SAMSUNG: serial: Modify console initialization.

 Documentation/arm/Samsung/Overview.txt             |   86 ++++++
 arch/arm/configs/mini2440_defconfig                |    2 +-
 arch/arm/configs/s3c2410_defconfig                 |    2 +-
 .../include/mach/{gpio-core.h => gpio-track.h}     |    1 -
 arch/arm/mach-s3c2410/mach-amlm5900.c              |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c                  |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c                 |    7 +-
 arch/arm/mach-s3c2410/mach-n30.c                   |    2 +-
 arch/arm/mach-s3c2410/mach-otom.c                  |    2 +-
 arch/arm/mach-s3c2410/mach-qt2410.c                |    2 +-
 arch/arm/mach-s3c2410/mach-smdk2410.c              |    2 +-
 arch/arm/mach-s3c2410/mach-tct_hammer.c            |    2 +-
 arch/arm/mach-s3c2410/mach-vr1000.c                |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.c                 |    4 +-
 arch/arm/mach-s3c2412/mach-jive.c                  |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c              |    3 +-
 arch/arm/mach-s3c2412/mach-vstms.c                 |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c                |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c             |    7 +-
 arch/arm/mach-s3c2440/mach-mini2440.c              |    8 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c              |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c                |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    2 +-
 arch/arm/mach-s3c2442/mach-gta02.c                 |    7 +-
 arch/arm/mach-s3c6400/include/mach/gpio-core.h     |   21 --
 arch/arm/mach-s3c6400/include/mach/map.h           |   18 ++
 arch/arm/mach-s3c6410/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c6410/mach-smdk6410.c              |   39 +++-
 arch/arm/mach-s5p6440/Makefile                     |    2 +-
 arch/arm/mach-s5p6440/include/mach/gpio-core.h     |   19 --
 arch/arm/mach-s5p6440/include/mach/map.h           |    5 +
 arch/arm/mach-s5p6440/include/mach/regs-gpio.h     |   54 ++++
 arch/arm/mach-s5p6440/s5p6440-gpio.c               |  322 ++++++++++++++++++++
 arch/arm/mach-s5pc100/include/mach/gpio-core.h     |   21 --
 arch/arm/plat-s3c/Makefile                         |    2 -
 arch/arm/plat-s3c/include/plat/devs.h              |    5 +-
 arch/arm/plat-s3c/include/plat/regs-adc.h          |    3 +
 arch/arm/plat-s3c/include/plat/usb-control.h       |    2 +
 arch/arm/plat-s3c24xx/Kconfig                      |    7 -
 arch/arm/plat-s3c24xx/Makefile                     |    1 -
 arch/arm/plat-s3c24xx/devs.c                       |   41 +--
 arch/arm/plat-s3c24xx/gpiolib.c                    |    2 +-
 arch/arm/plat-s3c24xx/include/plat/mci.h           |    9 +
 arch/arm/plat-s3c64xx/Kconfig                      |    1 +
 arch/arm/plat-s3c64xx/Makefile                     |    6 +
 arch/arm/plat-s3c64xx/clock.c                      |   12 +
 arch/arm/plat-s3c64xx/cpu.c                        |    5 +
 arch/arm/plat-s3c64xx/dev-adc.c                    |   46 +++
 arch/arm/plat-s3c64xx/dev-audio.c                  |   91 ++++++-
 arch/arm/plat-s3c64xx/dev-rtc.c                    |   43 +++
 arch/arm/plat-s3c64xx/dev-spi.c                    |  180 +++++++++++
 arch/arm/plat-s3c64xx/dev-uart.c                   |   29 --
 arch/arm/plat-s3c64xx/gpiolib.c                    |  164 +----------
 arch/arm/plat-s3c64xx/include/plat/regs-srom.h     |   59 ++++
 arch/arm/plat-s3c64xx/include/plat/spi-clocks.h    |   18 ++
 arch/arm/plat-s5p/Kconfig                          |    4 +
 arch/arm/plat-s5p/dev-uart.c                       |   28 --
 arch/arm/plat-s5pc1xx/clock.c                      |    9 +-
 arch/arm/plat-s5pc1xx/dev-uart.c                   |   29 --
 arch/arm/plat-s5pc1xx/gpio-config.c                |    2 +-
 arch/arm/plat-s5pc1xx/gpiolib.c                    |    2 +-
 arch/arm/plat-samsung/Kconfig                      |   16 +
 arch/arm/plat-samsung/Makefile                     |   11 +
 arch/arm/{plat-s3c24xx => plat-samsung}/adc.c      |   31 ++-
 arch/arm/plat-samsung/clock-clksrc.c               |   25 +-
 arch/arm/plat-samsung/dev-uart.c                   |   44 +++
 arch/arm/plat-samsung/dev-usb.c                    |   25 ++-
 arch/arm/plat-samsung/gpio-config.c                |    2 +-
 arch/arm/{plat-s3c => plat-samsung}/gpio.c         |    2 +-
 arch/arm/plat-samsung/gpiolib.c                    |  197 ++++++++++++
 .../{plat-s3c => plat-samsung}/include/plat/adc.h  |    4 +-
 .../include/plat/gpio-cfg-helpers.h                |    0
 .../include/plat/gpio-cfg.h                        |    0
 .../include/plat/gpio-core.h                       |   30 ++
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |   67 ++++
 arch/arm/{plat-s3c => plat-samsung}/pm-gpio.c      |    2 +-
 drivers/serial/samsung.c                           |    6 +-
 drivers/serial/samsung.h                           |   19 +-
 78 files changed, 1507 insertions(+), 432 deletions(-)
 create mode 100644 Documentation/arm/Samsung/Overview.txt
 rename arch/arm/mach-s3c2410/include/mach/{gpio-core.h => gpio-track.h} (96%)
 delete mode 100644 arch/arm/mach-s3c6400/include/mach/gpio-core.h
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/gpio-core.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-gpio.h
 create mode 100644 arch/arm/mach-s5p6440/s5p6440-gpio.c
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio-core.h
 create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c
 create mode 100644 arch/arm/plat-s3c64xx/dev-rtc.c
 create mode 100644 arch/arm/plat-s3c64xx/dev-spi.c
 create mode 100644 arch/arm/plat-s3c64xx/include/plat/regs-srom.h
 create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
 rename arch/arm/{plat-s3c24xx => plat-samsung}/adc.c (93%)
 create mode 100644 arch/arm/plat-samsung/dev-uart.c
 rename arch/arm/{plat-s3c => plat-samsung}/gpio.c (99%)
 create mode 100644 arch/arm/plat-samsung/gpiolib.c
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/adc.h (92%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/gpio-cfg-helpers.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/gpio-cfg.h (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/gpio-core.h (76%)
 create mode 100644 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
 rename arch/arm/{plat-s3c => plat-samsung}/pm-gpio.c (99%)


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
