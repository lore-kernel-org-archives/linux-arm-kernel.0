From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 21 Mar 2016 23:13:38 +0100
Subject: [PATCH] musb: sunxi-glue: Fix sunxi-musb driver not auto-loading
Message-ID: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing MODULE_DEVICE_TABLE() line which was causing the
sunxi-musb glue to not auto-load when build as a module.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 4b472b8..9af9431 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -756,6 +756,7 @@ static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, sunxi_musb_match);
 
 static struct platform_driver sunxi_musb_driver = {
 	.probe = sunxi_musb_probe,
-- 
2.7.3
