From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 11:23:53 +0900
Subject: [GIT PULL 4/5] Samsung irq-s3c24xx for v3.10
Message-ID: <016901ce1ada$d0516130$70f42390$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is finish the irq rework for s3c2412, s3c2440 and s3c2442 into the new
structure and eint0 to 3 on the s3c2412.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit ad38bdd15d5b97dcb1ffc46ea77c237e30312fbb:

  ARM: SAMSUNG: Remove unused plat-samsung/time.c (2013-03-05 20:19:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/irq-s3c24xx

for you to fetch changes up to d97fedef912832611b668fa7ece8e8ff54a6a590:

  gpio: samsung: fixes build warning with s3c2410_defconfig (2013-03-05 20:21:36
+0900)

----------------------------------------------------------------
Heiko Stuebner (13):
      ARM: S3C24XX: move s3c244x irq init to common irq code
      ARM: S3C24XX: create dedicated irq init functions for s3c2440 and s3c2442
      ARM: S3C24XX: move s3c2440 irqs to common irq code
      ARM: S3C24XX: integrate s3c2440 irqs into common init
      ARM: S3C24XX: transform s3c2442 irqs into new structure
      ARM: S3C24XX: transform s3c2440 irqs into new structure
      ARM: S3C24XX: use samsung_sync_wakemask in s3c2412 pm
      ARM: S3C24XX: move s3c2412 irq init to common code
      ARM: S3C24XX: modify s3c2412 irq init to initialize all irqs
      ARM: S3C24XX: transform s3c2412 irqs into new structure
      ARM: S3C24XX: include first 4 bits of the eint register in irq mapping
      ARM: S3C24XX: add soc_is_s3c2412 option
      ARM: S3C24XX: handle s3c2412 eints using new infrastructure

Kukjin Kim (1):
      gpio: samsung: fixes build warning with s3c2410_defconfig

 arch/arm/mach-s3c24xx/Kconfig             |    1 +
 arch/arm/mach-s3c24xx/Makefile            |    6 +-
 arch/arm/mach-s3c24xx/common.h            |    3 +
 arch/arm/mach-s3c24xx/include/mach/irqs.h |   58 ++++---
 arch/arm/mach-s3c24xx/irq-s3c2412.c       |  215 -----------------------
 arch/arm/mach-s3c24xx/irq-s3c2440.c       |  128 --------------
 arch/arm/mach-s3c24xx/irq-s3c244x.c       |  142 ----------------
 arch/arm/mach-s3c24xx/irq.c               |  264 ++++++++++++++++++++++++++++-
 arch/arm/mach-s3c24xx/mach-anubis.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c        |    2 +-
 arch/arm/mach-s3c24xx/mach-jive.c         |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c       |    7 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c     |    6 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c        |    2 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c        |    8 +
 arch/arm/plat-samsung/include/plat/cpu.h  |   10 ++
 drivers/gpio/gpio-samsung.c               |    8 +-
 23 files changed, 332 insertions(+), 544 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c244x.c
