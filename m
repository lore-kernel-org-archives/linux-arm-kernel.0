From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 6 Feb 2013 00:10:53 +0100
Subject: [PATCH 0/6] ARM: S3C24XX: Move s3c2440 and s3c2442 into new irq
 structure
Message-ID: <201302060010.53929.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follows the formular laid out in the previous series, i.e. moving of the code,
changing of the init and creation of the mapping structure.

As I lack hardware for these arches, compile tested only. But as it is similar
to the architectures of the previous run, hopefully I didn't break anything.

Applies to current for-next of the linux-samsung tree, which includes the move
of irq.c to mach-s3c24xx.

Heiko Stuebner (6):
  ARM: S3C24XX: move s3c244x irq init to common irq code
  ARM: S3C24XX: create dedicated irq init functions for s3c2440 and s3c2442
  ARM: S3C24XX: move s3c2440 irqs to common irq code
  ARM: S3C24XX: integrate s3c2440 irqs into common init
  ARM: S3C24XX: transform s3c2442 irqs into new structure
  ARM: S3C24XX: transform s3c2440 irqs into new structure

 arch/arm/mach-s3c24xx/Makefile         |    4 +-
 arch/arm/mach-s3c24xx/common.h         |    4 +
 arch/arm/mach-s3c24xx/irq-s3c2440.c    |  128 ---------------------------
 arch/arm/mach-s3c24xx/irq-s3c244x.c    |  142 ------------------------------
 arch/arm/mach-s3c24xx/irq.c            |  148 ++++++++++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/mach-anubis.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c    |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c    |    7 +--
 arch/arm/mach-s3c24xx/mach-smdk2440.c  |    2 +-
 14 files changed, 163 insertions(+), 286 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c244x.c

-- 
1.7.2.3
