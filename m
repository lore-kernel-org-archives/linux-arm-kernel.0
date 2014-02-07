From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Feb 2014 17:33:32 +0000
Subject: [GIT PULL] arm64 fixes for 3.14
Message-ID: <20140207173324.GA4301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below for 3.14. Thanks.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 55834a773fe343912b705bef8114ec93fd337188:

  arm64: defconfig: Expand default enabled features (2014-02-07 17:17:28 +0000)

----------------------------------------------------------------
- Relax VDSO alignment requirements so that the kernel-picked one (4K)
  does not conflict with the dynamic linker's one (64K)
- VDSO gettimeofday fix
- Barrier fixes for atomic operations and cache flushing
- TLB invalidation when overriding early page mappings during boot
- Wired up new 32-bit arm (compat) syscalls
- LSM_MMAP_MIN_ADDR when COMPAT is enabled
- defconfig update
- Clean-up (comments, pgd_alloc).

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Invalidate the TLB when replacing pmd entries during boot
      arm64: compat: Wire up new AArch32 syscalls

Colin Cross (1):
      security: select correct default LSM_MMAP_MIN_ADDR on arm on arm64

Laura Abbott (1):
      arm64: Align CMA sizes to PAGE_SIZE

Mark Rutland (3):
      arm64: fix typo: s/SERRROR/SERROR/
      arm64: simplify pgd_alloc
      arm64: defconfig: Expand default enabled features

Nathan Lynch (2):
      arm64: vdso: fix coarse clock handling
      arm64: vdso: update wtm fields for CLOCK_MONOTONIC_COARSE

Vinayak Kale (1):
      arm64: add DSB after icache flush in __flush_icache_all()

Will Deacon (4):
      arm64: vdso: prevent ld from aligning PT_LOAD segments to 64k
      arm64: barriers: allow dsb macro to take option parameter
      arm64: atomics: fix use of acquire + release for full barrier semantics
      arm64: asm: remove redundant "cc" clobbers

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/configs/defconfig          | 18 +++++++++---
 arch/arm64/include/asm/atomic.h       | 53 ++++++++++++++++++++---------------
 arch/arm64/include/asm/barrier.h      |  2 +-
 arch/arm64/include/asm/cacheflush.h   |  1 +
 arch/arm64/include/asm/cmpxchg.h      | 17 +++++------
 arch/arm64/include/asm/esr.h          |  2 +-
 arch/arm64/include/asm/futex.h        | 10 ++++---
 arch/arm64/include/asm/kvm_arm.h      |  2 +-
 arch/arm64/include/asm/spinlock.h     | 10 +++----
 arch/arm64/include/asm/unistd32.h     |  5 +++-
 arch/arm64/kernel/kuser32.S           |  6 ++--
 arch/arm64/kernel/vdso.c              |  4 +--
 arch/arm64/kernel/vdso/Makefile       |  2 +-
 arch/arm64/kernel/vdso/gettimeofday.S |  7 ++++-
 arch/arm64/lib/bitops.S               |  3 +-
 arch/arm64/mm/dma-mapping.c           |  1 +
 arch/arm64/mm/mmu.c                   | 12 ++++++--
 arch/arm64/mm/pgd.c                   | 11 ++------
 security/Kconfig                      |  2 +-
 20 files changed, 102 insertions(+), 67 deletions(-)

-- 
Catalin
