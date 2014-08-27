From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue, 26 Aug 2014 21:29:28 -0700
Subject: [PATCH V2 0/6] LLVMLinux: Patches to enable the kernel to be compiled
 with clang/LLVM
In-Reply-To: <20140826141608.GT23445@arm.com>
References: <20140826141608.GT23445@arm.com>
Message-ID: <1409113774-3172-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

This patch set moves from using locally defined named registers to access the
stack pointer to using a globally defined named register. This allows the code
to work both with gcc and clang.

The LLVMLinux project aims to fully build the Linux kernel using both gcc and
clang (the C front end for the LLVM compiler infrastructure project). 


Behan Webster (5):
  arm64: LLVMLinux: Add current_stack_pointer() for arm64
  arm64: LLVMLinux: Use current_stack_pointer in save_stack_trace_tsk
  arm64: LLVMLinux: Calculate current_thread_info from
    current_stack_pointer
  arm64: LLVMLinux: Use current_stack_pointer in kernel/traps.c
  arm64: LLVMLinux: Use global stack pointer in return_address()

Mark Charlebois (1):
  arm64: LLVMLinux: Use global stack register variable for aarch64

 arch/arm64/include/asm/percpu.h      | 4 ++--
 arch/arm64/include/asm/thread_info.h | 9 +++++++--
 arch/arm64/kernel/return_address.c   | 3 +--
 arch/arm64/kernel/stacktrace.c       | 3 +--
 arch/arm64/kernel/traps.c            | 3 +--
 5 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.9.1
