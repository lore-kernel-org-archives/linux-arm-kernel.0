From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Jun 2013 16:57:03 +0200
Subject: [PATCH v2 0/2] dmaengine: at_hdmac: dt dma bindings update
Message-ID: <cover.1370615665.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

This is the patch series that has already been sent by Ludovic. It is the part
of the series that is dedicated to dmaengine. It is based on slave-dma/next. I
plan to submit an additional patch through arm-soc as the .dtsi updates are
dependent on a "cleanup" branch that is already stacked there.

This set of patches update the dt dma binding for at_hdmac since we need one
more parameter. In order to keep backward compatibility, an existing cell will
be used to add this parameter. Since the content of that cell will become a
magic value due to the concatenation of the two parameters, it is time to
use macros.

Thanks, best regards,

Ludovic Desroches (2):
  ARM: at91: dt: add header to define at_hdmac configuration
  at_hdmac: add FIFO configuration parameter to DMA DT binding

 .../devicetree/bindings/dma/atmel-dma.txt          |  7 ++++--
 drivers/dma/at_hdmac.c                             | 25 ++++++++++++++++----
 include/dt-bindings/dma/at91.h                     | 27 ++++++++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/dma/at91.h

-- 
1.8.2.2
