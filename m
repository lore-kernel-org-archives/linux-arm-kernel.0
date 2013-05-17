From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 May 2013 17:17:01 +0200
Subject: [PULL] add support for ARM-v7M
Message-ID: <20130517151701.GA8215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

The following changes since commit 73a09d212ec65b7068a283e6034fa05649d3d075:

  Merge branch 'for-next' of git://git.pengutronix.de/git/ukl/linux into devel-stable (2013-03-09 15:49:32 +0000)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git for-next

for you to fetch changes up to 6fae9cdafc92ae9958a3a45dd68205f72e3ad900:

  ARM: ARMv7-M: implement read_cpuid_ext (2013-05-17 11:44:40 +0200)

All but the last patch were in next since next-20130418 without issues.
The last patch fixes a problem in combination with 

	8164f7a (ARM: 7680/1: Detect support for SDIV/UDIV from ISAR0 register)

which triggers a WARN_ON without an implemented read_cpuid_ext.

The branch merges fine into v3.10-rc1 and I'd be happy if you pulled it
for 3.11-rc1. The only missing piece to be able to run a Cortex-M3 is
the irqchip driver that will go in via Thomas Gleixner and platform
specific stuff.

Best regards
Uwe
----------------------------------------------------------------
Catalin Marinas (1):
      ARM: Add base support for ARMv7-M

Uwe Kleine-K?nig (3):
      ARM: ARMv7-M: Add support for exception handling
      ARM: ARMv7-M: Allow the building of new kernel port
      ARM: ARMv7-M: implement read_cpuid_ext

 arch/arm/Kconfig                   |   4 +-
 arch/arm/Kconfig-nommu             |   2 +-
 arch/arm/Makefile                  |   1 +
 arch/arm/include/asm/assembler.h   |  17 +++-
 arch/arm/include/asm/cputype.h     |  44 ++++++++++-
 arch/arm/include/asm/glue-cache.h  |  27 +++++++
 arch/arm/include/asm/glue-df.h     |   8 ++
 arch/arm/include/asm/glue-proc.h   |   9 +++
 arch/arm/include/asm/irqflags.h    |  22 ++++--
 arch/arm/include/asm/ptrace.h      |   4 +
 arch/arm/include/asm/system_info.h |   1 +
 arch/arm/include/asm/v7m.h         |  44 +++++++++++
 arch/arm/include/uapi/asm/ptrace.h |  35 +++++++--
 arch/arm/kernel/Makefile           |   8 +-
 arch/arm/kernel/entry-common.S     |   4 +
 arch/arm/kernel/entry-header.S     | 124 +++++++++++++++++++++++++++++
 arch/arm/kernel/entry-v7m.S        | 143 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/head-nommu.S       |  10 ++-
 arch/arm/kernel/setup.c            |  17 +++-
 arch/arm/kernel/traps.c            |   8 ++
 arch/arm/mm/Kconfig                |  21 ++++-
 arch/arm/mm/Makefile               |   2 +
 arch/arm/mm/cache-nop.S            |  50 ++++++++++++
 arch/arm/mm/nommu.c                |   7 ++
 arch/arm/mm/proc-v7m.S             | 157 +++++++++++++++++++++++++++++++++++++
 25 files changed, 742 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/include/asm/v7m.h
 create mode 100644 arch/arm/kernel/entry-v7m.S
 create mode 100644 arch/arm/mm/cache-nop.S
 create mode 100644 arch/arm/mm/proc-v7m.S

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
