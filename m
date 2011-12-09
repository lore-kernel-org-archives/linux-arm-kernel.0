From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 09 Dec 2011 18:54:17 +0000
Subject: [PATCH 0/4] Add generic ARM ISA condition code check v3
Message-ID: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several locations in the kernel where software needs to
inspect the condition codes of trapped instructions. The original
bitmask implementation in the nwfpe code does this in an efficient
manner. This series breaks this code out of nwfpe/fpopcode.{ch} into
a standalone file for opcode operations, and contains additional
patches to kprobes and SWP eumlation to use this interface.

---

Set updated based on Will's feedback.

Leif Lindholm (4):
      Add generic ARM instruction set condition code checks.
      Use generic ARM instruction set condition code checks for nwfpe.
      Add condition code checking to SWP emulation handler.
      Use generic ARM instruction set condition code checks for kprobes.


 arch/arm/include/asm/opcodes.h |   20 +++++++++++
 arch/arm/kernel/Makefile       |    2 +
 arch/arm/kernel/kprobes-test.c |   66 ++++---------------------------------
 arch/arm/kernel/opcodes.c      |   72 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/swp_emulate.c  |   16 +++++++++
 arch/arm/nwfpe/entry.S         |    8 +++-
 arch/arm/nwfpe/fpopcode.c      |   26 --------------
 arch/arm/nwfpe/fpopcode.h      |    3 --
 8 files changed, 121 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes.h
 create mode 100644 arch/arm/kernel/opcodes.c

-- 
Signature
