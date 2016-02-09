From: dave.long@linaro.org (David Long)
Date: Tue,  9 Feb 2016 00:38:55 -0500
Subject: [PATCH v3 0/2] Consolidate redundant register/stack access code
Message-ID: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Move duplicate and functionally equivalent code for accessing registers
and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
common kernel files.

I'm sending this out again (with updated distribution list) because v2
just never got pulled in, even though I don't think there were any
outstanding issues.

Changes since v1:
	Move the REG_OFFSET_NAME and REG_OFFSET_END macros to architecture-
	independent include file.

Changes since v2:
	No material changes, just merge up to v4.5-rc2.

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

David A. Long (2):
  Move the pt_regs_offset struct definition from arch to common include
    file
  Consolidate redundant register/stack access code

 arch/arm/include/asm/ptrace.h          |   6 --
 arch/arm/kernel/ptrace.c               |  74 +---------------
 arch/hexagon/include/uapi/asm/ptrace.h |   3 -
 arch/powerpc/include/asm/ptrace.h      |  38 --------
 arch/powerpc/kernel/ptrace.c           |  65 +++-----------
 arch/s390/include/asm/ptrace.h         |   3 -
 arch/s390/kernel/ptrace.c              |  69 +++++----------
 arch/sh/include/asm/ptrace.h           |  48 +---------
 arch/sh/kernel/Makefile                |   2 +-
 arch/sh/kernel/ptrace.c                |  33 -------
 arch/sh/kernel/ptrace_32.c             |  50 +++++------
 arch/sh/kernel/ptrace_64.c             | 154 ++++++++++++++++-----------------
 arch/x86/include/asm/ptrace.h          |  37 --------
 arch/x86/kernel/ptrace.c               |  93 ++++++--------------
 include/linux/ptrace.h                 |  54 ++++++++++++
 kernel/ptrace.c                        |  38 ++++++++
 16 files changed, 258 insertions(+), 509 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

-- 
2.5.0
