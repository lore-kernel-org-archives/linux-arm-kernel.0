From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:42:40 -0400
Subject: [PATCH] arm: LLVMLinux: Use __builtin_frame_address instead of named
 registers
Message-ID: <1378503762-7236-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The LLVMLinux Project is working to be able to build the Linux kernel with
clang/LLVM. With the release of LLVM 3.3 clang is now able to compile the Linux
kernel with a number of small patches (available from the LLVMLinux git repo).

Use the frame pointer to calculate the end of the stack for current_pt_regs()
The existing code uses the stack pointer to do this calculation.
Using the frame pointer yeilds the same value in a more portable way.
This change supports being able to compile the kernel with gcc and clang.

Behan Webster (1):
  arm: LLVMLinux: Calculate pt_regs address from fp

 arch/arm/include/asm/ptrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.1.2
