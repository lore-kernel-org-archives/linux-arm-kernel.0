From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 21 Feb 2016 22:26:36 -0300
Subject: [PATCH 3/3] usb: musb: sunxi: support module autoloading
In-Reply-To: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1456104396-13282-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio.lopez@collabora.co.uk>

MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
sunxi systems using the OTG controller. This commit adds the missing
line so it loads automatically when building it as a module and running
on a system with an USB OTG port.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 drivers/usb/musb/sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index d9b0dc4..fdab423 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -752,6 +752,7 @@ static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, sunxi_musb_match);
 
 static struct platform_driver sunxi_musb_driver = {
 	.probe = sunxi_musb_probe,
-- 
2.7.1
