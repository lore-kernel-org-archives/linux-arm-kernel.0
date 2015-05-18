From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 13:44:42 +0100
Subject: [PATCH v2 0/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are ARM64 platforms(e.g. Juno) with SP804 timers, we need
to move the driver out of arch/arm so that the code can be shared.

Changes v1->v2:
	- introduces sp804_timer_disable and retained the integrator
	  and realview timer initialisation code as suggested by Russell

v1: https://lkml.org/lkml/2015/4/30/225

Regards,
Sudeep

Sudeep Holla (2):
  ARM: introduce sp804_timer_disable and remove arm_timer.h inclusion
  ARM: move Dual-Timer SP804 driver to drivers/clocksource

 arch/arm/Kconfig                                            |  5 -----
 arch/arm/common/Makefile                                    |  1 -
 arch/arm/mach-integrator/integrator_ap.c                    |  1 -
 arch/arm/mach-nspire/nspire.c                               |  2 --
 arch/arm/mach-realview/core.c                               | 13 ++++++-------
 arch/arm/mach-versatile/core.c                              | 12 ++++++------
 drivers/clocksource/Kconfig                                 |  5 +++++
 drivers/clocksource/Makefile                                |  1 +
 drivers/clocksource/timer-integrator-ap.c                   |  3 ++-
 .../hardware/arm_timer.h => drivers/clocksource/timer-sp.h  |  5 -----
 .../common/timer-sp.c => drivers/clocksource/timer-sp804.c  | 12 +++++++++---
 .../timer-sp.h => include/clocksource/timer-sp804.h         |  5 +++++
 12 files changed, 34 insertions(+), 31 deletions(-)
 rename arch/arm/include/asm/hardware/arm_timer.h => drivers/clocksource/timer-sp.h (93%)
 rename arch/arm/common/timer-sp.c => drivers/clocksource/timer-sp804.c (97%)
 rename arch/arm/include/asm/hardware/timer-sp.h => include/clocksource/timer-sp804.h (85%)

--
1.9.1
