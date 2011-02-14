From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 10:37:33 +0000
Subject: [PATCH 0/2] Preserve the VFP state across the fork() call
Message-ID: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFP state should be copied to the child process during the fork()
system call. This is important because the d16-d31 registers are callee
saved and the compiler may use them for preserving data across function
calls.


Catalin Marinas (2):
      ARM: Introduce THREAD_NOTIFY_COPY for copy_thread() hooks
      ARM: Preserve the VFP state during fork


 arch/arm/include/asm/thread_notify.h |    1 +
 arch/arm/kernel/process.c            |    2 ++
 arch/arm/vfp/vfpmodule.c             |   34 +++++++++++++++++++++++++++-------
 3 files changed, 30 insertions(+), 7 deletions(-)

-- 
Catalin
