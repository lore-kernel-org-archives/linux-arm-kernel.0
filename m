From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue,  8 Jul 2014 13:16:10 -0700
Subject: [PATCH 0/6] LLVMLinux: Patches to enable the kernel to be compiled
 with clang/LLVM
Message-ID: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The LLVMLinux project aims to fully build the Linux kernel using both gcc and
clang (the C front end for the LLVM compiler infrastructure project). 

Clang only supports global named registers for non-allocatable registers like
the stack pointer. By centralizing the definition of current_stack_pointer, the
use of named registers for ARM remains largely unchanged while working for both
gcc and clang.

Behan Webster (6):
  arm: LLVMLinux: Add global named register current_stack_pointer for
    ARM
  arm: LLVMLinux: Use current_stack_pointer to calculate pt_regs address
  arm: LLVMLinux: Use current_stack_pointer for return_address
  arm: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
  arm: LLVMLinux: Calculate current_thread_info from
    current_stack_pointer
  arm: LLVMLinux: Use current_stack_pointer in unwind_backtrace

 arch/arm/include/asm/ptrace.h      | 5 ++---
 arch/arm/include/asm/thread_info.h | 9 +++++++--
 arch/arm/kernel/return_address.c   | 3 +--
 arch/arm/kernel/stacktrace.c       | 4 +---
 arch/arm/kernel/unwind.c           | 3 +--
 5 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
