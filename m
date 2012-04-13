From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 13 Apr 2012 16:05:46 +0200
Subject: [PATCH 0/4] ARM: replace custom consistent dma region with vmalloc
Message-ID: <1334325950-7881-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Recent changes to ioremap and unification of vmalloc regions on ARM
significantly reduces the possible size of the consistent dma region and
limited allowed dma coherent/writecombine allocations.

This experimental patch series replaces custom consistent dma regions
usage in dma-mapping framework in favour of generic vmalloc areas
created on demand for each coherent and writecombine allocations.

This patch is based on vanilla v3.4-rc2 release.

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (4):
  mm: vmalloc: use const void * for caller argument
  mm: vmalloc: export find_vm_area() function
  mm: vmalloc: add VM_DMA flag to indicate areas used by dma-mapping
    framework
  ARM: remove consistent dma region and use common vmalloc range for
    dma allocations

 arch/arm/include/asm/dma-mapping.h |    2 +-
 arch/arm/mm/dma-mapping.c          |  220 +++++++-----------------------------
 include/linux/vmalloc.h            |   10 +-
 mm/vmalloc.c                       |   31 ++++--
 4 files changed, 67 insertions(+), 196 deletions(-)

-- 
1.7.1.569.g6f426
