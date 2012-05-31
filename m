From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 May 2012 08:38:19 +0100
Subject: [RFC PATCH 0/2] Remove at91 workaround from handle_IRQ
Message-ID: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a couple of patches that I wrote quickly to try and remove the
irq_finish hook from handle_IRQ on ARM. Currently, the hook is only used
by at91 in order to issue an EOI when using level_irq flow control.

This patch moves the at91 irq_chip to fasteoi flow control, removing the
need for the additional hook. Since I (a) don't know anything about at91
(the TRM I found for the IRQ controller is only a few pages long) and (b)
don't have a platform on which to test, this is very much an RFC series.

All comments welcome.

Will

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Will Deacon (2):
  ARM: at91: use EOI flow control for interrupt handling
  ARM: irq: remove unused irq_finish hook from core interrupt handling

 arch/arm/kernel/irq.c                  |   10 ----------
 arch/arm/mach-at91/include/mach/irqs.h |    8 --------
 arch/arm/mach-at91/irq.c               |   12 +++++++++---
 3 files changed, 9 insertions(+), 21 deletions(-)

-- 
1.7.3.4
