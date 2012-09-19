From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:18:31 +0900
Subject: [GIT PULL 1/7] Samsung cleanup for v3.7
Message-ID: <099801cd96bd$15a45910$40ed0b30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here, there are cleanup patches for Samsung v3.7 and most of them are
related to cleanup Samsung specific gpio API.

If any problem, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-samsung

Jonghwan Choi (1):
      ARM: EXYNOS: cleanup unused code related to GPS

Sachin Kamat (2):
      ARM: S3C24XX: Use module_platform_driver macro in h1940-bluetooth.c
      ARM: S3C24XX: Use module_platform_driver macro in mach-osiris-dvs.c

Sylwester Nawrocki (4):
      ARM: S3C24XX: Convert users of s3c2410_gpio_setpin to gpiolib API
      ARM: S3C24XX: Remove obsolete GPIO API declarations
      gpio-samsung: Remove now unused s3c2410_gpio* API
      gpio: samsung: Update documentation

 Documentation/arm/Samsung-S3C24XX/GPIO.txt    |   82 +++++++---------------
 Documentation/arm/Samsung/GPIO.txt            |    8 +--
 arch/arm/mach-exynos/clock-exynos5.c          |    9 ---
 arch/arm/mach-exynos/include/mach/map.h       |    1 -
 arch/arm/mach-s3c24xx/h1940-bluetooth.c       |   14 +----
 arch/arm/mach-s3c24xx/mach-anubis.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-jive.c             |   12 ++--
 arch/arm/mach-s3c24xx/mach-mini2440.c         |    4 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c         |   22 +++---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c       |   13 +---
 arch/arm/mach-s3c24xx/mach-osiris.c           |    7 +-
 arch/arm/plat-samsung/include/plat/gpio-fns.h |   97
-------------------------
 drivers/gpio/gpio-samsung.c                   |   40 ----------
 13 files changed, 55 insertions(+), 257 deletions(-)
