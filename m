From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 17 Jan 2014 10:59:25 +0800
Subject: [PATCH 2/2] USB: at91: using USBA_NR_DMAS for DMA channels
In-Reply-To: <1389927565-22477-1-git-send-email-voice.shen@atmel.com>
References: <1389927565-22477-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1389927565-22477-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the SoC is earlier than sama5d3 SoC, which have the same number
endpoints and DMAs. However for sama5d3 SoC, it has different number
for endpoints and DMAs. So, define USBA_NR_DMAs for DMA channels

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 drivers/usb/gadget/atmel_usba_udc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 7e67a81..5cded1c 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1661,7 +1661,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (dma_status) {
 		int i;
 
-		for (i = 1; i < USBA_NR_ENDPOINTS; i++)
+		for (i = 1; i < USBA_NR_DMAS; i++)
 			if (dma_status & (1 << i))
 				usba_dma_irq(udc, &udc->usba_ep[i]);
 	}
diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
index 2922db5..a70706e 100644
--- a/drivers/usb/gadget/atmel_usba_udc.h
+++ b/drivers/usb/gadget/atmel_usba_udc.h
@@ -210,7 +210,7 @@
 #define USBA_FIFO_BASE(x)	((x) << 16)
 
 /* Synth parameters */
-#define USBA_NR_ENDPOINTS	7
+#define USBA_NR_DMAS		7
 
 #define EP0_FIFO_SIZE		64
 #define EP0_EPT_SIZE		USBA_EPT_SIZE_64
-- 
1.8.5.2
