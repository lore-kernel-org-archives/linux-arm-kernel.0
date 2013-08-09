From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 09 Aug 2013 20:11:32 +0900
Subject: [PATCH-RESEND 0/2] Support device_prep_dma_sg for pl330
Message-ID: <1376046694-2638-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support device_prep_dma_sg functionality for pl330 dmaengine
driver. The prep_dma_sg function prepares descriptors to transfer between src
and dest memory which consists of scatter/gather list. The patchset contains
code clean-up to eliminate duplications.

Chanho Park (2):
  dma: pl330: split off common code to give back descriptors
  dma: pl330: add pl330_prep_dma_sg to transfer from sglist to sglist

 drivers/dma/pl330.c |  209 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 157 insertions(+), 52 deletions(-)

-- 
1.7.9.5
