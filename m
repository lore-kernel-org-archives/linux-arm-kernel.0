From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 1 Aug 2014 11:58:53 +0800
Subject: [PATCH 0/3] move arm dual timer into drivers/clocksource
Message-ID: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kefeng Wang (3):
  ARM: remove unnecessary include arm_timer.h and timer-sp.h
  clocksource: move arm dual timer into drivers/clocksource
  clocksouce: sp804: use pr_fmt for logging

 arch/arm/Kconfig                          |   5 -
 arch/arm/common/Makefile                  |   1 -
 arch/arm/common/timer-sp.c                | 304 -----------------------------
 arch/arm/include/asm/hardware/arm_timer.h |  35 ----
 arch/arm/include/asm/hardware/timer-sp.h  |  23 ---
 arch/arm/mach-integrator/integrator_ap.c  |   2 +-
 arch/arm/mach-nspire/nspire.c             |   2 -
 arch/arm/mach-realview/core.c             |   5 +-
 arch/arm/mach-versatile/core.c            |   5 +-
 arch/arm/mach-vexpress/ct-ca9x4.c         |   3 -
 arch/arm/mach-vexpress/v2m.c              |   5 +-
 drivers/clocksource/Kconfig               |   7 +
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/timer-sp.c            | 307 ++++++++++++++++++++++++++++++
 include/clocksource/arm_timer.h           |  35 ++++
 include/clocksource/timer-sp.h            |  23 +++
 16 files changed, 383 insertions(+), 380 deletions(-)
 delete mode 100644 arch/arm/common/timer-sp.c
 delete mode 100644 arch/arm/include/asm/hardware/arm_timer.h
 delete mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 create mode 100644 drivers/clocksource/timer-sp.c
 create mode 100644 include/clocksource/arm_timer.h
 create mode 100644 include/clocksource/timer-sp.h

-- 
1.7.12.4
