From: bryan.wu@canonical.com (Bryan Wu)
Date: Sun, 26 Jun 2011 06:10:00 +0800
Subject: [PATCH 0/4] Introduce a led trigger for CPU activity
Message-ID: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Linus Walleij's ARM LED consolidation work, this patchset introduce a
new generic led trigger for CPU not only for ARM but also for others.

For enabling CPU idle event, CPU arch code should call ledtrig_cpu() stub to
trigger idle start or idle end event.

These 4 patches is against 3.0-rc4 and build successfully for versatile and
realview.

Bryan Wu (2):
  leds: create a trigger for CPU activity
  ARM: use new LEDS CPU trigger stub to replace old one

Linus Walleij (2):
  mach-realview: retire custom LED code
  mach-versatile: retire custom LED code

 arch/arm/kernel/process.c                |    6 +-
 arch/arm/mach-realview/core.c            |   39 --------
 arch/arm/mach-realview/core.h            |    2 -
 arch/arm/mach-realview/realview_eb.c     |    4 -
 arch/arm/mach-realview/realview_pb1176.c |    4 -
 arch/arm/mach-realview/realview_pb11mp.c |    4 -
 arch/arm/mach-realview/realview_pba8.c   |    4 -
 arch/arm/mach-realview/realview_pbx.c    |    4 -
 arch/arm/mach-versatile/core.c           |   42 ---------
 arch/arm/plat-versatile/Kconfig          |    6 +-
 arch/arm/plat-versatile/leds.c           |   13 ++-
 drivers/leds/Kconfig                     |   10 ++
 drivers/leds/Makefile                    |    1 +
 drivers/leds/ledtrig-cpu.c               |  145 ++++++++++++++++++++++++++++++
 include/linux/leds.h                     |   15 +++
 15 files changed, 188 insertions(+), 111 deletions(-)
 create mode 100644 drivers/leds/ledtrig-cpu.c

-- 
1.7.4.1
