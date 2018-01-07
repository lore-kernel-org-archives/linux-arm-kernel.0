From: david@lechnology.com (David Lechner)
Date: Sat,  6 Jan 2018 21:19:51 -0600
Subject: [PATCH 2/3] USB: ohci: da8xx: remove clk con_id
In-Reply-To: <1515295192-17883-1-git-send-email-david@lechnology.com>
References: <1515295192-17883-1-git-send-email-david@lechnology.com>
Message-ID: <1515295192-17883-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ohci-da8xx device only has one clock, so a con_id is not needed, so
remove it. This way we don't have to add an unnecessary property to the
device tree bindings for the clock.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/usb/host/ohci-da8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 0c507a0..a55cbba 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -413,7 +413,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	da8xx_ohci = to_da8xx_ohci(hcd);
 	da8xx_ohci->hcd = hcd;
 
-	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, "usb11");
+	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(da8xx_ohci->usb11_clk)) {
 		error = PTR_ERR(da8xx_ohci->usb11_clk);
 		if (error != -EPROBE_DEFER)
-- 
2.7.4
