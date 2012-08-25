From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 25 Aug 2012 14:20:40 +0200
Subject: [PATCH 0/3] Removal of obsolete s3c2410_* GPIO API
Message-ID: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short patch series converts remaining users of the s3c24xx SoC
specific gpiolib functions to the gpiolib API and finally removes
all s3c2410_* functions from drivers/gpio/gpio-samsung.c.

Sylwester Nawrocki (3):
  ARM: S3C24XX: Convert users of s3c2410_gpio_setpin to gpiolib API
  ARM: S3C24XX: Remove obsolete GPIO API declarations
  gpio-samsung: Remove now unused s3c2410_gpio* API

 arch/arm/mach-s3c24xx/mach-anubis.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-jive.c             |   12 ++--
 arch/arm/mach-s3c24xx/mach-mini2440.c         |    4 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c         |   22 +++---
 arch/arm/mach-s3c24xx/mach-osiris.c           |    7 +-
 arch/arm/plat-samsung/include/plat/gpio-fns.h |   97 -------------------------
 drivers/gpio/gpio-samsung.c                   |   40 ----------
 7 files changed, 25 insertions(+), 160 deletions(-)

--
1.7.4.1
