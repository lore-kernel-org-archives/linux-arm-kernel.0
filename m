From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:28:06 -0400
Subject: [PATCH 0/5] arm: LLVMLinux: Add current_stack_pointer
Message-ID: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The LLVMLinux Project is working to be able to build the Linux kernel with
clang/LLVM. With the release of LLVM 3.3 clang is now able to compile the Linux
kernel with a number of small patches (available from the LLVMLinux git repo).

These patches add a macro to get the current stack pointer which allows for a
single place in which to do so with ASM. Before this named registers (a gcc
extension) was used to get the stack pointer. Using ASM is a more portable way
of getting the stack pointer which works with both gcc and clang.  This macro
is of the same name used in the X86 arch.

Behan Webster (5):
  arm: LLVMLinux: Add current_stack_pointer macro for ARM
  arm: LLVMLinux: use current_stack_pointer for percpu
  arm: LLVMLinux: Use current_stack_pointer for return_address
  arm: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
  arm: LLVMLinux: Use current_stack_pointer in unwind_backtrace

 arch/arm/include/asm/percpu.h      | 4 ++--
 arch/arm/include/asm/thread_info.h | 9 +++++++++
 arch/arm/kernel/return_address.c   | 3 +--
 arch/arm/kernel/stacktrace.c       | 4 +---
 arch/arm/kernel/unwind.c           | 3 +--
 5 files changed, 14 insertions(+), 9 deletions(-)

-- 
1.8.1.2
