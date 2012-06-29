From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jun 2012 18:33:49 +0100
Subject: [PATCH v2 0/2] Use architected timers for delay loop
Message-ID: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/105719.html

Thanks to Stephen, Rob and Russell for their comments. The changes since
version 1 are:

	- Fixed compilation breakage when arch timers are not configured
	- Use common definitions for mult/shift between C and asm

Tested on A15 and A9 vexpress platforms (i.e. with and without the
architected timers).

All comments welcome,

Will


Will Deacon (2):
  ARM: arch timer: implement read_current_timer and get_cycles
  ARM: delay: allow timer-based delay implementation to be selected

 arch/arm/include/asm/arch_timer.h      |    3 +
 arch/arm/include/asm/delay.h           |   32 ++++++++++++---
 arch/arm/include/asm/timex.h           |   10 +++--
 arch/arm/kernel/arch_timer.c           |   11 +++++
 arch/arm/kernel/armksyms.c             |    3 +-
 arch/arm/lib/Makefile                  |    2 +-
 arch/arm/lib/{delay.S => delay-loop.S} |   20 ++++-----
 arch/arm/lib/delay.c                   |   66 ++++++++++++++++++++++++++++++++
 arch/arm/mach-sa1100/sleep.S           |    8 ++--
 9 files changed, 126 insertions(+), 29 deletions(-)
 rename arch/arm/lib/{delay.S => delay-loop.S} (81%)
 create mode 100644 arch/arm/lib/delay.c

-- 
1.7.4.1
