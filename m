From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:00 +0200
Subject: [PATCH 07/14] USB: EHCI: ehci-mv: remove private_init
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-8-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's unused.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c           | 4 ----
 include/linux/platform_data/mv_usb.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 77a4ab1dcd07..705d1b43b2dd 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -203,9 +203,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		device_wakeup_enable(hcd->self.controller);
 	}
 
-	if (pdata->private_init)
-		pdata->private_init(ehci_mv->op_regs, ehci_mv->phy_regs);
-
 	dev_info(&pdev->dev,
 		 "successful find EHCI device with regs 0x%p irq %d"
 		 " working in %s mode\n", hcd->regs, hcd->irq,
@@ -260,7 +257,6 @@ static const struct platform_device_id ehci_id_table[] = {
 static void mv_ehci_shutdown(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct ehci_hcd_mv *ehci_mv = hcd_to_ehci_hcd_mv(hcd);
 
 	if (!hcd->rh_registered)
 		return;
diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index 98b7925f1a2d..c0f624aca81c 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -48,6 +48,5 @@ struct mv_usb_platform_data {
 	int	(*phy_init)(void __iomem *regbase);
 	void	(*phy_deinit)(void __iomem *regbase);
 	int	(*set_vbus)(unsigned int vbus);
-	int     (*private_init)(void __iomem *opregs, void __iomem *phyregs);
 };
 #endif
-- 
2.17.1
