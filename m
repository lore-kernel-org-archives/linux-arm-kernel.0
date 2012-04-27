From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Apr 2012 13:55:52 +0100
Subject: [GIT PULL][PATCH v4 0/7] A7/A15 architected timer support
Message-ID: <1335531359-32128-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git timers-v3.4-rc4

This patch series adds support for the architected timers found in
Cortex-A7 and Cortex-A15. It adds local timer support, sched_clock,
global timer and DT support.

Tested on Cortex A15.

* From v3:
- Remove dependency on CONFIG_TICK_ONESHOT
- Tidy up error checking in the VE code
- Remove ad-hoc probing, making the driver DT only

* From v2:
- Allow the generic code to report that local timers cannot be used.
- Plug local timers into the VExpress DT code.

* From the initial revision:
- Fixed global timer registration when an SMP kernel is running on UP
  with LOCAL_TIMERS enabled.

Marc Zyngier (7):
  ARM: local timers: reserve local_timer_register() to SMP
  ARM: local timers: Add A15 architected timer support
  ARM: architected timers: Add A15 specific sched_clock implementation
  ARM: architected timers: add DT support
  ARM: architected timers: add support for UP timer
  ARM: vexpress: plug local timers into the DT code
  ARM: architected timers: remove support for non DT platforms

 .../devicetree/bindings/arm/arch_timer.txt         |   27 ++
 arch/arm/Kconfig                                   |    6 +
 arch/arm/include/asm/arch_timer.h                  |   19 +
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/arch_timer.c                       |  350 ++++++++++++++++++++
 arch/arm/kernel/smp.c                              |    3 +
 arch/arm/mach-vexpress/v2m.c                       |    8 +-
 7 files changed, 413 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/arch_timer.c

-- 
1.7.7.1
