From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 May 2015 10:29:45 +0100
Subject: [GIT PULL] arm64: post merge-window fixes for 4.1
Message-ID: <20150501092945.GC1561@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 fixes for 4.1. Not too much here, but
we've addressed a couple of nasty issues in the dma-mapping code as well
as adding the halfword and byte variants of load_acquire/store_release
following on from the CSD locking bug that you fixed in the core.

Thanks,

Will

--->8

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 8291fd04d86b97869bd34e796bcac3141b9d5432:

  arm64: perf: Fix the pmu node name in warning message (2015-04-30 12:11:30 +0100)

----------------------------------------------------------------
arm64 fixes:
- Fix perf devicetree warnings at probe time
- Fix memory leak in __dma_free()
- Ensure DMA buffers are always zeroed
- Show IRQ trigger in /proc/interrupts (for parity with ARM)
- Implement byte and halfword access for smp_{load_acquire,store_release}

----------------------------------------------------------------
Andre Przywara (1):
      arm64: add missing data types in smp_load_acquire/smp_store_release

Dean Nelson (1):
      arm64: add missing PAGE_ALIGN() to __dma_free()

Marek Szyprowski (1):
      arm64: dma-mapping: always clear allocated buffers

Sudeep Holla (1):
      ARM64: Enable CONFIG_GENERIC_IRQ_SHOW_LEVEL

Suzuki K. Poulose (1):
      arm64: perf: Fix the pmu node name in warning message

Will Deacon (1):
      arm64: perf: don't warn about missing interrupt-affinity property for PPIs

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/barrier.h | 16 ++++++++++++++++
 arch/arm64/kernel/perf_event.c   |  9 +++++++--
 arch/arm64/mm/dma-mapping.c      |  9 ++++-----
 4 files changed, 28 insertions(+), 7 deletions(-)
