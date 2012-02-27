From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Feb 2012 16:45:02 +0000
Subject: [GIT PULL] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW definition
Message-ID: <20120227164502.GF14234@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please pull the context switching patches for ARM, together
with a generic hook acked by PeterZ?

Thanks,

Catalin


The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux.git intr-ctxsw

for you to fetch changes up to 8cee1aabfcee0b0c8041bce04bbac0d22cd24cae:

  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs (2012-02-27 16:19:28 +0000)

----------------------------------------------------------------
Catalin Marinas (4):
      sched: Introduce the finish_arch_post_lock_switch() scheduler hook
      ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on ASID-capable CPUs
      ARM: Remove current_mm per-cpu variable
      ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs

Will Deacon (1):
      ARM: Use TTBR1 instead of reserved context ID

 arch/arm/include/asm/mmu_context.h |  104 +++++++++++++++++++++++++++---------
 arch/arm/include/asm/system.h      |    7 ---
 arch/arm/include/asm/thread_info.h |    1 +
 arch/arm/mm/context.c              |   57 ++++++++++----------
 arch/arm/mm/proc-v7-2level.S       |    9 +---
 kernel/sched/core.c                |    1 +
 kernel/sched/sched.h               |    3 +
 7 files changed, 114 insertions(+), 68 deletions(-)
