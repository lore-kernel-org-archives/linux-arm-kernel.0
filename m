From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 18 Oct 2013 21:54:05 +0100
Subject: [PULL REQ] Big Endian initial patch series
Message-ID: <20131018205405.GA28835@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series has been well tested and it would be great to get this
merged now. So here is the pull request:

The following changes since commit 8b5ede69d24db939f52b47effff2f6fe1e83e08b:

  powerpc/irq: Don't switch to irq stack from softirq stack (2013-10-07 14:19:39 -0700)

are available in the git repository at:

  ssh://git at git.baserock.org/delta/linux baserock/bjdooks/312-rc4/be/core-v2

for you to fetch changes up to 41c4973a021d57e85f49f2c43311f6a327be4fa9:

  ARM: cci driver need big endian fixes in asm code (2013-10-18 21:43:34 +0100)

----------------------------------------------------------------
Ben Dooks (18):
      ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
      ARM: asm: Add ARM_BE8() assembly helper
      ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
      ARM: set BE8 if LE in head code
      ARM: pl01x debug code endian fix
      ARM: twd: data endian fix
      ARM: smp_scu: data endian fixes
      ARM: highbank: enable big-endian
      ARM: mvebu: support running big-endian
      ARM: vexpress: add big endian support
      ARM: alignment: correctly decode instructions in BE8 mode.
      ARM: traps: use <asm/opcodes.h> to get correct instruction order
      ARM: module: correctly relocate instructions in BE8
      ARM: set --be8 when linking modules
      ARM: hardware: fix endian-ness in <hardware/coresight.h>
      ARM: net: fix arm instruction endian-ness in bpf_jit_32.c
      ARM: Correct BUG() assembly to ensure it is endian-agnostic
      ARM: kdgb: use <asm/opcodes.h> for data to be assembled as intruction

Victor Kamensky (5):
      ARM: atomic64: fix endian-ness in atomic.h
      ARM: signal: sigreturn_codes should be endian neutral to work in BE8
      ARM: mcpm: fix big endian issue in mcpm startup code
      ARM: tlb: ASID macro should give 32bit result for BE correct operation
      ARM: cci driver need big endian fixes in asm code

 arch/arm/Kconfig                          |  1 +
 arch/arm/Makefile                         |  1 +
 arch/arm/boot/compressed/head.S           |  9 ++--
 arch/arm/common/mcpm_head.S               |  2 +
 arch/arm/include/asm/assembler.h          |  7 +++
 arch/arm/include/asm/atomic.h             | 26 +++++-----
 arch/arm/include/asm/bug.h                | 10 ++--
 arch/arm/include/asm/hardware/coresight.h |  8 ++--
 arch/arm/include/asm/kgdb.h               |  3 +-
 arch/arm/include/asm/mmu.h                |  2 +-
 arch/arm/include/debug/pl01x.S            |  2 +
 arch/arm/kernel/Makefile                  |  3 +-
 arch/arm/kernel/entry-armv.S              |  5 +-
 arch/arm/kernel/entry-common.S            |  4 +-
 arch/arm/kernel/head.S                    | 12 +++++
 arch/arm/kernel/module.c                  | 57 +++++++++++++---------
 arch/arm/kernel/signal.c                  | 24 +---------
 arch/arm/kernel/sigreturn_codes.S         | 80 +++++++++++++++++++++++++++++++
 arch/arm/kernel/sleep.S                   |  1 +
 arch/arm/kernel/smp_scu.c                 | 14 +++---
 arch/arm/kernel/smp_twd.c                 | 24 +++++-----
 arch/arm/kernel/traps.c                   | 24 ++++++----
 arch/arm/mach-highbank/Kconfig            |  1 +
 arch/arm/mach-ixp4xx/Kconfig              |  4 --
 arch/arm/mach-mvebu/Kconfig               |  1 +
 arch/arm/mach-mvebu/coherency_ll.S        |  3 ++
 arch/arm/mach-mvebu/headsmp.S             |  4 ++
 arch/arm/mach-vexpress/Kconfig            |  1 +
 arch/arm/mm/Kconfig                       |  6 +++
 arch/arm/mm/abort-ev6.S                   |  5 +-
 arch/arm/mm/alignment.c                   |  9 +++-
 arch/arm/mm/proc-v6.S                     |  4 +-
 arch/arm/mm/proc-v7.S                     |  4 +-
 arch/arm/net/bpf_jit_32.c                 |  6 ++-
 arch/arm/plat-versatile/headsmp.S         |  2 +
 drivers/bus/arm-cci.c                     |  6 ++-
 36 files changed, 247 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm/kernel/sigreturn_codes.S

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
