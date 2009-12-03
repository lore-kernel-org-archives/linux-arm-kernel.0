From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 03 Dec 2009 22:22:46 +0000
Subject: Please pull bjdooks' for-rmk
Message-ID: <E1NGK4U-0005KY-NM@teyla.home.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7:
  Linus Torvalds (1):
        Linux 2.6.32

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk

Arnaud Patard (4):
      ARM: H1940: add mmc device
      ARM: H1940: enable rtc
      ARM: H1940: add lcd/backlight device definition
      ARM: H1940: Convert h1940 bluetooth driver to rfkill

Ben Dooks (14):
      ARM: SAMSUNG: Add plat-samsung as starting point for plat-s3c* moves
      ARM: S3C24XX: machine support for Simtec Audio
      ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.
      ARM: S3C24XX: Add documentation for arch/arm/plat-s3c24xx/include/plat/mci.h
      ARM: S3C: Fix Simtec copyright statements in Documentation/S3C24XX
      ARM: S3C: Update Simtec copyright statements from , to -
      ARM: S3C: Update Simtec copyright statements from , to - [2]
      ARM: H1940: Correct name of the local platform devices for LED and Bluetooth
      ARM: S3C: Add NAND device platform data set call
      ARM: AT2440EVB: Remove duplicated s3c_device_sdi.name set
      ARM: N30: Use s3c_i2c0_set_platdata() to set I2C platform data
      ARM: Merge next-s3c24xx-simtec
      ARM: Merge next-s3c24xx-dev-rtp
      ARM: Merge next-s3c64xx-updates

Kyungmin Park (12):
      ARM: S5PC1XX: registers rename
      ARM: S5PC1XX: clock registers rename
      ARM: S5PC1XX: clocks reimplementation
      ARM: S5PC1XX: add GPIO L banks to register definition
      ARM: S5PC1XX: GPIO registers rename
      ARM: S5PC1xx: add gpiolib and external/gpio interrupt support
      ARM: S5PC1XX: add cpu idle and system reset support
      SMDKC100: enable S3C FrameBuffer
      ARM: S5PC1xx: add platform helpers for i2c adapter devices
      SMDKC100: add I2C0 and I2C1 buses support
      ARM: S5PC1xx: add platform helpers for SDHCI host controllers
      SMDKC100: add SDHCI controllers 0, 1 and 2 support

Mark Brown (5):
      ARM: SMDK6410: Hook up regulator supplies for WM8580
      ARM: S3C64XX: Provide logging when CPU frequencies are eliminated due to clocks
      ARM: S3C64XX: Separate out regulator and frequency latencies
      ARM: S3C64XX: Redo voltage ranges for cpufreq
      ARM: S3C6410: Correct names of IISv4 data output pin definitions

Maurus Cuelenaere (3):
      ARM: S3C64XX: fix USB OTG compilation
      ARM: S3C64XX: add support for all group 0 external interrupts
      ARM: S3C64XX: add HSMMC2 support

Pawel Osciak (2):
      ARM: S3C: Prepare s3c64xx-specific s3c-fb register definition for reuse
      ARM: S5PC1xx: add platform helpers for s3c-fb device

 Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt    |    2 +-
 Documentation/arm/Samsung-S3C24XX/GPIO.txt         |    2 +-
 Documentation/arm/Samsung-S3C24XX/Overview.txt     |    2 +-
 Documentation/arm/Samsung-S3C24XX/S3C2412.txt      |    2 +-
 Documentation/arm/Samsung-S3C24XX/S3C2413.txt      |    2 +-
 Documentation/arm/Samsung-S3C24XX/Suspend.txt      |    2 +-
 Documentation/arm/Samsung-S3C24XX/USB-Host.txt     |    2 +-
 arch/arm/Kconfig                                   |    1 +
 arch/arm/Makefile                                  |    6 +-
 arch/arm/mach-s3c2400/include/mach/map.h           |    2 +-
 arch/arm/mach-s3c2410/Kconfig                      |    8 +
 arch/arm/mach-s3c2410/Makefile                     |    3 +-
 arch/arm/mach-s3c2410/bast-irq.c                   |    4 +-
 arch/arm/mach-s3c2410/cpu-freq.c                   |    2 +-
 arch/arm/mach-s3c2410/h1940-bluetooth.c            |   88 +-
 arch/arm/mach-s3c2410/include/mach/bast-cpld.h     |    2 +-
 arch/arm/mach-s3c2410/include/mach/bast-irq.h      |    2 +-
 arch/arm/mach-s3c2410/include/mach/bast-map.h      |    2 +-
 arch/arm/mach-s3c2410/include/mach/bast-pmu.h      |    2 +-
 arch/arm/mach-s3c2410/include/mach/dma.h           |    2 +-
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h      |    2 +-
 arch/arm/mach-s3c2410/include/mach/osiris-map.h    |    2 +-
 arch/arm/mach-s3c2410/include/mach/regs-clock.h    |    4 +-
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |    4 +-
 arch/arm/mach-s3c2410/include/mach/regs-power.h    |    4 +-
 arch/arm/mach-s3c2410/include/mach/uncompress.h    |    3 +-
 arch/arm/mach-s3c2410/include/mach/vr1000-irq.h    |    2 +-
 arch/arm/mach-s3c2410/mach-bast.c                  |   19 +-
 arch/arm/mach-s3c2410/mach-h1940.c                 |  105 ++-
 arch/arm/mach-s3c2410/mach-n30.c                   |    4 +-
 arch/arm/mach-s3c2410/mach-qt2410.c                |    8 +-
 arch/arm/mach-s3c2410/mach-vr1000.c                |    4 +-
 arch/arm/mach-s3c2410/pll.c                        |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.c                 |    4 +-
 arch/arm/mach-s3c2412/mach-jive.c                  |   11 +-
 arch/arm/mach-s3c2412/mach-vstms.c                 |   10 +-
 arch/arm/mach-s3c2440/Kconfig                      |   13 +
 arch/arm/mach-s3c2440/Makefile                     |    4 +
 arch/arm/mach-s3c2440/irq.c                        |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c                |   29 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c             |    9 +-
 arch/arm/mach-s3c2440/mach-mini2440.c              |    4 +-
 arch/arm/mach-s3c2440/mach-osiris-dvs.c            |  194 +++
 arch/arm/mach-s3c2440/mach-osiris.c                |   47 +-
 arch/arm/mach-s3c2440/mach-rx3715.c                |   11 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    2 +-
 arch/arm/mach-s3c2442/mach-gta02.c                 |    6 +-
 arch/arm/mach-s3c24a0/include/mach/map.h           |    2 +-
 arch/arm/mach-s3c24a0/include/mach/regs-clock.h    |    4 +-
 arch/arm/mach-s3c6400/include/mach/map.h           |    4 +
 arch/arm/mach-s3c6400/include/mach/regs-fb.h       |  236 +---
 arch/arm/mach-s3c6400/s3c6400.c                    |    1 +
 arch/arm/mach-s3c6410/cpu.c                        |    1 +
 arch/arm/mach-s3c6410/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c6410/mach-smdk6410.c              |   52 +
 arch/arm/mach-s5pc100/Kconfig                      |   14 +
 arch/arm/mach-s5pc100/Makefile                     |    4 +
 arch/arm/mach-s5pc100/cpu.c                        |   29 +
 arch/arm/mach-s5pc100/include/mach/gpio.h          |  230 ++--
 arch/arm/mach-s5pc100/include/mach/irqs.h          |    5 +
 arch/arm/mach-s5pc100/include/mach/map.h           |   87 +-
 arch/arm/mach-s5pc100/include/mach/regs-fb.h       |  139 ++
 arch/arm/mach-s5pc100/include/mach/system.h        |   13 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |   89 ++-
 arch/arm/mach-s5pc100/setup-sdhci.c                |   65 +
 arch/arm/plat-s3c/Kconfig                          |   11 +
 arch/arm/plat-s3c/Makefile                         |    1 +
 arch/arm/plat-s3c/clock.c                          |    4 +-
 arch/arm/plat-s3c/dev-hsmmc2.c                     |   69 +
 arch/arm/plat-s3c/dev-i2c0.c                       |    2 +-
 arch/arm/plat-s3c/dev-i2c1.c                       |    2 +-
 arch/arm/plat-s3c/dev-nand.c                       |   97 ++
 arch/arm/plat-s3c/dma.c                            |    2 +-
 arch/arm/plat-s3c/include/plat/audio-simtec.h      |    2 +-
 arch/arm/plat-s3c/include/plat/cpu-freq.h          |    2 +-
 arch/arm/plat-s3c/include/plat/cpu.h               |    6 +
 arch/arm/plat-s3c/include/plat/dma.h               |    2 +-
 arch/arm/plat-s3c/include/plat/fb.h                |    7 +
 arch/arm/plat-s3c/include/plat/iic.h               |    2 +-
 arch/arm/plat-s3c/include/plat/nand.h              |    8 +
 arch/arm/plat-s3c/include/plat/regs-fb-v4.h        |  235 +++
 arch/arm/plat-s3c/include/plat/regs-nand.h         |    4 +-
 arch/arm/plat-s3c/include/plat/regs-serial.h       |    2 +-
 arch/arm/plat-s3c/include/plat/sdhci.h             |   78 +
 arch/arm/plat-s3c/pm-check.c                       |    2 +-
 arch/arm/plat-s3c/pm.c                             |    2 +-
 arch/arm/plat-s3c24xx/Kconfig                      |    7 +
 arch/arm/plat-s3c24xx/Makefile                     |    1 +
 arch/arm/plat-s3c24xx/clock-dclk.c                 |    2 +-
 arch/arm/plat-s3c24xx/common-smdk.c                |    2 +-
 arch/arm/plat-s3c24xx/cpu-freq.c                   |    2 +-
 arch/arm/plat-s3c24xx/dma.c                        |    4 +-
 arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h |    2 +-
 arch/arm/plat-s3c24xx/include/plat/mci.h           |   25 +
 arch/arm/plat-s3c24xx/include/plat/regs-dma.h      |    2 +-
 arch/arm/plat-s3c24xx/irq-pm.c                     |    2 +-
 arch/arm/plat-s3c24xx/irq.c                        |    2 +-
 arch/arm/plat-s3c24xx/pm-simtec.c                  |    4 +-
 arch/arm/plat-s3c24xx/pm.c                         |    2 +-
 arch/arm/plat-s3c24xx/s3c2410-iotiming.c           |    2 +-
 arch/arm/plat-s3c24xx/s3c2412-iotiming.c           |    2 +-
 arch/arm/plat-s3c24xx/s3c2440-cpufreq.c            |    2 +-
 arch/arm/plat-s3c24xx/s3c2440-pll-12000000.c       |    2 +-
 arch/arm/plat-s3c24xx/s3c244x-clock.c              |    2 +-
 arch/arm/plat-s3c24xx/s3c244x-irq.c                |    2 +-
 arch/arm/plat-s3c24xx/simtec-audio.c               |   77 +
 arch/arm/plat-s3c64xx/cpu.c                        |    5 +
 arch/arm/plat-s3c64xx/cpufreq.c                    |   40 +-
 arch/arm/plat-s3c64xx/gpiolib.c                    |   12 +
 arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h   |    6 +-
 arch/arm/plat-s3c64xx/irq-eint.c                   |   19 +-
 arch/arm/plat-s3c64xx/setup-sdhci-gpio.c           |   20 +
 arch/arm/plat-s5pc1xx/Kconfig                      |   18 +-
 arch/arm/plat-s5pc1xx/Makefile                     |   11 +-
 arch/arm/plat-s5pc1xx/clock.c                      |  728 +++++++++
 arch/arm/plat-s5pc1xx/cpu.c                        |   10 +
 arch/arm/plat-s5pc1xx/gpio-config.c                |   62 +
 arch/arm/plat-s5pc1xx/gpiolib.c                    |  503 +++++++
 .../plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h   |   32 +
 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h      |   44 +
 arch/arm/plat-s5pc1xx/include/plat/irqs.h          |   15 +-
 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h    |  212 +--
 arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h     |   70 +
 arch/arm/plat-s5pc1xx/include/plat/regs-power.h    |   84 ++
 arch/arm/plat-s5pc1xx/include/plat/s5pc100.h       |    5 +-
 arch/arm/plat-s5pc1xx/irq-eint.c                   |  281 ++++
 arch/arm/plat-s5pc1xx/irq-gpio.c                   |  266 ++++
 arch/arm/plat-s5pc1xx/irq.c                        |    2 +-
 arch/arm/plat-s5pc1xx/s5pc100-clock.c              | 1555 ++++++++++----------
 arch/arm/plat-s5pc1xx/setup-fb-24bpp.c             |   49 +
 arch/arm/plat-s5pc1xx/setup-i2c0.c                 |    7 +-
 arch/arm/plat-s5pc1xx/setup-i2c1.c                 |    7 +-
 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c           |   86 ++
 arch/arm/plat-samsung/Kconfig                      |   17 +
 arch/arm/plat-samsung/Makefile                     |   11 +
 drivers/serial/s3c2410.c                           |    2 +-
 drivers/serial/s3c2412.c                           |    2 +-
 drivers/serial/s3c2440.c                           |    2 +-
 drivers/serial/s3c24a0.c                           |    2 +-
 drivers/serial/samsung.c                           |    2 +-
 drivers/serial/samsung.h                           |    2 +-
 141 files changed, 5023 insertions(+), 1476 deletions(-)
 create mode 100644 arch/arm/mach-s3c2440/mach-osiris-dvs.c
 create mode 100644 arch/arm/mach-s5pc100/include/mach/regs-fb.h
 create mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 create mode 100644 arch/arm/plat-s3c/dev-hsmmc2.c
 create mode 100644 arch/arm/plat-s3c/include/plat/regs-fb-v4.h
 create mode 100644 arch/arm/plat-s3c24xx/simtec-audio.c
 create mode 100644 arch/arm/plat-s5pc1xx/clock.c
 create mode 100644 arch/arm/plat-s5pc1xx/gpio-config.c
 create mode 100644 arch/arm/plat-s5pc1xx/gpiolib.c
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-power.h
 create mode 100644 arch/arm/plat-s5pc1xx/irq-eint.c
 create mode 100644 arch/arm/plat-s5pc1xx/irq-gpio.c
 create mode 100644 arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
 create mode 100644 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
 create mode 100644 arch/arm/plat-samsung/Kconfig
 create mode 100644 arch/arm/plat-samsung/Makefile
