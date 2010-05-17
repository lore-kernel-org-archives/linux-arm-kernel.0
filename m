From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 02:52:47 +0100
Subject: pull request for s3c24xx gpio and s3c2416
Message-ID: <20100517015246.GR26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following to get the s3c24xx gpiolib conversion patches
and the s3c2416 core code (which depends on the gpiolib updates)

The following changes since commit 7ebd467551ed6ae200d7835a84bbda0dcadaa511:
  Linus Torvalds (1):
        Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-rmk/2635

Ben Dooks (33):
      ARM: S3C24XX: Add initial s3c_gpio configuration code
      ARM: S3C24XX: Add the gpio pull configuration for pull-up
      ARM: S3C24XX: Add extended GPIO used on S3C2443 and beyond
      ARM: H1940: Change h1940-bluetooth to use gpiolib API
      ARM: JIVE: Update mach-jive to use gpiolib API
      ARM: H1940: Change mach-h1940 to use gpiolib API
      ARM: QT2410: Update mach-qt2410 to use gpiolib API
      ARM: n30: Update mach-n30 to use gpiolib API
      ARM: BAST: Update mach-bast to use gpiolib API
      ARM: VR1000: Update mach-vr1000.c to use gpiolib API
      ARM: S3C2410: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Change s3c2410_gpio_pullupl(x, 1) to use s3c_gpio_cfgpull()
      ARM: S3C24XX: Drop s3c2410 specific s3c2410_gpio_cfgpin()
      ARM: S3C24XX: Remove s3c2410_gpio_setcfg()
      ARM: S3C24XX: Remove s3c2410_gpio_getpull()
      ARM: S3C24XX: Remove s3c2410_gpio_getirq()
      ARM: SAMSUNG: Add GPIO configuration read calls
      ARM: S3C24XX: Remove s3c2410_gpio_getcfg(), implement s3c_gpio_getcfg()
      ARM: mini2440: Move to using gpiolib API and s3c_gpio functions
      ARM: S3C2410: Remove the users of s3c2410_gpio_pullup()
      ARM: S3C24XX: Wrapper s3c2410_gpio_setpin and s3c2410_gpio_pullup()
      ARM: S3C24XX: Remove S3C2410_GPJ numbering
      ARM: S3C24XX: Remove _INP macros in <mach/regs-gpioj.h>
      ARM: SAMSUNG: Move S3C6400 PLL code to <plat/pll.h> for re-use
      ARM: SAMSUNG: Add s3c_disable_clocks() and tidy init+disable usage
      ARM: S3C24XX: Identify S3C2416 if S3C2412/S3C2413 built in
      ARM: S3C2443: Move parts of the clock code to common clock file
      ARM: S3C2416: Add basic clock support
      ARM: S3C2416: Add support for second HSMMC channel
      ARM: S3C2416: Add support for OHCI on SMDK2416
      ARM: S3C2416: Use s3c2440 style i2c controller
      ARM: S3C2413: Update GPIO pull-up support
      ARM: SAMSUNG: Update S3C2416 entry with S3C2450

Yauhen Kharuzhy (5):
      ARM: S3C: Add S3C2416 detection to uncompress code
      serial: Use s3c2440 driver for S3C2416 SoC
      ARM: S3C2416: Add S3C2416-specific registers definitions
      ARM: S3C2416: Add arch support
      ARM: S3C2416: Add initial support of SMDK2416

 arch/arm/Kconfig                                   |    7 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c2410/Kconfig                      |    1 +
 arch/arm/mach-s3c2410/h1940-bluetooth.c            |   32 +-
 arch/arm/mach-s3c2410/include/mach/dma.h           |    2 +-
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h      |   47 +-
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h      |   12 +
 arch/arm/mach-s3c2410/include/mach/irqs.h          |   25 +-
 arch/arm/mach-s3c2410/include/mach/map.h           |    5 +-
 arch/arm/mach-s3c2410/include/mach/regs-clock.h    |    2 +
 arch/arm/mach-s3c2410/include/mach/regs-dsc.h      |   36 ++
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |   45 ++
 arch/arm/mach-s3c2410/include/mach/regs-gpioj.h    |   36 --
 arch/arm/mach-s3c2410/include/mach/regs-irq.h      |   10 +
 .../mach-s3c2410/include/mach/regs-s3c2416-mem.h   |   30 ++
 arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h  |   24 +
 arch/arm/mach-s3c2410/include/mach/uncompress.h    |    4 +-
 arch/arm/mach-s3c2410/mach-amlm5900.c              |    5 +-
 arch/arm/mach-s3c2410/mach-bast.c                  |    9 +-
 arch/arm/mach-s3c2410/mach-h1940.c                 |   20 +-
 arch/arm/mach-s3c2410/mach-n30.c                   |    7 +-
 arch/arm/mach-s3c2410/mach-qt2410.c                |   10 +-
 arch/arm/mach-s3c2410/mach-vr1000.c                |    5 +-
 arch/arm/mach-s3c2410/s3c2410.c                    |    8 +
 arch/arm/mach-s3c2412/Kconfig                      |    3 +-
 arch/arm/mach-s3c2412/mach-jive.c                  |   26 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c              |    8 +-
 arch/arm/mach-s3c2416/Kconfig                      |   38 ++
 arch/arm/mach-s3c2416/Makefile                     |   19 +
 arch/arm/mach-s3c2416/clock.c                      |  135 ++++++
 arch/arm/mach-s3c2416/irq.c                        |  254 +++++++++++
 arch/arm/mach-s3c2416/mach-smdk2416.c              |  150 ++++++
 arch/arm/mach-s3c2416/s3c2416.c                    |  128 ++++++
 arch/arm/mach-s3c2440/Kconfig                      |    1 +
 arch/arm/mach-s3c2440/mach-mini2440.c              |   23 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c              |    9 +-
 arch/arm/mach-s3c2440/mach-osiris.c                |    5 +-
 arch/arm/mach-s3c2440/s3c2440.c                    |    8 +
 arch/arm/mach-s3c2443/Kconfig                      |    1 +
 arch/arm/mach-s3c2443/clock.c                      |  479 +-------------------
 arch/arm/mach-s3c64xx/gpiolib.c                    |    6 +
 arch/arm/mach-s3c64xx/include/mach/pll.h           |   35 +--
 arch/arm/mach-s5p6440/gpio.c                       |    5 +
 arch/arm/plat-s3c24xx/Kconfig                      |    7 +
 arch/arm/plat-s3c24xx/Makefile                     |    1 +
 arch/arm/plat-s3c24xx/common-smdk.c                |    9 +-
 arch/arm/plat-s3c24xx/cpu.c                        |   21 +
 arch/arm/plat-s3c24xx/gpio.c                       |  144 +-----
 arch/arm/plat-s3c24xx/gpiolib.c                    |   60 +++-
 arch/arm/plat-s3c24xx/include/plat/pll.h           |   25 +
 arch/arm/plat-s3c24xx/include/plat/s3c2416.h       |   31 ++
 arch/arm/plat-s3c24xx/include/plat/s3c2443.h       |   19 +
 arch/arm/plat-s3c24xx/pm.c                         |    9 +-
 arch/arm/plat-s3c24xx/s3c2410-clock.c              |   15 +-
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |  472 +++++++++++++++++++
 arch/arm/plat-s3c24xx/setup-i2c.c                  |    5 +-
 arch/arm/plat-s3c24xx/spi-bus0-gpe11_12_13.c       |   16 +-
 arch/arm/plat-s3c24xx/spi-bus1-gpd8_9_10.c         |   16 +-
 arch/arm/plat-s3c24xx/spi-bus1-gpg5_6_7.c          |   16 +-
 arch/arm/plat-samsung/clock.c                      |   15 +
 arch/arm/plat-samsung/gpio-config.c                |  103 ++++-
 arch/arm/plat-samsung/include/plat/clock.h         |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    1 +
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |   58 +++
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   11 +
 arch/arm/plat-samsung/include/plat/gpio-core.h     |    3 +
 arch/arm/plat-samsung/include/plat/pll6553x.h      |   51 ++
 drivers/serial/Kconfig                             |    7 +-
 68 files changed, 2016 insertions(+), 817 deletions(-)
 create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
 create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
 create mode 100644 arch/arm/mach-s3c2416/Kconfig
 create mode 100644 arch/arm/mach-s3c2416/Makefile
 create mode 100644 arch/arm/mach-s3c2416/clock.c
 create mode 100644 arch/arm/mach-s3c2416/irq.c
 create mode 100644 arch/arm/mach-s3c2416/mach-smdk2416.c
 create mode 100644 arch/arm/mach-s3c2416/s3c2416.c
 create mode 100644 arch/arm/plat-s3c24xx/include/plat/s3c2416.h
 create mode 100644 arch/arm/plat-s3c24xx/s3c2443-clock.c
 create mode 100644 arch/arm/plat-samsung/include/plat/pll6553x.h

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
