From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Sep 2015 18:50:56 +0200
Subject: [PATCH v4 0/2] Fix dma mapping when the cache is coherent
Message-ID: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fixes the dma mapping functions when the system is
cache coherent. The first one allows to fix an issue we have on Armada
375/38x with the PL310 that's why it is tagged for stable too.

I was about ti submit it to Russell King's patch system but when I
rebased it on v4.3-rc1 I got a merge conflict due too the commit
21caf3a765b0 "ARM: 8398/1: arm DMA: Fix allocation from CMA for
coherent DMA". The resolution would be OK so unless I missed something
I will submit it to the patch system in a few days.

Thanks,

Gregory

Changelog

v3 -> v4:
 - Rebased on v4.3-rc1
 - Fix conflict with commit "21caf3a765b0 ARM: 8398/1: arm DMA: Fix
   allocation from CMA for coherent DMA"

v2 -> v3:

 - Fix comments in patch 1 as suggested by Catalin.
 - Fix build issues in patch 2 (by using the multi_v7_defconfig +
   CONFIG_ROCKCHIP_IOMMU).
 - Add the arm_coherent_iommu_mmap_attrs function.

Gregory CLEMENT (2):
  ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
  ARM: dma-mapping: Fix the coherent case when iommu is used

 arch/arm/mm/dma-mapping.c | 140 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 39 deletions(-)

-- 
2.1.0
