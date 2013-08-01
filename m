From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 01 Aug 2013 23:00:09 +0100
Subject: [PATCH RFC 26/51] DMA-API: usb: ohci-sa1111: add a note about DMA
 masks
In-Reply-To: <20130801213420.GL23006@n2100.arm.linux.org.uk>
References: <20130801213420.GL23006@n2100.arm.linux.org.uk>
Message-ID: <E1V50un-0006ry-AB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a comment to explain why this driver doesn't call any of the DMA
API dma_set_mask() functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/host/ohci-sa1111.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 17b2a7d..aa9e127 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -185,6 +185,12 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
 	if (usb_disabled())
 		return -ENODEV;
 
+	/*
+	 * We don't call dma_set_mask_and_coherent() here because the
+	 * DMA mask has already been appropraitely setup by the core
+	 * SA-1111 bus code (which includes bug workarounds.)
+	 */
+
 	hcd = usb_create_hcd(&ohci_sa1111_hc_driver, &dev->dev, "sa1111");
 	if (!hcd)
 		return -ENOMEM;
-- 
1.7.4.4
