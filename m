From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Aug 2015 18:19:43 +0200
Subject: [PATCH v3 0/2] Fix dma mapping when the cache is coherent
Message-ID: <1440605985-13446-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fixes the dma mapping functions when the system is
cache coherent. The first one allows to fix an issue we have on Armada
375/38x with the PL310 that's why it is tagged for stable too.

The second one was suggested by Catalin. I put it in form and (really)
checked that it can be built, but I don't have the platform to test
it. However it seems that currently nobody has a platform using it, at
least it would be good to test that it does not introduce a regression
for the platform using IOMMU.

Changelog

v2 -> v3:

 - Fix comments in patch 1 as suggested by Catalin.
 - Fix build issues in patch 2 (by using the multi_v7_defconfig +
   CONFIG_ROCKCHIP_IOMMU).
 - Add the arm_coherent_iommu_mmap_attrs function.

Gregory

Gregory CLEMENT (2):
  ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
  ARM: dma-mapping: Fix the coherent case when iommu is used

 arch/arm/mm/dma-mapping.c | 141 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 102 insertions(+), 39 deletions(-)

-- 
2.1.0
