From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 21 Feb 2016 22:26:34 -0300
Subject: [PATCH 1/3] [media] rc: sunxi-cir: support module autoloading
Message-ID: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio.lopez@collabora.co.uk>

MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
systems supporting infrared. This commit adds the missing line so it
works out of the box when built as a module and running on a sunxi
system with an infrared receiver.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 drivers/media/rc/sunxi-cir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 40f7768..eaadc08 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -326,6 +326,7 @@ static const struct of_device_id sunxi_ir_match[] = {
 	{ .compatible = "allwinner,sun5i-a13-ir", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sunxi_ir_match);
 
 static struct platform_driver sunxi_ir_driver = {
 	.probe          = sunxi_ir_probe,
-- 
2.7.1
