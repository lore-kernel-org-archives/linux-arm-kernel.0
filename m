From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 16:29:36 +0200
Subject: [PATCH 0/4] ARM: patches for randconfig build errors
Message-ID: <1345645780-2749-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've done some testing with the experimental multiplatform tree
and that uncovered a few preexisting bugs. Here are the ones
that should go through your tree. Please have a look to
see if the fixes make sense. I can put the patches in the patch
tracker or send you a pull request then.

	Arnd
---
Cc: Jon Medhurst <tixy@yxit.co.uk>
Cc: Leif Lindholm <leif.lindholm@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>

Arnd Bergmann (4):
  ARM: export read_current_timer
  ARM: allow PID_IN_CONTEXTIDR only for ARMv7
  ARM: export set_irq_flags/irq_set_chip_and_handler
  ARM: kprobes: make more tests conditional

 arch/arm/Kconfig.debug             |    1 +
 arch/arm/kernel/arch_timer.c       |    2 ++
 arch/arm/kernel/irq.c              |    2 ++
 arch/arm/kernel/kprobes-test-arm.c |    4 +++-
 kernel/irq/chip.c                  |    2 ++
 5 files changed, 10 insertions(+), 1 deletion(-)

-- 
1.7.10
