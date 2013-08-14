From: behanw@converseincode.com (behanw at converseincode.com)
Date: Wed, 14 Aug 2013 17:37:40 -0400
Subject: [PATCH] Fix extern inline in ftrace.h for ARM
Message-ID: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The LLVMLinux Project is working to be able to build the Linux kernel with
clang/LLVM. With the release of LLVM 3.3 clang is now able to compile the Linux
kernel with a number of small patches (available from the LLVMLinux git repo).

This patch removes the use of "extern inline" from the ftrace code for ARM.
This same work has already been completed for ftrace on x86.  Amongst other
things this patch is required in order to have the Linux kernel to be able to
be compiled with both gcc and clang.

Mark Charlebois (1):
  ARM: LLVMLinux: Change "extern inline" to "gnu_inline" in ARM ftrace.h

 arch/arm/include/asm/ftrace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.2
