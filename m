From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 02 Sep 2013 12:24:23 +0100
Subject: [PULL REQUEST] big-endian updates for ARM
Message-ID: <52247567.8060504@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the last ack added, the following series is ready to be pulled.

The following changes since commit fa8218def1b1a16f0a410e2c1c767b4738cc81fa:

   Merge tag 'regmap-v3.11-rc7' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap (2013-08-27 
10:10:30 -0700)

are available in the git repository at:


   git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v3

for you to fetch changes up to 5217543fe4605fa91065acf5141d88949cd3da1e:

   ARM: signal: sigreturn_codes should be endian neutral to work in BE8 
(2013-09-02 11:53:53 +0100)

----------------------------------------------------------------
Ben Dooks (19):
       ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
       ARM: asm: Add ARM_BE8() assembly helper
       ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
       ARM: set BE8 if LE in head code
       ARM: pl01x debug code endian fix
       ARM: twd: data endian fix
       ARM: smp_scu: data endian fixes
       highbank: enable big-endian
       fix highbank
       mvebu: support running big-endian
       vexpress: add big endian support
       ARM: alignment: correctly decode instructions in BE8 mode.
       ARM: traps: use <asm/opcodes.h> to get correct instruction order
       ARM: module: correctly relocate instructions in BE8
       ARM: set --be8 when linking modules
       ARM: hardware: fix endian-ness in <hardware/coresight.h>
       ARM: net: fix arm instruction endian-ness in bpf_jit_32.c
       ARM: Correct BUG() assembly to ensure it is endian-agnostic
       ARM: kdgb: use <asm/opcodes.h> for data to be assembled as intruction

Victor Kamensky (2):
       ARM: atomic64: fix endian-ness in atomic.h
       ARM: signal: sigreturn_codes should be endian neutral to work in BE8

  arch/arm/Kconfig                            |  1 +
  arch/arm/Makefile                           |  1 +
  arch/arm/boot/compressed/head.S             |  9 ++--
  arch/arm/include/asm/assembler.h            |  7 +++
  arch/arm/include/asm/atomic.h               | 26 +++++------
  arch/arm/include/asm/bug.h                  | 10 +++--
  arch/arm/include/asm/hardware/coresight.h   |  8 ++--
  arch/arm/include/asm/hardware/debug-pl01x.S |  2 +
  arch/arm/include/asm/kgdb.h                 |  3 +-
  arch/arm/kernel/Makefile                    |  3 +-
  arch/arm/kernel/entry-armv.S                |  5 +--
  arch/arm/kernel/entry-common.S              |  4 +-
  arch/arm/kernel/head.S                      | 12 +++++
  arch/arm/kernel/module.c                    | 57 ++++++++++++++----------
  arch/arm/kernel/signal.c                    | 24 +---------
  arch/arm/kernel/sigreturn_codes.S           | 69 
+++++++++++++++++++++++++++++
  arch/arm/kernel/sleep.S                     |  1 +
  arch/arm/kernel/smp_scu.c                   | 14 +++---
  arch/arm/kernel/smp_twd.c                   | 24 +++++-----
  arch/arm/kernel/traps.c                     | 24 ++++++----
  arch/arm/mach-highbank/Kconfig              |  1 +
  arch/arm/mach-ixp4xx/Kconfig                |  4 --
  arch/arm/mach-mvebu/Kconfig                 |  1 +
  arch/arm/mach-mvebu/coherency_ll.S          |  3 ++
  arch/arm/mach-mvebu/headsmp.S               |  4 ++
  arch/arm/mach-vexpress/Kconfig              |  1 +
  arch/arm/mm/Kconfig                         |  6 +++
  arch/arm/mm/abort-ev6.S                     |  5 +--
  arch/arm/mm/alignment.c                     |  9 +++-
  arch/arm/mm/proc-v6.S                       |  4 +-
  arch/arm/mm/proc-v7.S                       |  4 +-
  arch/arm/net/bpf_jit_32.c                   |  6 ++-
  arch/arm/plat-versatile/headsmp.S           |  2 +
  33 files changed, 229 insertions(+), 125 deletions(-)
  create mode 100644 arch/arm/kernel/sigreturn_codes.S

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
