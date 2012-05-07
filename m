From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 7 May 2012 19:39:37 +0200
Subject: [PATCH 0/5] ARM: S3C24XX: move the easy parts to mach-s3c24xx from
 plat-s3c24xx
Message-ID: <201205071939.37433.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-s3c24xx still contains code that wasn't moved during the initial
consolidation of the s3c24xx mach directories.

This series moves the easy parts, that shouldn't require changes, to
mach-s3c24xx, following the layout example set out by s3c64xx.

Heiko Stuebner (5):
  ARM: S3C24XX: move plat-s3c24xx/cpu.c
  ARM: S3C24XX: move plat-s3c24xx/irq.c into common.c
  ARM: S3C24XX: move plat-s3c24xx/dev-uart.c into common.c
  ARM: S3C24XX: move common power-management code to mach-s3c24xx
  ARM: S3C24XX: move common clock init into common.c

 arch/arm/mach-s3c24xx/Makefile                     |    6 +
 .../{plat-s3c24xx/irq.c => mach-s3c24xx/common.c}  |  367 ++++++++++++++++++--
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c   |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c       |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S    |    0
 arch/arm/plat-s3c24xx/Makefile                     |    7 -
 arch/arm/plat-s3c24xx/clock.c                      |   59 ----
 arch/arm/plat-s3c24xx/cpu.c                        |  236 -------------
 arch/arm/plat-s3c24xx/dev-uart.c                   |  100 ------
 9 files changed, 336 insertions(+), 439 deletions(-)
 rename arch/arm/{plat-s3c24xx/irq.c => mach-s3c24xx/common.c} (64%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S (100%)
 delete mode 100644 arch/arm/plat-s3c24xx/clock.c
 delete mode 100644 arch/arm/plat-s3c24xx/cpu.c
 delete mode 100644 arch/arm/plat-s3c24xx/dev-uart.c

-- 
1.7.5.4
