From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 28 Nov 2017 21:29:25 +0800
Subject: [PATCH 2/3] spi: meson-axg: add SPICC driver support
In-Reply-To: <20171128132926.19051-1-yixun.lan@amlogic.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
Message-ID: <20171128132926.19051-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunny Luo <sunny.luo@amlogic.com>

Add new compatible string to support SPICC controller which
found at Amlogic Meson-AXG SoC. This is aiming at adding
a couple of enhanced feature patches.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f8429635502..5c82910e3480 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -599,6 +599,7 @@ static int meson_spicc_remove(struct platform_device *pdev)
 
 static const struct of_device_id meson_spicc_of_match[] = {
 	{ .compatible = "amlogic,meson-gx-spicc", },
+	{ .compatible = "amlogic,meson-axg-spicc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.15.0
