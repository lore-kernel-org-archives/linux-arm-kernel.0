From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Jul 2012 08:19:17 +0200
Subject: [GIT PULL] CMA and DMA-mapping fixes for v3.5-rc7
Message-ID: <1342505957-31964-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I woukd like to ask you again for pulling another set of minor fixups
for recently merged Contiguous Memory Allocator and ARM DMA-mapping
changes. Those patches fix mysterious crashes on systems with CMA and
Himem enabled as well as some corner cases caused by typical off-by-one
bug. I'm sorry for a delay in sending this pull request which is caused
by my vacations.
 
The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

with the top-most commit 46c87852e99cf8ce97e207b11cde19085837e39c

  ARM: dma-mapping: modify condition check while freeing pages

are available in the git repository at:
  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git fixes-for-linus

Marek Szyprowski (1):
      mm: cma: fix condition check when setting global cma area

Prathyush K (1):
      ARM: dma-mapping: modify condition check while freeing pages

Rabin Vincent (1):
      mm: cma: don't replace lowmem pages with highmem

 arch/arm/mm/dma-mapping.c            |    4 ++--
 include/asm-generic/dma-contiguous.h |    2 +-
 mm/page_alloc.c                      |    7 ++++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center
