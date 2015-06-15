From: dave.long@linaro.org (David Long)
Date: Mon, 15 Jun 2015 12:42:57 -0400
Subject: [PATCH 0/2] Consolidate redundant register/stack access code
Message-ID: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Move duplicate and functionally equivalent code for accessing registers
and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
common kernel files.

Note: Help regression testing s390, hexagon, and sh would be appreciated.
      Powerpc builds but I have not verified the functionality.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

 arch/arm/include/asm/ptrace.h          |  6 ---
 arch/arm/kernel/ptrace.c               | 72 +---------------------------------
 arch/hexagon/include/uapi/asm/ptrace.h |  3 --
 arch/powerpc/include/asm/ptrace.h      | 38 ------------------
 arch/powerpc/kernel/ptrace.c           | 39 +-----------------
 arch/s390/include/asm/ptrace.h         |  3 --
 arch/s390/kernel/ptrace.c              | 70 ++++++++++-----------------------
 arch/sh/include/asm/ptrace.h           | 44 ---------------------
 arch/sh/kernel/Makefile                |  2 +-
 arch/sh/kernel/ptrace.c                | 33 ----------------
 arch/sh/kernel/ptrace_32.c             |  2 +-
 arch/sh/kernel/ptrace_64.c             |  2 +-
 arch/x86/include/asm/ptrace.h          | 37 -----------------
 arch/x86/kernel/ptrace.c               | 39 +-----------------
 include/linux/ptrace.h                 | 51 ++++++++++++++++++++++++
 kernel/ptrace.c                        | 38 ++++++++++++++++++
 16 files changed, 116 insertions(+), 363 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

-- 
1.8.1.2
