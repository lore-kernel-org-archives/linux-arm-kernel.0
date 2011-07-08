From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jul 2011 18:15:14 +0200
Subject: [PULL] arm-soc fixes for 3.0
Message-ID: <201107081815.14283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Another round of fixes from the arm-soc tree. The three patches for pxa are for
long-standing bugs and will go in the stable trees. The other two are fixing
fallout from the generic irqchip conversion.

	Arnd

---
The following changes since commit f1bb20a8365f6753e0f7b6e94981ca2b662bae13:

  Merge branch 'for-30-rc5/all-i2c' of git://git.fluff.org/bjdooks/linux (2011-07-07 16:29:29 -0700)

are available in the git repository at:

  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git fixes

Lei Wen (2):
      ARM: pxa910: correct nand pmu setting
      ARM: pxa168: correct nand pmu setting

Paul Parsons (1):
      ARM: pxa: fix PGSR register address calculation

Simon Guinot (1):
      genirq: replace irq_gc_ack() with {set,clr}_bit variants (fwd)

Wolfram Sang (1):
      arm: mach-vt8500: add forgotten irq_data conversion

 arch/arm/mach-davinci/irq.c      |    2 +-
 arch/arm/mach-mmp/pxa168.c       |    2 +-
 arch/arm/mach-mmp/pxa910.c       |    2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c   |    4 ++--
 arch/arm/mach-vt8500/irq.c       |   21 ++++++++++++---------
 arch/arm/plat-orion/gpio.c       |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c  |    2 +-
 arch/arm/plat-samsung/irq-uart.c |    2 +-
 include/linux/irq.h              |    3 ++-
 kernel/irq/generic-chip.c        |   18 ++++++++++++++++--
 10 files changed, 38 insertions(+), 20 deletions(-)
