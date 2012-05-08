From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 8 May 2012 20:34:50 +0200
Subject: [PATCH v2 0/4] ARM: S3C24XX: move some code from plat to mach
 directory
Message-ID: <201205082034.50658.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Again the series of small moves of common code from the plat-s3c24xx to the
mach-s3c24xx directory.

This time without the wrong handled irq.c . Hopefully I'll get time to do it
properly later.

As the dev-uart.c move breaks the resource patch by Tushar Behera, I updated
the patch to fix the correct code and will submit it as a v2 to the resource
series.

Heiko Stuebner (4):
  ARM: S3C24XX: move plat-s3c24xx/cpu.c
  ARM: S3C24XX: move plat-s3c24xx/dev-uart.c into common.c
  ARM: S3C24XX: move common power-management code to mach-s3c24xx
  ARM: S3C24XX: move common clock init into common.c

 arch/arm/mach-s3c24xx/Makefile                     |    6 +
 .../{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c}  |   93 ++++++++++++++++++-
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c   |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c       |    0
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S    |    0
 arch/arm/plat-s3c24xx/Makefile                     |    6 -
 arch/arm/plat-s3c24xx/clock.c                      |   59 ------------
 arch/arm/plat-s3c24xx/dev-uart.c                   |  100 --------------------
 8 files changed, 98 insertions(+), 166 deletions(-)
 rename arch/arm/{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c} (75%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c (100%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S (100%)
 delete mode 100644 arch/arm/plat-s3c24xx/clock.c
 delete mode 100644 arch/arm/plat-s3c24xx/dev-uart.c

-- 
1.7.5.4
