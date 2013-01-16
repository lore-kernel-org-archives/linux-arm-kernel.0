From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 16 Jan 2013 16:31:21 +0100
Subject: [PATCH 0/2] ARM: dma-mapping: add highmem support for coherent
 allocation
Message-ID: <1358350284-6972-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the last missing piece to let us efficiently use large DMA
buffers on systems with lots of memory, which have support for himem
enabled. The first patch adds support for CMA regions placed in high
memory zones, the second one also enables allocations of individual
pages from high memory zone for IOMMU-mapped devices. Those two changes
let us to significantly save low memory for other tasks.

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (2):
  ARM: dma-mapping: add support for CMA regions placed in highmem zone
  ARM: dma-mapping: use himem for DMA buffers for IOMMU-mapped devices

 arch/arm/mm/dma-mapping.c |   70 +++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 18 deletions(-)

-- 
1.7.9.5
