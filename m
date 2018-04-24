From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 22:32:38 +0200
Subject: [RFC 09/10] usb: host: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <20180424203239.21885-10-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/host/ehci-exynos.c | 7 -------
 drivers/usb/host/ohci-exynos.c | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index d9145a8f35d2..8e3bab1e0c1f 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -161,16 +161,10 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	}
 	exynos_ehci = to_exynos_ehci(hcd);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-					"samsung,exynos5440-ehci"))
-		goto skip_phy;
-
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
 		goto fail_clk;
 
-skip_phy:
-
 	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ehci->clk)) {
@@ -304,7 +298,6 @@ static const struct dev_pm_ops exynos_ehci_pm_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ehci_match[] = {
 	{ .compatible = "samsung,exynos4210-ehci" },
-	{ .compatible = "samsung,exynos5440-ehci" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_ehci_match);
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index a39fae41bc70..c0c4dcca6f3c 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -130,15 +130,10 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	exynos_ohci = to_exynos_ohci(hcd);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-					"samsung,exynos5440-ohci"))
-		goto skip_phy;
-
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
 		goto fail_clk;
 
-skip_phy:
 	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ohci->clk)) {
@@ -270,7 +265,6 @@ static const struct dev_pm_ops exynos_ohci_pm_ops = {
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ohci_match[] = {
 	{ .compatible = "samsung,exynos4210-ohci" },
-	{ .compatible = "samsung,exynos5440-ohci" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_ohci_match);
-- 
2.14.1
