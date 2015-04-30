From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Apr 2015 11:44:20 +0100
Subject: [PATCH 0/2] ARM: move Dual-Timer SP804 driver to drivers/clocksource
Message-ID: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
to move the driver out of arch/arm so that the code can be shared.

Regards,
Sudeep

Sudeep Holla (2):
  ARM: simplify timer initialisation and remove arm_timer.h inclusion
  ARM: move Dual-Timer SP804 driver to drivers/clocksource

 arch/arm/Kconfig                                            |  5 -----
 arch/arm/common/Makefile                                    |  1 -
 arch/arm/mach-integrator/integrator_ap.c                    |  1 -
 arch/arm/mach-nspire/nspire.c                               |  2 --
 arch/arm/mach-realview/core.c                               | 13 ++-----------
 arch/arm/mach-versatile/core.c                              | 13 ++-----------
 drivers/clocksource/Kconfig                                 |  5 +++++
 drivers/clocksource/Makefile                                |  1 +
 drivers/clocksource/timer-integrator-ap.c                   |  3 ++-
 .../hardware/arm_timer.h => drivers/clocksource/timer-sp.h  |  5 -----
 .../common/timer-sp.c => drivers/clocksource/timer-sp804.c  |  7 ++++---
 .../timer-sp.h => include/clocksource/timer-sp804.h         |  4 ++++
 12 files changed, 20 insertions(+), 40 deletions(-)
 rename arch/arm/include/asm/hardware/arm_timer.h => drivers/clocksource/timer-sp.h (93%)
 rename arch/arm/common/timer-sp.c => drivers/clocksource/timer-sp804.c (98%)
 rename arch/arm/include/asm/hardware/timer-sp.h => include/clocksource/timer-sp804.h (90%)

--
1.9.1
