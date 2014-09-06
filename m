From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  5 Sep 2014 17:06:10 -0700
Subject: [PATCH v2 0/7] LLVMLinux: Patches to enable the kernel to be compiled
 with clang/LLVM
Message-ID: <1409961977-11762-1-git-send-email-behanw@converseincode.com>
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

Mark Charlebois (1):
  arm: LLVMLinux: Use global stack register variable for percpu

 arch/arm/include/asm/percpu.h      | 4 ++--
 arch/arm/include/asm/ptrace.h      | 5 ++---
 arch/arm/include/asm/thread_info.h | 9 +++++++--
 arch/arm/kernel/return_address.c   | 3 +--
 arch/arm/kernel/stacktrace.c       | 4 +---
 arch/arm/kernel/unwind.c           | 3 +--
 6 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.1
