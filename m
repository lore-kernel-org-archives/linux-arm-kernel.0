From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:08 +0200
Subject: [PATCH v3 13/20] usb: host: xhci-plat: Add support for the Armada 375
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-14-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the Armada 375 SoC which comes with an xhci controller. Currently
the quirk is the same that the Armada 380/385 one, but by introducing
a new compatible string it will allow to make the driver evolve
seamless.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/usb/host/xhci-plat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d12ba56f52da..09639962c0bb 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,6 +152,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 					"marvell,armada-380-xhci"))
 		xhci_mvebu_mbus_init_quirk(pdev);
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+					"marvell,armada-375-xhci"))
+		xhci_mvebu_mbus_init_quirk(pdev);
+
 	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -288,6 +292,7 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	{ .compatible = "generic-xhci" },
 	{ .compatible = "xhci-platform" },
 	{ .compatible = "marvell,armada-380-xhci"},
+	{ .compatible = "marvell,armada-375-xhci"},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
-- 
1.8.1.2
