From: david@lechnology.com (David Lechner)
Date: Sat,  6 Jan 2018 21:19:50 -0600
Subject: [PATCH 1/3] USB: musb: da8xx: remove clock con_id
In-Reply-To: <1515295192-17883-1-git-send-email-david@lechnology.com>
References: <1515295192-17883-1-git-send-email-david@lechnology.com>
Message-ID: <1515295192-17883-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one clock for the DA8xx MUSB device, so we don't need the
con_id, so remove it. This way we don't have to add an unnecessary
property to the device tree bindings for the clock.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/usb/musb/da8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 6c036de..b8295ce 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -520,7 +520,7 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (!glue)
 		return -ENOMEM;
 
-	clk = devm_clk_get(&pdev->dev, "usb20");
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
-- 
2.7.4
