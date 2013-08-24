From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 24 Aug 2013 21:44:33 +0800
Subject: [GIT PULL for v3.12] pull request from pxa git tree on mmp-irq
Message-ID: <CAN1soZwOH0hifZPgJp7btfbT8zn9OXHvy-+2zYqH3Mob4NAuFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof & Kevin,

Please pull mmp-irq branch from pxa git tree. It moved irq driver from
arch-mmp directory to irqchip directory, since it's used to support
multiplatform.

Best Regards
Haojian

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git tags/mmp-irq

for you to fetch changes up to 942f42214d693f98b6165d0202d21291f95bc37d:

  irqchip: mmp: avoid to include irqs head file (2013-08-24 17:45:47 +0800)

----------------------------------------------------------------
move irq driver out of mach-mmp to support multiplatform

----------------------------------------------------------------
Haojian Zhuang (4):
      irqchip: move mmp irq driver
      irqchip: mmp: support irqchip
      ARM: mmp: avoid to include head file in mach-mmp
      irqchip: mmp: avoid to include irqs head file

 arch/arm/Kconfig                                     |   1 +
 arch/arm/mach-mmp/Makefile                           |   2 +-
 arch/arm/mach-mmp/common.h                           |   1 -
 arch/arm/mach-mmp/include/mach/entry-macro.S         |  26 -------
 arch/arm/mach-mmp/include/mach/pxa168.h              |   1 +
 arch/arm/mach-mmp/include/mach/pxa910.h              |   1 +
 arch/arm/mach-mmp/mmp-dt.c                           |   8 +--
 arch/arm/mach-mmp/mmp2-dt.c                          |   8 +--
 arch/arm/mach-mmp/mmp2.c                             |   6 ++
 arch/arm/mach-mmp/pxa910.c                           |   7 ++
 drivers/irqchip/Makefile                             |   1 +
 arch/arm/mach-mmp/irq.c => drivers/irqchip/irq-mmp.c | 338
+++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 include/linux/irqchip/mmp.h                          |   6 ++
 13 files changed, 211 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/entry-macro.S
 rename arch/arm/mach-mmp/irq.c => drivers/irqchip/irq-mmp.c (63%)
 create mode 100644 include/linux/irqchip/mmp.h
