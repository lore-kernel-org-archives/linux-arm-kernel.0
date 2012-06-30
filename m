From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:52 +0200
Subject: [PATCH 00/10] ARM: S3C24XX gpio cleanups and fixes
Message-ID: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changset attempts to remove the users of an obsolete GPIO API in
Samsung S3C24XX platform and instead use the gpiolib API. It should
allow to drop some s3c24xx SoC specific headers as a next step and
simplify drivers/gpio/gpio-samsung.c driver a little. With the
introduction of the pinctrl GPIO driver we're going to have three
distinct GPIO APIs. Let's avoid this and drop the s3c24xx_gpio_*
functions, which have been scheduled for removal since about v2.6.35.

Additionally this changeset includes two minor fixes, for AC97 clock
and CAMIF interrupts.


Sylwester Nawrocki (10):
  ARM: S3C24XX: Free the backlight gpio requested in Mini2440 board code
  ARM: S3C24XX: Convert SMDK board file to the gpiolib API
  ARM: S3C24XX: Convert QT2410 board file to the gpiolib API
  ARM: S3C24XX: Convert the PM code to gpiolib API
  ARM: S3C24XX: Convert the touchscreen setup code to common GPIO API
  ARM: S3C24XX: Remove unused GPA, GPE, GPH bank GPIO aliases
  ARM: S3C24XX: Remove unused GPIO definitions for port J
  ARM: S3C24XX: Remove unused GPIO definitions for Openmoko GTA02 board
  ARM: S3C24XX: Correct AC97 clock control bit for S3C2440
  ARM: S3C24XX: Correct CAMIF interrupt definitions

 arch/arm/mach-s3c24xx/clock-s3c2440.c           |    2 +-
 arch/arm/mach-s3c24xx/common-smdk.c             |   20 ++++---
 arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h   |   21 -------
 arch/arm/mach-s3c24xx/include/mach/gta02.h      |   69 ----------------------
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |   17 +++++-
 arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h |   70 -----------------------
 arch/arm/mach-s3c24xx/mach-gta02.c              |    1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c           |    4 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c             |    6 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c             |    1 -
 arch/arm/mach-s3c24xx/pm-s3c2410.c              |   12 +++-
 arch/arm/mach-s3c24xx/pm-s3c2412.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2412.c                 |    1 -
 arch/arm/mach-s3c24xx/s3c244x.c                 |    1 -
 arch/arm/mach-s3c24xx/setup-ts.c                |    6 +--
 arch/arm/plat-samsung/devs.c                    |    3 +-
 16 files changed, 43 insertions(+), 192 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h

--
1.7.4.1
