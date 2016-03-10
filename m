From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Mar 2016 15:28:45 +0200
Subject: [PATCH v2 0/2] dmaengine: omap-dma: Fix polled completion
Message-ID: <1457616527-979-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on the discussion on the first version:
https://lkml.org/lkml/2016/2/25/167

I have fixed the omap_dma_tx_status() - first patch and added the second patch
to not disable the interrupts for memcpy so multiple transfers can be queued.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: omap-dma: Fix polled channel completion detection and
    handling
  dmaengine: omap-dma: Do not suppress interrupts for memcpy

 drivers/dma/omap-dma.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.7.2
