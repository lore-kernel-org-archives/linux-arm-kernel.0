From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Oct 2017 16:55:30 +0100
Subject: [PATCH 0/4] arm64: Changes to register and stack dumps
Message-ID: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This handful of patches makes some significant changes to how we print
register/stack dumps and brings us inline with recent changes to x86.
The main changes are that we no longer print out the 'Exception stack:'
section and PC/LR values are resolved to a symbol+offset format where
possible.

Feedback welcome.

Will

--->8

Mark Rutland (1):
  arm64: consistently log ESR and page table

Will Deacon (3):
  arm64: traps: Don't print stack or raw PC/LR values in backtraces
  arm64: traps: Pretty-print pstate in register dumps
  arm64: uapi: Remove PSR_Q_BIT

 arch/arm64/include/uapi/asm/ptrace.h |  1 -
 arch/arm64/kernel/process.c          | 24 ++++++++++---
 arch/arm64/kernel/traps.c            | 65 ++----------------------------------
 arch/arm64/mm/fault.c                |  7 ++--
 4 files changed, 28 insertions(+), 69 deletions(-)

-- 
2.1.4
