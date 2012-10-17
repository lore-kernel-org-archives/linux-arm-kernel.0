From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Oct 2012 10:34:29 +0200
Subject: [PATCH v7 0/3] Yet another update for the Cortex-M3 series
Message-ID: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the only change since v6 is a rebase on top of v3.7-rc1 and so on Al
Viro's changes to kernel_execve().

These patches merge just fine into today's next and I put them into my
branch that Stephen will pick for the next next.

As before this doesn't make a functional M3 port as there are still some
missing items. If you want to see the code live I also updated the efm32
branch in my repository to be based on these patches. This code works,
but isn't suitable for mainline yet. You can run it on EnergyMicro's
efm32 devboard.

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
 arch/arm/include/asm/glue-cache.h  |   25 ++++++
 arch/arm/include/asm/glue-df.h     |    8 ++
 arch/arm/include/asm/glue-proc.h   |    9 ++
 arch/arm/include/asm/irqflags.h    |   22 +++--
 arch/arm/include/asm/processor.h   |    7 ++
 arch/arm/include/asm/ptrace.h      |    8 ++
 arch/arm/include/asm/system_info.h |    1 +
 arch/arm/include/uapi/asm/ptrace.h |   36 ++++++--
 arch/arm/kernel/asm-offsets.c      |    3 +
 arch/arm/kernel/entry-common.S     |    4 +
 arch/arm/kernel/entry-header.S     |  148 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        |  134 ++++++++++++++++++++++++++++++
 arch/arm/kernel/head-common.S      |    9 +-
 arch/arm/kernel/head-nommu.S       |    9 +-
 arch/arm/kernel/process.c          |    4 +
 arch/arm/kernel/ptrace.c           |    3 +
 arch/arm/kernel/setup.c            |   13 ++-
 arch/arm/kernel/traps.c            |    2 +
 arch/arm/mm/alignment.c            |    2 +
 arch/arm/mm/mmu.c                  |   17 ++++
 arch/arm/mm/nommu.c                |    2 +
 arch/arm/mm/proc-v7m.S             |  161 ++++++++++++++++++++++++++++++++++++
 25 files changed, 632 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
1.7.10.4
