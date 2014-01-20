From: rogerq@ti.com (Roger Quadros)
Date: Mon, 20 Jan 2014 16:11:24 +0200
Subject: [PATCH v6 03/10] mfd: omap-usb-host: Use clock names as per function
 for reference clocks
In-Reply-To: <1390227091-4523-1-git-send-email-rogerq@ti.com>
References: <1390227091-4523-1-git-send-email-rogerq@ti.com>
Message-ID: <1390227091-4523-4-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a meaningful name for the reference clocks so that it indicates the function.

CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index eaafd2e..d6fab3e 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp1_ck = devm_clk_get(dev, "xclk60mhsp1_ck");
+	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp1_ck);
 		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->xclk60mhsp2_ck = devm_clk_get(dev, "xclk60mhsp2_ck");
+	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp2_ck);
 		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
 		goto err_mem;
 	}
 
-	omap->init_60m_fclk = devm_clk_get(dev, "init_60m_fclk");
+	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
 	if (IS_ERR(omap->init_60m_fclk)) {
 		ret = PTR_ERR(omap->init_60m_fclk);
 		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
-- 
1.8.3.2
