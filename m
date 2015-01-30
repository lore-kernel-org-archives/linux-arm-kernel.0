From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 30 Jan 2015 23:01:01 +0300
Subject: [PATCH v2 0/5] ARM: sa1100: implement irq driver as proper irqchip
 driver
Message-ID: <1422648066-7897-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a second attempt to move Intel StrongARM SA-11x0 IRQ driver
to drivers/irqchip/ place.

Changes since V1:

 - Added soc/sa1100/pwer.h header containing sa11x0_*_set_wake()
   prototypes.

 - Removed spinlock from mask/unmask functions

 - Minor whitespace changes.

The patches are based on my previous sa1100 patches that can be found
in Russell's for-next branch or in linux-next tree.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (5):
      ARM: sa1100: add platform functions to handle PWER settings
      ARM: sa1100: use sa11x0_sc_set_wake() in irq driver
      ARM: sa1100: use ioremapped memory to access SC registers
      irqchip: add sa1100 driver
      ARM: sa1100: drop irq driver

 arch/arm/mach-sa1100/Makefile                      |  2 +-
 arch/arm/mach-sa1100/generic.c                     | 37 ++++++++++
 drivers/irqchip/Makefile                           |  1 +
 .../irq.c => drivers/irqchip/irq-sa11x0.c          | 82 +++++++++++-----------
 include/linux/irqchip/irq-sa11x0.h                 | 16 +++++
 include/soc/sa1100/pwer.h                          | 15 ++++
 6 files changed, 110 insertions(+), 43 deletions(-)
 rename arch/arm/mach-sa1100/irq.c => drivers/irqchip/irq-sa11x0.c (66%)
 create mode 100644 include/linux/irqchip/irq-sa11x0.h
 create mode 100644 include/soc/sa1100/pwer.h
