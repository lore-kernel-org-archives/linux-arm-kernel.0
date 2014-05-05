From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon,  5 May 2014 10:34:25 +0530
Subject: [PATCH v4 2/4] usb: ehci-exynos: Use struct device instead of
 platform_device
In-Reply-To: <1399034855-9686-3-git-send-email-gautam.vivek@samsung.com>
References: <1399034855-9686-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1399266265-31839-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change to use struct device instead of struct platform_device
for some static functions.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---

Changes since v1:
 - none

 drivers/usb/host/ehci-exynos.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 7f425ac..4d763dc 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -50,9 +50,8 @@ struct exynos_ehci_hcd {
 
 #define to_exynos_ehci(hcd) (struct exynos_ehci_hcd *)(hcd_to_ehci(hcd)->priv)
 
-static void exynos_setup_vbus_gpio(struct platform_device *pdev)
+static void exynos_setup_vbus_gpio(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	int err;
 	int gpio;
 
@@ -88,7 +87,7 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	exynos_setup_vbus_gpio(pdev);
+	exynos_setup_vbus_gpio(&pdev->dev);
 
 	hcd = usb_create_hcd(&exynos_ehci_hc_driver,
 			     &pdev->dev, dev_name(&pdev->dev));
-- 
1.7.10.4
