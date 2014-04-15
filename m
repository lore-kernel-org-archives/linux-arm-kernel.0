From: sdu.liu@huawei.com (Liu Hua)
Date: Tue, 15 Apr 2014 19:06:05 +0800
Subject: [PATCH v3 0/2] change ARM linux memory layout to support 32 CPUs
Message-ID: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series change fixmap mapping region to suppport 32 CPUs.
Because the "top_pmd" covers 0xfffe0000 - 0xffffffff(2M). And part 
is used by vector table. So I move this region down to 0xffc00000
 - 0xffdffff. 


I have tested the patches on arma9(2 CPUs) and arma15(16 CPUs) platforms

Changes from v2:
---------------
- Removed two macros: FIX_KMAP_BEGIN and FIX_KMAP_END;
- Unchanged DMA mapping region related documentation; 

Changes from v1:
---------------
- changed documentation for ARM linux memory layout.
- moved fixmap mapping region, not just extended.


Liu Hua (2):
  ARM : fixmap : remove FIX_KMAP_BEGIN and FIX_KMAP_END
  ARM : change fixmap mapping region to support 32 CPUs

 Documentation/arm/memory.txt   |  2 +-
 arch/arm/include/asm/fixmap.h  | 21 ++++-----------------
 arch/arm/include/asm/highmem.h |  1 +
 arch/arm/mm/highmem.c          | 33 ++++++++++++++++++++++++---------
 arch/arm/mm/mmu.c              |  4 ++++
 5 files changed, 34 insertions(+), 27 deletions(-)

-- 
1.9.0
