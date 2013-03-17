From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 14:04:05 +0100
Subject: [PATCH v3 0/6] move s3c24xx-irq to drivers/irqchip and add dt support
Message-ID: <201303171404.06146.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In contrast to the previous versions, this variant gets rid of the irq
mappings in the dt files and provides individual compatible properties
for the different s3c24xx variants and therefore does not need to
introduce any new dt-properties.

It also now encapsulates the different sub-controllers inside a
node to make it possible to map the register region completely.

This series depends on the latest s3c24xx-irq changes currently in the
linux-samsung tree, and should therefore probably go thru there.

Tested on a s3c2416-based machine with preliminary dt support.

Heiko Stuebner (6):
  ARM: S3C24XX: move irq driver to drivers/irqchip
  irqchip: s3c24xx: fix comments on some camera interrupts
  irqchip: s3c24xx: fix irqlist of second s3c2416 controller
  irqchip: s3c24xx: use irq_create_mapping for parent irqs
  irqchip: s3c24xx: add devicetree support
  irqchip: s3c24xx: add s3c2450 interrupt definitions

 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   54 ++++
 arch/arm/mach-s3c24xx/Makefile                     |    2 +-
 drivers/irqchip/Makefile                           |    1 +
 .../irq.c => drivers/irqchip/irq-s3c24xx.c         |  293 +++++++++++++++++++-
 4 files changed, 342 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
 rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (80%)

-- 
1.7.2.3
