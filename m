From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon,  7 May 2018 14:44:48 +0200
Subject: [PATCH v3 02/14] drivers: soc: sunxi: Add dedicated compatibles for
 the A13, A20 and A33
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180507124500.20434-3-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces platform-specific compatibles for the A13, A20 and A33
SRAM driver. No particular adaptation for these platforms is required at
this point, although this might become the case in the future.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 74cb81f37bd6..43ebc3bd33f2 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -315,6 +315,9 @@ static int sunxi_sram_probe(struct platform_device *pdev)
 
 static const struct of_device_id sunxi_sram_dt_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
+	{ .compatible = "allwinner,sun5i-a13-sram-controller" },
+	{ .compatible = "allwinner,sun7i-a20-sram-controller" },
+	{ .compatible = "allwinner,sun8i-a33-sram-controller" },
 	{ .compatible = "allwinner,sun50i-a64-sram-controller" },
 	{ },
 };
-- 
2.16.3
