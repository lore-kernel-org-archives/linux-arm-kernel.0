From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 19 May 2015 01:11:34 +0300
Subject: [PATCH 0/2] ARM: sa1100: move irq driver to irqchip subsystem
Message-ID: <1431987096-16308-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These two patches finish my work on refactoring StrongARM SA-11x0 IRQ
driver into sane irqchip driver. As they depend on the patches already
accepted by Russell, I'd ask Thomas and/or Jason to Ack merging these
two patches through his tree.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (2):
      ARM: sa1100: prepare for moving irq driver to drivers/irqchip
      ARM: sa1100: move irq driver to drivers/irqchip/

 arch/arm/mach-sa1100/Makefile                              |  2 +-
 arch/arm/mach-sa1100/generic.c                             | 13 +++++++++++++
 drivers/irqchip/Makefile                                   |  1 +
 arch/arm/mach-sa1100/irq.c => drivers/irqchip/irq-sa11x0.c | 23 ++++++-----------------
 include/linux/irqchip/irq-sa11x0.h                         | 17 +++++++++++++++++
 5 files changed, 38 insertions(+), 18 deletions(-)
 rename arch/arm/mach-sa1100/irq.c => drivers/irqchip/irq-sa11x0.c (89%)
 create mode 100644 include/linux/irqchip/irq-sa11x0.h

-- 
With best wishes
Dmitry
