From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 11 Jul 2018 11:25:07 +0200
Subject: [PATCH 1/2] soc: sunxi: Add the A13,
 A23 and H3 system control compatibles
Message-ID: <20180711092508.18751-1-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13, A23 and H3 have variations of the system controls, in part due to
the SRAM that are available (and can be mapped) in the SoC.

In order to make it future proof, let's add compatibles for these SoCs in
the driver.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b19fa2cc67c2..b4b0f3480bd3 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -369,6 +369,18 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun4i-a10-system-control",
 		.data = &sun4i_a10_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun5i-a13-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
+	{
+		.compatible = "allwinner,sun8i-a23-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
+	{
+		.compatible = "allwinner,sun8i-h3-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
 	{
 		.compatible = "allwinner,sun50i-a64-sram-controller",
 		.data = &sun50i_a64_sramc_variant,
-- 
2.17.1
