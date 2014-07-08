From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 Jul 2014 13:46:35 +0300
Subject: [PATCH 0/3] ARM/dma: edma: Serve cyclic clients via high priority
 queue
Message-ID: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It is preferred that audio is served with the highest priority queue in order to
avoid delays in data transfer between memory and audio IP.

The following series will add an API to arch code to assign a channel to a given
queue.
The default queue is changed from 0 (highest priority) to lowest priority.
In the dmaengine driver we move the cyclic channel to queue0 (highest priority)
and move it back to default queue when the channel is terminated.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: edma: Set default queue to lowest priority
  ARM: edma: Add edma_assign_channel_eventq() to move channel to a give
    queue
  dma: edma: Serve cyclic (audio) channels with high priority queue

 arch/arm/common/edma.c             | 31 ++++++++++++++++++++++++++++++-
 drivers/dma/edma.c                 |  8 ++++++++
 include/linux/platform_data/edma.h |  2 ++
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.0.0
