From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jul 2012 20:13:52 +0200
Subject: [PATCH v5 0/3] Updated Cortex-M3 series
Message-ID: <1341512035-8173-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

now that 3.5 is about to come I invested the time to update the
beginning of the Cortex-M3 support.

Over all I rebased to v3.5-rc5 and addressed the comments by Russell.

It would be great to get these patches into next early after the merge
window for 3.6 closes to get them into 3.7. But I won't argue if they
made it into 3.6 ;-)

For reference, v4 of this series can be found at

	http://thread.gmane.org/gmane.linux.ports.arm.kernel/160510

Best regards
Uwe

Catalin Marinas (1):
  Cortex-M3: Add base support for Cortex-M3

Uwe Kleine-K?nig (2):
  ARM: make cr_alignment read-only #ifndef CONFIG_CPU_CP15
  Cortex-M3: Add support for exception handling

 arch/arm/include/asm/assembler.h   |   13 ++-
 arch/arm/include/asm/cp15.h        |   11 ++-
 arch/arm/include/asm/cputype.h     |    3 +
 arch/arm/include/asm/glue-cache.h  |   24 ++++++
 arch/arm/include/asm/glue-df.h     |    8 ++
 arch/arm/include/asm/glue-proc.h   |    9 ++
 arch/arm/include/asm/irqflags.h    |   22 +++--
 arch/arm/include/asm/processor.h   |    7 ++
 arch/arm/include/asm/ptrace.h      |   44 ++++++++--
 arch/arm/include/asm/system_info.h |    1 +
 arch/arm/kernel/asm-offsets.c      |    3 +
 arch/arm/kernel/entry-common.S     |    4 +
 arch/arm/kernel/entry-header.S     |  148 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        |  134 ++++++++++++++++++++++++++++++
 arch/arm/kernel/head-common.S      |    9 +-
 arch/arm/kernel/head-nommu.S       |    9 +-
 arch/arm/kernel/process.c          |    8 ++
 arch/arm/kernel/ptrace.c           |    3 +
 arch/arm/kernel/setup.c            |   13 ++-
 arch/arm/kernel/signal.c           |   13 +++
 arch/arm/kernel/sys_arm.c          |    1 +
 arch/arm/kernel/traps.c            |    2 +
 arch/arm/mm/alignment.c            |    2 +
 arch/arm/mm/mmu.c                  |   17 ++++
 arch/arm/mm/nommu.c                |    2 +
 arch/arm/mm/proc-v7m.S             |  161 ++++++++++++++++++++++++++++++++++++
 26 files changed, 649 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
1.7.10
