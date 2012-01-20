From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2012 17:42:26 +0000
Subject: [PATCH v3 0/6] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW
 definition
Message-ID: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 3 of the set of patches removing
__ARCH_WANT_INTERRUPTS_ON_CTXSW on ARM. The series was rebased on top of
3.3-rc1 and fixed the conflicts with the kernel/sched/ changes and the
ARM LPAE patches. There are no functional changes from v2. I plan to
push this to -next and get it ready for 3.4-rc1.

Question for Peter/Ingo - how do we merge the first patch that
introduces finish_arch_post_lock_switch? Do you pick it up or I can
merge it via rmk (with your ack)?

Thanks,

Catalin


Catalin Marinas (4):
  sched: Introduce the finish_arch_post_lock_switch() scheduler hook
  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on ASID-capable CPUs
  ARM: Remove current_mm per-cpu variable
  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs

Will Deacon (2):
  ARM: Use TTBR1 instead of reserved context ID
  ARM: Allow ASID 0 to be allocated to tasks

 arch/arm/include/asm/mmu_context.h |  104 +++++++++++++++++++++++++++---------
 arch/arm/include/asm/system.h      |    7 ---
 arch/arm/include/asm/thread_info.h |    1 +
 arch/arm/mm/context.c              |   63 +++++++++++-----------
 arch/arm/mm/proc-v7-2level.S       |    9 +---
 kernel/sched/core.c                |    1 +
 kernel/sched/sched.h               |    3 +
 7 files changed, 117 insertions(+), 71 deletions(-)
