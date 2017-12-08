From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Fri, 8 Dec 2017 19:23:55 +0000
Subject: [PATCH 2/2] usb: musb: davinci: Pass file_mode in platform data
In-Reply-To: <20171208192355.32735-1-amery@hanoverdisplays.com>
References: <20171208192355.32735-1-amery@hanoverdisplays.com>
Message-ID: <20171208192355.32735-2-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as it was done for glues to allow setting the correct
fifo_mode when multiple MUSB glue layers are built-in

Fixes: 8a77f05aa39b ("usb: musb: Pass fifo_mode in platform data")
Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---
 drivers/usb/musb/davinci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 6571f9e59f8f..2632efd3d598 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -472,6 +472,7 @@ static const struct musb_platform_ops davinci_ops = {
 	.quirks		= MUSB_DMA_CPPI,
 	.init		= davinci_musb_init,
 	.exit		= davinci_musb_exit,
+	.fifo_mode	= 2,
 
 #ifdef CONFIG_USB_TI_CPPI_DMA
 	.dma_init	= cppi_dma_controller_create,
-- 
2.15.0
