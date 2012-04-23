From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Apr 2012 10:40:42 +0100
Subject: [GIT PULL v2] ARM: Remove the __ARCH_WANT_INTERRUPTS_ON_CTXSW
 definition
Message-ID: <20120423094042.GC28729@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please pull the context switching patches for ARM? There are
no generic changes this time as Ingo merged the scheduler hook
separately.

Thanks.


The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux.git intr-ctxsw

for you to fetch changes up to b9d4d42ad901cc848ac87f1cb8923fded3645568:

  ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs (2012-04-17 15:29:44 +0100)

----------------------------------------------------------------
Catalin Marinas (3):
      ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on ASID-capable CPUs
      ARM: Remove current_mm per-cpu variable
      ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on pre-ARMv6 CPUs

Will Deacon (1):
      ARM: Use TTBR1 instead of reserved context ID

 arch/arm/include/asm/mmu.h         |    7 ---
 arch/arm/include/asm/mmu_context.h |  104 +++++++++++++++++++++++++++---------
 arch/arm/include/asm/thread_info.h |    1 +
 arch/arm/mm/context.c              |   57 ++++++++++----------
 arch/arm/mm/proc-v7-2level.S       |    9 +---
 5 files changed, 110 insertions(+), 68 deletions(-)

-- 
Catalin
