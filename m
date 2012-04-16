From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Apr 2012 17:13:24 +0100
Subject: [PATCH v3 0/6] A7/A15 architected timer support
Message-ID: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the architected timers found in
Cortex-A7 and Cortex-A15. It adds local timer support, sched_clock,
global timer and DT support.

Tested on Cortex A15, based on v3.4-rc3. Branch also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git timers-v3.4-rc3

* From v2:
- Allow the generic code to report that local timers cannot be used.
- Plug local timers into the VExpress DT code.

* From the initial revision:
- Fixed global timer registration when an SMP kernel is running on UP
  with LOCAL_TIMERS enabled.

Marc Zyngier (6):
  ARM: local timers: reserve local_timer_register() to SMP
  ARM: local timers: Add A15 architected timer support
  ARM: architected timers: Add A15 specific sched_clock implementation
  ARM: architected timers: add DT support
  ARM: architected timers: add support for UP timer
  ARM: vexpress: plug local timers into the DT code

 .../devicetree/bindings/arm/arch_timer.txt         |   27 ++
 arch/arm/Kconfig                                   |    7 +
 arch/arm/include/asm/arch_timer.h                  |   31 ++
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/arch_timer.c                       |  364 ++++++++++++++++++++
 arch/arm/kernel/smp.c                              |    3 +
 arch/arm/mach-vexpress/v2m.c                       |    8 +-
 7 files changed, 440 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/arch_timer.c

-- 
1.7.7.1
