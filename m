From: leif.lindholm@arm.com (Leif Lindholm)
Date: Thu, 08 Dec 2011 17:31:33 +0000
Subject: [PATCH 0/4] Add generic ARM ISA condition code check
Message-ID: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several locations in the kernel where software needs to
inspect the condition codes of trapped instructions. The original
bitmask implementation in the nwfpe code does this in an efficient
manner. This series breaks this code out of nwfpe/fpopcode.{ch} into
a standalone file for opcode operations, and contains additional
patches to kprobes and SWP eumlation to use this interface.

---

Reworked based on feedback on RFC set submitted on 2011-11-25.

Leif Lindholm (4):
      Add generic ARM instruction set condition code checks.
      Use generic ARM instruction set condition code checks for nwfpe.
      Add condition code checking to SWP emulation handler.
      Use generic ARM instruction set condition code checks for kprobes.


 arch/arm/include/asm/opcodes.h |   20 ++++++++++++
 arch/arm/kernel/Makefile       |    2 +
 arch/arm/kernel/kprobes-test.c |   66 +++-----------------------------------
 arch/arm/kernel/opcodes.c      |   69 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/swp_emulate.c  |   12 +++++++
 arch/arm/nwfpe/entry.S         |    8 +++--
 arch/arm/nwfpe/fpopcode.c      |   26 ---------------
 arch/arm/nwfpe/fpopcode.h      |    3 --
 8 files changed, 113 insertions(+), 93 deletions(-)
 create mode 100644 arch/arm/include/asm/opcodes.h
 create mode 100644 arch/arm/kernel/opcodes.c

-- 
Signature
