From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 25 Mar 2013 22:26:20 +0100
Subject: [PATCH v5 0/7] move s3c24xx-irq to drivers/irqchip and add dt support
Message-ID: <201303252226.21402.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After more discussion with Arnd Bergmann on v4 it seems a better way to
handle the interrupt controllers inside the s3c24xx SoCs is to not have
separate controller nodes, but to bundle the controllers into one node
and access the individual controllers via interrupt descriptor of the
device nodes.

Therefore this series changes the interrupt descriptors to a format of
  <ctrl_num irq_num parent_num type>

It also improves the binding documentation to explain the interrupt
descriptor format better.

As always tested on a s3c2416 based machine for the dt and non-dt case
and depends on changes already in the linux-samsung tree.


Heiko Stuebner (7):
  ARM: S3C24XX: move irq driver to drivers/irqchip
  irqchip: s3c24xx: fix comments on some camera interrupts
  irqchip: s3c24xx: fix irqlist of second s3c2416 controller
  irqchip: s3c24xx: add irq_set_type callback for basic interrupt types
  irqchip: s3c24xx: globally keep track of the created intc instances
  irqchip: s3c24xx: make interrupt handling independent of irq_domain structure
  irqchip: s3c24xx: add devicetree support

 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   53 +++
 arch/arm/mach-s3c24xx/Makefile                     |    2 +-
 drivers/irqchip/Makefile                           |    1 +
 .../irq.c => drivers/irqchip/irq-s3c24xx.c         |  388 ++++++++++++++++----
 4 files changed, 373 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
 rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (78%)

-- 
1.7.10.4
