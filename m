From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:18:01 +0900
Subject: [GIT PULL 02/10] 2nd irq-s3c24xx for v3.10
Message-ID: <516309D9.7000609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d98fedef912832611b668fa7ece8e8ff54a6a590:

   gpio: samsung: fixes build warning with s3c2410_defconfig (2013-03-05 
20:21:36 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/irq-s3c24xx-for-v3.10

for you to fetch changes up to f0774d41da0e607b70e54ecc50aeb6684f54c2b1:

   irqchip: s3c24xx: add devicetree support (2013-04-04 14:56:30 +0900)

----------------------------------------------------------------
s3c24xx irq cleanup and move into drivers/irqchip

----------------------------------------------------------------
Heiko Stuebner (12):
       ARM: S3C24XX: fix redundant checks in the irq mapping function
       ARM: S3C24XX: fix irq parent check
       ARM: S3C24XX: move s3c24xx_init_irq to s3c2410_init_irq
       ARM: S3C24XX: make s3c24xx_init_intc static
       ARM: S3C24XX: add handle_irq function
       ARM: S3C24XX: move irq driver to drivers/irqchip
       irqchip: s3c24xx: fix comments on some camera interrupts
       irqchip: s3c24xx: fix irqlist of second s3c2416 controller
       irqchip: s3c24xx: add irq_set_type callback for basic interrupt types
       irqchip: s3c24xx: globally keep track of the created intc instances
       irqchip: s3c24xx: make interrupt handling independent of 
irq_domain structure
       irqchip: s3c24xx: add devicetree support

  .../interrupt-controller/samsung,s3c24xx-irq.txt   |  53 +++
  arch/arm/Kconfig                                   |   1 +
  arch/arm/mach-s3c24xx/Makefile                     |   2 +-
  arch/arm/mach-s3c24xx/common.h                     |   1 +
  arch/arm/mach-s3c24xx/include/mach/entry-macro.S   |  70 ---
  arch/arm/mach-s3c24xx/mach-amlm5900.c              |   2 +-
  arch/arm/mach-s3c24xx/mach-bast.c                  |   2 +-
  arch/arm/mach-s3c24xx/mach-h1940.c                 |   7 +-
  arch/arm/mach-s3c24xx/mach-n30.c                   |   4 +-
  arch/arm/mach-s3c24xx/mach-otom.c                  |   2 +-
  arch/arm/mach-s3c24xx/mach-qt2410.c                |   2 +-
  arch/arm/mach-s3c24xx/mach-smdk2410.c              |   2 +-
  arch/arm/mach-s3c24xx/mach-tct_hammer.c            |   2 +-
  arch/arm/mach-s3c24xx/mach-vr1000.c                |   2 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |   1 -
  drivers/irqchip/Makefile                           |   1 +
  .../irq.c => drivers/irqchip/irq-s3c24xx.c         | 523 
++++++++++++++++-----
  17 files changed, 472 insertions(+), 205 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/entry-macro.S
  rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (75%)

-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
