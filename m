From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 19:32:52 +0200
Subject: [PATCH 0/3] consolidate ARM refdesign LEDs
Message-ID: <1308763972-24716-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This creates a common LED trigger for the CPU activity LEDs in
the leds subsystem, and removes the custom code from RealView
and Versatile boards.

Inspired by Bryan Wu's LED consolidation work.

Linus Walleij (3):
  leds: create a trigger for ARM CPU activity
  mach-realview: retire custom LED code
  mach-versatile: retire custom LED code

 arch/arm/mach-realview/core.c            |   39 ----------
 arch/arm/mach-realview/core.h            |    2 -
 arch/arm/mach-realview/realview_eb.c     |    4 -
 arch/arm/mach-realview/realview_pb1176.c |    4 -
 arch/arm/mach-realview/realview_pb11mp.c |    4 -
 arch/arm/mach-realview/realview_pba8.c   |    4 -
 arch/arm/mach-realview/realview_pbx.c    |    4 -
 arch/arm/mach-versatile/core.c           |   42 -----------
 arch/arm/plat-versatile/leds.c           |   13 +++-
 drivers/leds/Kconfig                     |   15 ++++
 drivers/leds/Makefile                    |    1 +
 drivers/leds/ledtrig-arm-cpu.c           |  114 ++++++++++++++++++++++++++++++
 12 files changed, 139 insertions(+), 107 deletions(-)
 create mode 100644 drivers/leds/ledtrig-arm-cpu.c

-- 
1.7.3.2
