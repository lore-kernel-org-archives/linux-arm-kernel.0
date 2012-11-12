From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 12 Nov 2012 14:46:29 +0100
Subject: [RFC PATCH 0/4] ARM: S3C24XX: irq move to drivers and first steps to
 dt
Message-ID: <201211121446.30167.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the way back from Barcelona I've started the move of the common
s3c24xx irq-code to drivers/irqchip and also modifications to enable
using it in a devicetree context at some point.

So, as I'm also missing the now probably famous tail-lights in this, it
would be cool to have some feedback if I'm moving in the right
direction here or am thinking wrong somewhere.

The whole endeavour is of course not finished yet, but should not
break anything in its current form.

Tested on a s3c2416 based machine.

Heiko Stuebner (4):
  ARM: S3C24XX: move s3c24xx-irq to drivers/irqchip
  irqchip: s3c24xx: add irq_domains for the interrupt registers
  ARM: S3C24XX: irq_data conversion for s3c_irqsub_* functions
  ARM: S3C24XX: First part converting irq code to use hwirq

 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-s3c24xx/irq-pm.c                     |    4 +-
 arch/arm/mach-s3c24xx/irq-s3c2412.c                |    6 +-
 arch/arm/mach-s3c24xx/irq-s3c2416.c                |   24 ++--
 arch/arm/mach-s3c24xx/irq-s3c2440.c                |    6 +-
 arch/arm/mach-s3c24xx/irq-s3c2443.c                |   30 ++--
 arch/arm/mach-s3c24xx/irq-s3c244x.c                |    6 +-
 arch/arm/plat-s3c24xx/Makefile                     |    1 -
 arch/arm/plat-samsung/include/plat/irq.h           |   18 ++--
 drivers/irqchip/Kconfig                            |    4 +
 drivers/irqchip/Makefile                           |    1 +
 .../irq.c => drivers/irqchip/irq-s3c24xx.c         |  147 ++++++++++++--------
 12 files changed, 144 insertions(+), 104 deletions(-)
 rename arch/arm/plat-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (84%)

-- 
1.7.2.3
