From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:31:56 -0600
Subject: [PATCH 0/7] ARM: add clock api to sp804 and smp_twd timers
Message-ID: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Russell,

Here is updated patch series based on your previous comments. As I mentioned,
the problem making the clock api mandatory for smp_twd is I don't know what the
frequency of the timer is on various platforms or an understanding of what 
their clock trees look like to do a proper implementation of the clocks. I did
add clocks for vexpress as I can test that platform.

Rob

Rob Herring (7):
  ARM: integrator cp: init clocks early and add sp804 clock
  ARM: realview: init clocks early and add sp804 clock
  ARM: versatile: init clocks early and add sp804 clock
  ARM: vexpress: init clocks early and add sp804 clock
  ARM: timer-sp: support timer clock freq other than 1MHz
  ARM: smp_twd: add clock api support
  ARM: vexpress: add smp_twd clock

 arch/arm/common/timer-sp.c               |   43 +++++++++++++++++++++---------
 arch/arm/include/asm/hardware/timer-sp.h |    4 +-
 arch/arm/include/asm/smp_twd.h           |    1 +
 arch/arm/kernel/smp_twd.c                |   11 +++++++
 arch/arm/mach-integrator/integrator_cp.c |   19 ++++++++++---
 arch/arm/mach-realview/core.c            |   16 +++++++----
 arch/arm/mach-realview/core.h            |    1 +
 arch/arm/mach-realview/realview_eb.c     |    1 +
 arch/arm/mach-realview/realview_pb1176.c |    1 +
 arch/arm/mach-realview/realview_pb11mp.c |    1 +
 arch/arm/mach-realview/realview_pba8.c   |    1 +
 arch/arm/mach-realview/realview_pbx.c    |    1 +
 arch/arm/mach-versatile/core.c           |   22 +++++++++++----
 arch/arm/mach-versatile/core.h           |    1 +
 arch/arm/mach-versatile/versatile_ab.c   |    1 +
 arch/arm/mach-versatile/versatile_pb.c   |    1 +
 arch/arm/mach-vexpress/core.h            |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c        |   27 ++++++++++++++-----
 arch/arm/mach-vexpress/v2m.c             |   18 +++++++++---
 19 files changed, 129 insertions(+), 42 deletions(-)
