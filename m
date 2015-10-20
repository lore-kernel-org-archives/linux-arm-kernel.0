From: luisbg@osg.samsung.com (Luis de Bethencourt)
Date: Tue, 20 Oct 2015 15:16:28 +0100
Subject: [RESEND PATCH 2/4] i2c: meson: Fix module autoload for OF platform
 driver
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Message-ID: <1445350590-25911-3-git-send-email-luisbg@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luis de Bethencourt <luis@debethencourt.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/i2c/busses/i2c-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 5e176ad..71d3929 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -475,6 +475,7 @@ static const struct of_device_id meson_i2c_match[] = {
 	{ .compatible = "amlogic,meson6-i2c" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, meson_i2c_match);
 
 static struct platform_driver meson_i2c_driver = {
 	.probe   = meson_i2c_probe,
-- 
2.5.3
