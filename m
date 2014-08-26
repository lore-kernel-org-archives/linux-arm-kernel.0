From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:44 +0100
Subject: [PATCH 0/6] Legacy instruction emulation for arm64
Message-ID: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the emulation of certain legacy
instructions from ARMv7 to the v8 port of Linux. More specifically the
patches add support for SWP and CP15 barrier instructions emulation.

Patch 1/6 fixes a bug in the SWP emulation in v7 where it incorrectly
assumes that SWP instruction implies barriers.

Patch 2/6 creates arm64 debugfs directory followed by 3-4/6 which add
infrastructure code to add support for undefined instruction hooks and
decoding condition codes.

Patch 5/6 adds support for SWP while 6/6 introduces CP15 barrier
instructions emulation. The emulation can be individually enabled as
well as there is support to disable this at runtime via debugfs.

All feedback welcome.

Thanks,
Punit

Punit Agrawal (6):
  arm: Fix in-correct barrier usage in SWP{B} emulation
  arm64: Create arch debugfs directory
  arm64: Add support for hooks to handle undefined instructions
  arm64: Add AArch32 instruction set condition code checks
  arm64: Port SWP/SWPB emulation support from arm
  arm64: Emulate CP15 Barrier instructions

 arch/arm/kernel/swp_emulate.c    |   15 --
 arch/arm64/Kconfig               |   56 +++++++
 arch/arm64/include/asm/insn.h    |   11 ++
 arch/arm64/include/asm/opcodes.h |    1 +
 arch/arm64/include/asm/traps.h   |   16 ++
 arch/arm64/kernel/Makefile       |    6 +-
 arch/arm64/kernel/insn.c         |   23 +++
 arch/arm64/kernel/setup.c        |   14 ++
 arch/arm64/kernel/traps.c        |   66 ++++++++
 arch/arm64/kernel/v7_obsolete.c  |  332 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 524 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/include/asm/opcodes.h
 create mode 100644 arch/arm64/kernel/v7_obsolete.c

-- 
1.7.10.4
