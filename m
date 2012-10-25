From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 25 Oct 2012 07:40:58 +0200
Subject: [GIT PULL] CMA and DMA-mapping fixes for v3.7-rc3
Message-ID: <1351143658-30902-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling some minor fixes for both CMA
(Contiguous Memory Allocator) and DMA-mapping framework for v3.7-rc3.

----------------------------------------------------------------

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes_for_linus

for you to fetch changes up to 4e85fb831aa210fd1c5e2cb7909ac203c1f5b67f:

  ARM: mm: Remove unused arm_vmregion priv field (2012-10-24 07:38:15 +0200)

----------------------------------------------------------------

This pull request consists mainly of a set of one-liner fixes and
cleanups for a few minor issues identified in both Contiguous Memory
Allocator code and ARM DMA-mapping subsystem.

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center

----------------------------------------------------------------

Patch summary:

Bob Liu (1):
      mm: cma: alloc_contig_range: return early for err path

Jingoo Han (1):
      ARM: dma-mapping: fix build warning in __dma_alloc()

Laurent Pinchart (4):
      drivers: dma-contiguous: Don't redefine SZ_1M
      drivers: dma-coherent: Fix typo in dma_mmap_from_coherent documentation
      drivers: cma: Fix wrong CMA selected region size default value
      ARM: mm: Remove unused arm_vmregion priv field

Ming Lei (1):
      ARM: dma-mapping: support debug_dma_mapping_error

 arch/arm/include/asm/dma-mapping.h |    1 +
 arch/arm/mm/dma-mapping.c          |    2 +-
 arch/arm/mm/vmregion.h             |    1 -
 drivers/base/Kconfig               |    2 +-
 drivers/base/dma-coherent.c        |    5 ++---
 drivers/base/dma-contiguous.c      |    5 +----
 mm/page_alloc.c                    |    2 +-
 7 files changed, 7 insertions(+), 11 deletions(-)
