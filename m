From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 12 Sep 2017 13:44:19 +0300
Subject: [PATCH 0/5] dmaengine: core/edma/omap-dma: maximum SG len reporting
Message-ID: <20170912104424.18495-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Hi,

Both TI eDMA and sDMA have limitation on the number of bursts it can handle
within one trasnfer (CCNT in eDMA and CFN in sDMA are 16bit unsigned counters).

If the the length of the SG in the sglist is bigger than what can be supported
we either have corrupted data or failure in the setup phase.

Add device_get_max_len() callback to devices where they can report such length
restriction to client drivers so they can set up their SGlist that each
element's length is going to be within the supported range.

The first two patch is not strictly related to this issue, but it is needed that
both eDMA and sDMA will have valid max_burst length.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: edma: Implement protection for invalid max_burst
  dmaengine: omap-dma: Implement protection for invalid max_burst
  dmaengine: Support for querying maximum trasnfer length (of an SG
    element)
  dmaengine: edma: Implement device_get_max_len callback
  dmaengine: omap-dma: Implement device_get_max_len callback

 drivers/dma/edma.c        | 28 ++++++++++++++++++++++++++++
 drivers/dma/omap-dma.c    | 28 ++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 14 ++++++++++++++
 3 files changed, 70 insertions(+)

-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
