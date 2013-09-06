From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:47:39 -0400
Subject: [PATCH] arm: LLVMLinux: Use __builtin_frame_address to get thread info
Message-ID: <1378504062-9117-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

The LLVMLinux Project is working to be able to build the Linux kernel with
clang/LLVM. With the release of LLVM 3.3 clang is now able to compile the Linux
kernel with a number of small patches (available from the LLVMLinux git repo).

Use the frame pointer to calculate the start of the stack for current_thread_info()
The existing code uses the stack pointer to do this calculation.
Using the frame pointer yeilds the same value in a portable way.
This change supports being able to compile the kernel with gcc and Clang.

Behan Webster (1):
  arm: LLVMLinux: Calculate current_thread_info from fp

 arch/arm/include/asm/thread_info.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.1.2
