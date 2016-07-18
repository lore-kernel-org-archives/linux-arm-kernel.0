From: james.morse@arm.com (James Morse)
Date: Mon, 18 Jul 2016 13:27:22 +0100
Subject: [stable:PATCH] valid_user_regs() backport
Message-ID: <1468844845-6129-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These three copies of the same patch backport dbd4d7ca563f
("arm64: Rework valid_user_regs") to the stable kernels listed on kernel.org
as far back as v3.16.

This patch fixed a userspace triggerable oops when userspace tries
to switch to a mode not supported by the kernel:
[  286.628508] Bad mode in Synchronous Abort handler detected, code 0x46000000 -- SVC (AArch32)
[  286.639625] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
[  286.648391] Hardware name: ARM Juno development board (r1) (DT)
[ ... ]
[  286.716784] Bad mode in Synchronous Abort handler detected, code 0x86000007 -- IABT (current EL)
[  286.725483] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
[  286.731513] Hardware name: ARM Juno development board (r1) (DT)
[ ... ]
[  286.840815] Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
[  286.846673] Modules linked in:
[  286.849699] CPU: 3 PID: 2072 Comm: inter Not tainted 4.4.14 #4504
[  286.855728] Hardware name: ARM Juno development board (r1) (DT)


Thanks,

James

 arch/arm64/include/asm/ptrace.h | 34 +++---------------
 arch/arm64/kernel/ptrace.c      | 80 +++++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/signal.c      |  4 +--
 arch/arm64/kernel/signal32.c    |  2 +-
 4 files changed, 86 insertions(+), 34 deletions(-)

-- 
2.8.0.rc3
