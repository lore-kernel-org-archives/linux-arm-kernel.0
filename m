From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 May 2017 18:18:47 +0100
Subject: [GIT PULL] arm64 2nd set of updates for 4.12
Message-ID: <20170511171844.GA27804@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 updates below. The mm/vmalloc.c change was acked
by Michal Hocko and the arch/arm one by Russell King. Thanks.

The following changes since commit 92f66f84d9695d07adf9bc987bbcce4bf9b8e87c:

  arm64: Fix the DMA mmap and get_sgtable API with DMA_ATTR_FORCE_CONTIGUOUS (2017-05-05 11:41:35 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 0c2cf6d9487cb90be6ad7fac66044dfa8e8e5243:

  arm64: Silence first allocation with CONFIG_ARM64_MODULE_PLTS=y (2017-05-11 14:43:40 +0100)

----------------------------------------------------------------
arm64 2nd set of updates for 4.12:

- Silence module allocation failures when CONFIG_ARM*_MODULE_PLTS is
  enabled. This requires a check for __GFP_NOWARN in alloc_vmap_area()

- Improve/sanitise user tagged pointers handling in the kernel

- Inline asm fixes/cleanups

----------------------------------------------------------------
Florian Fainelli (3):
      mm: Silence vmap() allocation failures based on caller gfp_flags
      ARM: Silence first allocation with CONFIG_ARM_MODULE_PLTS=y
      arm64: Silence first allocation with CONFIG_ARM64_MODULE_PLTS=y

Kristina Martsenko (4):
      arm64: traps: fix userspace cache maintenance emulation on a tagged pointer
      arm64: hw_breakpoint: fix watchpoint matching for tagged pointers
      arm64: entry: improve data abort handling of tagged pointers
      arm64: documentation: document tagged pointer stack constraints

Mark Rutland (6):
      arm64: xchg: hazard against entire exchange variable
      arm64: ensure extension of smp_store_release value
      arm64: uaccess: ensure extension of access_ok() addr
      arm64: armv8_deprecated: ensure extension of addr
      arm64: atomic_lse: match asm register sizes
      arm64: uaccess: suppress spurious clang warning

 Documentation/arm64/tagged-pointers.txt | 62 +++++++++++++++++++++++++--------
 arch/arm/kernel/module.c                | 11 ++++--
 arch/arm64/include/asm/asm-uaccess.h    |  9 +++++
 arch/arm64/include/asm/atomic_lse.h     |  4 +--
 arch/arm64/include/asm/barrier.h        | 20 ++++++++---
 arch/arm64/include/asm/cmpxchg.h        |  2 +-
 arch/arm64/include/asm/uaccess.h        | 13 +++----
 arch/arm64/kernel/armv8_deprecated.c    |  3 +-
 arch/arm64/kernel/entry.S               |  5 +--
 arch/arm64/kernel/hw_breakpoint.c       |  3 ++
 arch/arm64/kernel/module.c              |  7 +++-
 arch/arm64/kernel/traps.c               |  4 +--
 mm/vmalloc.c                            |  2 +-
 13 files changed, 107 insertions(+), 38 deletions(-)

-- 
Catalin
