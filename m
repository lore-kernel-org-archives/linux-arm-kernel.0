From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 21 Mar 2013 22:28:27 +0100
Subject: [PATCH v9 0/3] ARM: ARMv7 (i.e. Cortex-M3) support
Message-ID: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is a new round of my Cortex-M3 patches. I think I addressed all of
Jonny's comments. Of course I'm still open for more feedback. I'd like
to see this series in next for some time.

To be usable these three patches depend on a few patches already sitting
in Russell's devel-stable plus support for the nvic irq controller that
I sent to this list with Message-Id:
1363612826-15623-1-git-send-email-u.kleine-koenig at pengutronix.de.
And platform support is missing of course.

I have platform support for Energy Micro's DK3750 development board that
can be found at

	git://git.pengutronix.de/git/ukl/linux.git efm32

. There is also a public BSP available. Just join #efm32 on freenode if
you're interested.

The individual patches have their own list of changes since v8. I'm not
sure they are complete, though.

Thanks for reading
Uwe

Catalin Marinas (1):
  ARM: Add base support for ARMv7-M

Uwe Kleine-K?nig (2):
  ARM: ARMv7-M: Add support for exception handling
  ARM: ARMv7-M: Allow the building of new kernel port

 arch/arm/Kconfig                   |   4 +-
 arch/arm/Kconfig-nommu             |   2 +-
 arch/arm/Makefile                  |   1 +
 arch/arm/include/asm/assembler.h   |  17 +++-
 arch/arm/include/asm/cputype.h     |  12 ++-
 arch/arm/include/asm/glue-cache.h  |  27 ++++++
 arch/arm/include/asm/glue-df.h     |   8 ++
 arch/arm/include/asm/glue-proc.h   |   9 ++
 arch/arm/include/asm/irqflags.h    |  22 +++--
 arch/arm/include/asm/ptrace.h      |   4 +
 arch/arm/include/asm/system_info.h |   1 +
 arch/arm/include/asm/v7m.h         |  47 +++++++++++
 arch/arm/include/uapi/asm/ptrace.h |  35 ++++++--
 arch/arm/kernel/Makefile           |   8 +-
 arch/arm/kernel/entry-common.S     |   4 +
 arch/arm/kernel/entry-header.S     | 120 ++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        | 142 +++++++++++++++++++++++++++++++
 arch/arm/kernel/head-nommu.S       |  10 ++-
 arch/arm/kernel/setup.c            |  17 +++-
 arch/arm/kernel/traps.c            |   2 +
 arch/arm/mm/Kconfig                |  22 ++++-
 arch/arm/mm/Makefile               |   2 +
 arch/arm/mm/cache-nop.S            |  53 ++++++++++++
 arch/arm/mm/nommu.c                |   2 +
 arch/arm/mm/proc-v7m.S             | 167 +++++++++++++++++++++++++++++++++++++
 25 files changed, 712 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/include/asm/v7m.h
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/cache-nop.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
1.8.2.rc2
