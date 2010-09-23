From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson9)
Date: Thu, 23 Sep 2010 19:49:53 +0200
Subject: [PATCH 0/4] U5500 mailbox driver and modem irq handler
Message-ID: <1285264197-9316-1-git-send-email-stefan.xk.nilsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a driver for the U5500 mailbox which is used
for modem communication. It also introduces a generic U5500 modem
IRQ handler which can be configured to handle different IRQs from
the modem.


Summary:
 arch/arm/mach-ux500/Kconfig                    |   14 +
 arch/arm/mach-ux500/Makefile                   |    2 +
 arch/arm/mach-ux500/cpu-db5500.c               |   88 ++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h |   14 +
 arch/arm/mach-ux500/include/mach/irqs-db5500.h |    1 +
 arch/arm/mach-ux500/include/mach/irqs.h        |   15 +-
 arch/arm/mach-ux500/include/mach/mbox.h        |   88 ++++
 arch/arm/mach-ux500/mbox.c                     |  567 ++++++++++++++++++++++++
 arch/arm/mach-ux500/modem_irq.c                |  139 ++++++
 9 files changed, 927 insertions(+), 1 deletions(-)

 create mode 100644 arch/arm/mach-ux500/include/mach/mbox.h
 create mode 100644 arch/arm/mach-ux500/mbox.c
 create mode 100644 arch/arm/mach-ux500/modem_irq.c
