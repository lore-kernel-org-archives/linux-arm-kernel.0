From: james.morse@arm.com (James Morse)
Date: Thu,  2 Nov 2017 12:12:33 +0000
Subject: [RESEND PATCH v4 0/9] SError rework (- RAS & IESB for firmware first
 support)
Message-ID: <20171102121242.8925-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is repost of the SError Rework bits of the bigger series [0].
None of these patches have changed since v3.

Thanks,

James


[0] https://www.spinics.net/lists/arm-kernel/msg612870.html


James Morse (8):
  arm64: explicitly mask all exceptions
  arm64: introduce an order for exceptions
  arm64: Move the async/fiq helpers to explicitly set process context
    flags
  arm64: Mask all exceptions during kernel_exit
  arm64: entry.S: Remove disable_dbg
  arm64: entry.S: convert el1_sync
  arm64: entry.S convert el0_sync
  arm64: entry.S: convert elX_irq

Xie XiuQi (1):
  arm64: entry.S: move SError handling into a C function for future
    expansion

 arch/arm64/Kconfig                 |  2 +-
 arch/arm64/include/asm/assembler.h | 46 ++++++++++++--------
 arch/arm64/include/asm/daifflags.h | 72 +++++++++++++++++++++++++++++++
 arch/arm64/include/asm/irqflags.h  | 40 ++++++------------
 arch/arm64/kernel/debug-monitors.c |  5 ++-
 arch/arm64/kernel/entry.S          | 86 ++++++++++++++++++++++----------------
 arch/arm64/kernel/hibernate.c      |  5 ++-
 arch/arm64/kernel/machine_kexec.c  |  4 +-
 arch/arm64/kernel/setup.c          |  8 ++--
 arch/arm64/kernel/signal.c         |  8 +++-
 arch/arm64/kernel/smp.c            | 12 ++----
 arch/arm64/kernel/suspend.c        |  7 ++--
 arch/arm64/kernel/traps.c          | 16 ++++++-
 arch/arm64/mm/proc.S               |  9 ++--
 14 files changed, 211 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm64/include/asm/daifflags.h

-- 
2.15.0.rc2
