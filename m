From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 14:53:46 +0300
Subject: [PATCH 0/6] ARM: sa1100: Use MULTI_IRQ_HANDLER and IRQ domains
Message-ID: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch serie updates SA1100 to use MULTI_IRQ_HANDLER and IRQ domains
to handle IRQs. These patches introduce no changes in the way IRQs are
handled with respect to hardware, registers or IRQ numbers.

Dmitry Eremin-Solenikov (6):
      ARM: sa1100: switch to MULTI_IRQ_HANDLER
      ARM: sa1100: drop entry-macro.S
      ARM: sa1100: enable IRQ domains
      ARM: sa1100: introduce irqdomains support
      ARM: sa1100: merge IRQ 11 to "normal" irq domain
      ARM: sa1100: switch to hwirq usage

 arch/arm/Kconfig                                |   2 +
 arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 -------
 arch/arm/mach-sa1100/irq.c                      | 136 +++++++++++++++++-------
 3 files changed, 97 insertions(+), 82 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S
