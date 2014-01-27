From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 27 Jan 2014 15:23:22 +0100
Subject: [RFC PATCH 0/2] dmaengine: at_hdmac: fix locking according to slave
 DMA requirements
In-Reply-To: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
References: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
Message-ID: <cover.1390832343.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an attempt to solve the locking issue that we currently have with the
Atmel at_hdmac dmaengine driver.
I tested these patches with several drivers but may need more coverage before
making them permanent...

Comments welcome.

Nicolas Ferre (2):
  dmaengine: at_hdmac: remove the call to issue_pending from tx_status
  dmaengine: at_hdmac: run callback function with no lock held nor
    interrupts disabled

 drivers/dma/at_hdmac.c | 128 +++++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 57 deletions(-)

-- 
1.8.2.2
