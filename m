From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 May 2012 12:17:38 +0200
Subject: [PATCH 0/3] dmaengine: at_hdmac: slave configuration
Message-ID: <cover.1336644470.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is composed of two cleanup patches and one "slave
configuration" patch. The last one uses configuration data passed through the
slave configuration API to setup the DMA controller.
Corresponding custom configuration is removed from the slave DMA private
structure and its use in the AT91 files. Header definitions are then moved
accordingly.

Nicolas Ferre (3):
  dmaengine: at_hdmac: remove some at_dma_slave comments
  dmaengine: at_hdmac: remove ATC_DEFAULT_CTRLA constant
  dmaengine: at_hdmac: take maxburst from slave configuration

 arch/arm/mach-at91/at91sam9g45_devices.c   |    1 -
 arch/arm/mach-at91/include/mach/at_hdmac.h |   26 --------------------------
 drivers/dma/at_hdmac.c                     |   15 +++++++--------
 drivers/dma/at_hdmac_regs.h                |   21 ++++++++++++++++++++-
 4 files changed, 27 insertions(+), 36 deletions(-)

-- 
1.7.10
