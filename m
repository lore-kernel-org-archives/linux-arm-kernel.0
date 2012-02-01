From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Feb 2012 16:59:31 +0000
Subject: [PATCH v2 0/4] A7/A15 architected timer support
Message-ID: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the architected timers found in
Cortex-A7 and Cortex-A15. It adds local timer support, sched_clock,
global timer and DT support.

Tested on Cortex A15, based on Russell's for-armsoc branch plus my
local timer series.

Branch also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git arch_timers-for-rmk

* From the initial revision:
- Fixed global timer registration when an SMP kernel is running on UP
  with LOCAL_TIMERS enabled.

Marc Zyngier (4):
  ARM: local timers: Add A15 architected timer support
  ARM: architected timers: Add A15 specific sched_clock implementation
  ARM: architected timers: add DT support
  ARM: architected timers: add support for UP timer

 .../devicetree/bindings/arm/arch_timer.txt         |   23 ++
 arch/arm/Kconfig                                   |    7 +
 arch/arm/include/asm/arch_timer.h                  |   13 +
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/arch_timer.c                       |  363 ++++++++++++++++++++
 5 files changed, 407 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/arch_timer.c

-- 
1.7.7.1
