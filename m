From: csmanjuvijay@gmail.com (csmanjuvijay at gmail.com)
Date: Wed,  7 Dec 2016 23:54:11 +0000
Subject: [PATCH] USB: OHCI: nxp: fix code warnings
Message-ID: <1481154851-20876-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <csmanjuvijay@gmail.com>

This patch will fix the checkpatch.pl following warnings:
WARNING: Missing a blank line after declarations
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/usb/host/ohci-nxp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 1843f04..6df8e2e 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -125,6 +125,7 @@ static inline void isp1301_vbus_off(void)
 static void ohci_nxp_start_hc(void)
 {
 	unsigned long tmp = __raw_readl(USB_OTG_STAT_CONTROL) | HOST_EN;
+
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
 	isp1301_vbus_on();
 }
@@ -132,6 +133,7 @@ static void ohci_nxp_start_hc(void)
 static void ohci_nxp_stop_hc(void)
 {
 	unsigned long tmp;
+
 	isp1301_vbus_off();
 	tmp = __raw_readl(USB_OTG_STAT_CONTROL) & ~HOST_EN;
 	__raw_writel(tmp, USB_OTG_STAT_CONTROL);
@@ -153,9 +155,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	}
 
 	isp1301_i2c_client = isp1301_get_client(isp1301_node);
-	if (!isp1301_i2c_client) {
+	if (!isp1301_i2c_client)
 		return -EPROBE_DEFER;
-	}
 
 	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
-- 
2.7.4
