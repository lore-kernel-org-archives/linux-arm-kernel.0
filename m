From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 14 Aug 2015 18:12:54 +0200
Subject: [PATCH v2 0/2] Fix dma mapping when the cache is coherent
Message-ID: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fixes the dma mapping functions when the system is
cache coherent. The first one allows to fix an issue we have on Armada
375/38x with the PL310 that's why it is tagged for stable too.

The second one was suggested by Catalin. I put it in form and check
that it can be built, but I don't have the platform to test it, so it
definitely need someone to test it. I guess this one should also go to
the stable kernel but I don't know from which point.

Gregory

Gregory CLEMENT (2):
  ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
  ARM: dma-mapping: Fix the coherent case when iommu is used

 arch/arm/mm/dma-mapping.c | 103 +++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 34 deletions(-)

-- 
2.1.0
