From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:07 +0400
Subject: [PATCH v3 00/10] ARM: sa1100: improve irq handling
Message-ID: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Please review my third attempts on touching the sa1100 irq code. I have split
changes to a serie of small, simple and easy to review patches, with each one
touching only one aspect of irq handling code for sa1100.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (10):
      ARM: sa1100: switch to MULTI_IRQ_HANDLER
      ARM: sa1100: drop entry-macro.S
      ARM: sa1100: add platform functions to handle PWER settings
      arm: sa1100: use new functions that hide PWER access
      arm: sa1100: use ioremap'ped access instead of direct register access
      ARM: sa1100: enable IRQ domains
      arm: sa1100: introduce irqdomains support
      arm: sa1100: merge IRQ 11 to "normal" irq domain
      arm: sa1100: switch to hwirq usage
      ARM: locomo: don't clobber chip data for chained irq

 arch/arm/Kconfig                                |   2 +
 arch/arm/common/locomo.c                        |   4 +-
 arch/arm/mach-sa1100/generic.c                  |  21 ++
 arch/arm/mach-sa1100/generic.h                  |   2 +
 arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 ----
 arch/arm/mach-sa1100/irq.c                      | 263 ++++++++++++++++--------
 6 files changed, 209 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S
