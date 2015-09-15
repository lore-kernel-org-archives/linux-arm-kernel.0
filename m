From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Sep 2015 15:29:26 +0200
Subject: [PATCH 0/4] at_xdmac: improvment and fixes for the interleaved mode
Message-ID: <1442323770-20266-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

This set of patches introduces the support of 'numf > 1' case for the
interleaved mode and several fixes: 'change block increment addressing mode'
and 'clean used descriptor' can be backported to 4.2.

Maxime,

I had some conflicts to merge on a mainline kernel the 'handle numf > 1'
patch. Can you check if I have not done a mistake. Thanks.

Regards

Ludovic Desroches (2):
  dmaengine: at_xdmac: fix memory leak in interleaved mode
  dmaengine: at_xdmac: clean used descriptor

Maxime Ripard (2):
  dmaengine: at_xdmac: handle numf > 1
  dmaengine: at_xdmac: change block increment addressing mode

 drivers/dma/at_xdmac.c | 121 ++++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 56 deletions(-)

-- 
2.5.0
