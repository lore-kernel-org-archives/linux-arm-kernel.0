From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Aug 2012 12:10:11 +0200
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
Message-ID: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the only changes compared to v5 (sent starting with Message-id:
1341512035-8173-1-git-send-email-u.kleine-koenig at pengutronix.de)
are that several debug pr_infos were dropped that I missed to remove
before. Thanks to Will Deacon for pointing out that problem.
Furthermore I rebased (trivially) to v3.5.

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
 arch/arm/kernel/traps.c            |    2 +
 arch/arm/mm/alignment.c            |    2 +
 arch/arm/mm/mmu.c                  |   17 ++++
 arch/arm/mm/nommu.c                |    2 +
 arch/arm/mm/proc-v7m.S             |  161 ++++++++++++++++++++++++++++++++++++
 24 files changed, 635 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
1.7.10.4
