From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Mar 2011 17:34:30 -0600
Subject: [PATCH v3 0/7] ARM timer clock api support
Message-ID: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This patch series converts ARM sp804 timer and smp_twd timer to use the clock
api.

v3: Rebased to rmk's init_early clock init changes.
   
Applies to rmk's for-next branch.

Rob Herring (7):
  ARM: integrator cp: add sp804 clock
  ARM: realview: add sp804 clock
  ARM: versatile: add sp804 clock
  ARM: vexpress: add sp804 clock
  ARM: timer-sp: support timer clock freq other than 1MHz
  ARM: smp_twd: add clock api support
  ARM: vexpress: add smp_twd clock

 arch/arm/common/timer-sp.c               |   43 +++++++++++++++++++++---------
 arch/arm/include/asm/hardware/timer-sp.h |    4 +-
 arch/arm/include/asm/smp_twd.h           |    1 +
 arch/arm/kernel/smp_twd.c                |   14 +++++++++
 arch/arm/mach-integrator/integrator_cp.c |   12 ++++++--
 arch/arm/mach-realview/core.c            |   11 ++++++-
 arch/arm/mach-versatile/core.c           |   11 ++++++-
 arch/arm/mach-vexpress/ct-ca9x4.c        |   14 ++++++---
 arch/arm/mach-vexpress/v2m.c             |   11 ++++++-
 9 files changed, 92 insertions(+), 29 deletions(-)
