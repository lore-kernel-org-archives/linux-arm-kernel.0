From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 13 Jun 2013 10:39:37 +0200
Subject: [PATCH v3 0/2] dmaengine: at_hdmac: dt dma bindings update
Message-ID: <1371112779-22738-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Vinod,

This version removes the extra tab in patch 2/2 and add Arnd's ack.


Thanks

Regards

Ludovic


This set of patches update the dt dma binding for at_hdmac since we need one
more parameter. In order to keep backward compatibility, an existing cell will
be used to add this parameter. Since the content of that cell will become a
magic value due to the concatenation of the two parameters, it is time to
use macros.

v3:
- remove extra tab in patch 2/2
v2:
- rebased on slave-dma/next


Ludovic Desroches (2):
  ARM: at91: dt: add header to define at_hdmac configuration
  at_hdmac: add FIFO configuration parameter to DMA DT binding

 .../devicetree/bindings/dma/atmel-dma.txt          |  7 ++++--
 drivers/dma/at_hdmac.c                             | 25 ++++++++++++++++----
 include/dt-bindings/dma/at91.h                     | 27 ++++++++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/dma/at91.h

-- 
1.7.11.3
