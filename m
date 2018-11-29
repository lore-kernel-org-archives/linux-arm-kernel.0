From: jian.hu@amlogic.com (Jian Hu)
Date: Thu, 29 Nov 2018 18:59:56 +0800
Subject: [PATCH 2/2] i2c: meson: add support for Meson G12A SoC I2C controller
In-Reply-To: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Message-ID: <1543489197-183181-3-git-send-email-jian.hu@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible and data for G12A I2C controller.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 drivers/i2c/busses/i2c-meson.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 90f5d04..b86eed7 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -462,10 +462,15 @@ static int meson_i2c_remove(struct platform_device *pdev)
 	.div_factor = 3,
 };
 
+static const struct meson_i2c_data i2c_g12a_data = {
+	.div_factor = 3,
+};
+
 static const struct of_device_id meson_i2c_match[] = {
 	{ .compatible = "amlogic,meson6-i2c", .data = &i2c_meson6_data },
 	{ .compatible = "amlogic,meson-gxbb-i2c", .data = &i2c_gxbb_data },
 	{ .compatible = "amlogic,meson-axg-i2c", .data = &i2c_axg_data },
+	{ .compatible = "amlogic,meson-g12a-i2c", .data = &i2c_g12a_data },
 	{},
 };
 
-- 
1.9.1
