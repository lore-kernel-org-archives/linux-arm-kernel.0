From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 1 Jun 2011 13:48:43 +0200
Subject: [PATCH 0/3] Fixes for breakage resulting from syscore_ops patch on
	s3c24xx
Message-ID: <201106011348.47145.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscore_ops patch from Rafael J. Wysocki introduced some small
glitches for the S3C24XX cpus resulting in compile errors.

Heiko Stuebner (3):
  Fix missing struct for s3c2410_dma_chan in s3c2410_dma_suspend_chan
  Move s3c24xx_irq_syscore_ops to plat-s3c24xx/irq.c
  remove the now empty mach-s3c2410/irq.c

 arch/arm/mach-s3c2410/Makefile |    1 -
 arch/arm/mach-s3c2410/irq.c    |   34 ----------------------------------
 arch/arm/plat-s3c24xx/dma.c    |    2 +-
 arch/arm/plat-s3c24xx/irq.c    |    6 ++++++
 4 files changed, 7 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/irq.c
