From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 4 Nov 2012 18:28:11 +0100
Subject: [GIT PULL] Integrator & Versatile IRQchip changes
Message-ID: <CACRpkdY8_Bdd3_m85ucCSP2Sog4a0BoJM93z=JLFWz9pO3p=Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this is a set of three irq cleanup/movement patches that affect the FPGA
IRQ chip make the integrator a better example of how irq descriptors
should be treated. As I suspect there may be more irqchip drivers moving
out of arch/arm I figured that pushing these through ARM SoC was the
best thing.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-irq

for you to fetch changes up to 2389d5014342e9535aad212d0c68d439aaf534ba:

  ARM: plat-versatile: move FPGA irq driver to drivers/irqchip
(2012-11-04 18:09:12 +0100)

----------------------------------------------------------------
This provides the following Integrator refactorings:
- Switch the FPGA IRQ controller to use the simple IRQ domain
- Get rid of preallocated IRQ descriptors on the Integrator
- Move the FPGA IRQ driver to drivers/irqchip

----------------------------------------------------------------
Linus Walleij (3):
      ARM: plat-versatile: use simple irqdomain for FPGA IRQ
      ARM: integrator: get rid of preallocated irq descriptors
      ARM: plat-versatile: move FPGA irq driver to drivers/irqchip

 arch/arm/Kconfig                                   |   4 +-
 arch/arm/mach-integrator/include/mach/irqs.h       | 109 ++++++++++-----------
 arch/arm/mach-integrator/integrator_ap.c           |   5 +-
 arch/arm/mach-integrator/integrator_cp.c           |   6 +-
 arch/arm/mach-versatile/core.c                     |   2 +-
 arch/arm/plat-versatile/Kconfig                    |   9 --
 arch/arm/plat-versatile/Makefile                   |   1 -
 drivers/irqchip/Kconfig                            |   9 +-
 drivers/irqchip/Makefile                           |   1 +
 .../irqchip/irq-versatile-fpga.c                   |  54 +++++-----
 .../linux/irqchip/versatile-fpga.h                 |   0
 11 files changed, 93 insertions(+), 107 deletions(-)
 rename arch/arm/plat-versatile/fpga-irq.c =>
drivers/irqchip/irq-versatile-fpga.c (83%)
 rename arch/arm/plat-versatile/include/plat/fpga-irq.h =>
include/linux/irqchip/versatile-fpga.h (100%)
