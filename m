From: rabin@rab.in (Rabin Vincent)
Date: Sat, 28 Jan 2012 19:05:19 +0530
Subject: [PATCHv2 0/6] ARM: jump label support
Message-ID: <1327757725-10114-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
 - Use helper macros from Dave Martin's "ARM: Add generic instruction opcode
   manipulation helpers"
   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7278/1

 - Add compiler bug detection so the option is not visible on unsupported
   compilers

 - patch.c: use uintptr_t, h for half-word, call cache_ops_need_broadcast()
   only once

 - Split ftrace.c patch into two

 - Remove nop instruction; use mov r0, r0 instead

Rabin Vincent (6):
  ARM: ftrace: remove useless memory checks
  ARM: ftrace: use canonical Thumb-2 wide instruction format
  ARM: extract out insn generation code from ftrace
  ARM: extract out code patch function from kprobes
  jump label: detect %c support for ARM
  ARM: add jump label support

 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/jump_label.h |   41 +++++++++++++++++
 arch/arm/kernel/Makefile          |    9 +++-
 arch/arm/kernel/ftrace.c          |   90 +++++++++---------------------------
 arch/arm/kernel/insn.c            |   61 +++++++++++++++++++++++++
 arch/arm/kernel/insn.h            |   29 ++++++++++++
 arch/arm/kernel/jump_label.c      |   35 ++++++++++++++
 arch/arm/kernel/kprobes.c         |   86 ++++++++++-------------------------
 arch/arm/kernel/patch.c           |   73 ++++++++++++++++++++++++++++++
 arch/arm/kernel/patch.h           |    7 +++
 scripts/gcc-goto.sh               |   18 +++++++-
 11 files changed, 317 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm/include/asm/jump_label.h
 create mode 100644 arch/arm/kernel/insn.c
 create mode 100644 arch/arm/kernel/insn.h
 create mode 100644 arch/arm/kernel/jump_label.c
 create mode 100644 arch/arm/kernel/patch.c
 create mode 100644 arch/arm/kernel/patch.h

-- 
1.7.8.3
