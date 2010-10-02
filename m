From: robherring2@gmail.com (Rob Herring)
Date: Sat,  2 Oct 2010 09:34:43 -0500
Subject: [PATCH v2 0/3] ARM: add clock api to sp804 and smp_twd timers
Message-ID: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@smooth-stone.com>

Changes from v1:
Implement comments from Russell.
Use clk_get_sys to get twd clock.
Allow independent clocks for timer-sp clocksource and clockevent timers.

Rob Herring (3):
  ARM: move timer-sp.c from versatile to common
  ARM: timer-sp: support timer clock freq other than 1MHz
  ARM: twd_smp: add clock api support

 arch/arm/common/Makefile                        |    1 +
 arch/arm/{plat-versatile => common}/timer-sp.c  |   38 +++++++++++++++-------
 arch/arm/include/asm/hardware/timer-sp.h        |    2 +
 arch/arm/include/asm/smp_twd.h                  |    1 +
 arch/arm/kernel/smp_twd.c                       |   11 ++++++
 arch/arm/mach-integrator/integrator_cp.c        |    6 ++--
 arch/arm/mach-realview/core.c                   |    6 ++--
 arch/arm/mach-versatile/core.c                  |    6 ++--
 arch/arm/mach-vexpress/ct-ca9x4.c               |    6 ++--
 arch/arm/mach-vexpress/v2m.c                    |    6 ++--
 arch/arm/plat-versatile/Makefile                |    1 -
 arch/arm/plat-versatile/include/plat/timer-sp.h |    2 -
 12 files changed, 56 insertions(+), 30 deletions(-)
 rename arch/arm/{plat-versatile => common}/timer-sp.c (81%)
 create mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 delete mode 100644 arch/arm/plat-versatile/include/plat/timer-sp.h
