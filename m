From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 10 Jul 2018 10:00:58 +0200
Subject: [PATCH v5 06/22] soc: sunxi: sram: Add dt match for the A10
 system-control compatible
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180710080114.31469-7-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This binds the new A10 system-control compatible to the associated
driver, with the same driver data as the previous compatible.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 7fec1b160dbb..236f34307c0f 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -355,6 +355,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun4i-a10-sram-controller",
 		.data = &sun4i_a10_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun4i-a10-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
 	{
 		.compatible = "allwinner,sun50i-a64-sram-controller",
 		.data = &sun50i_a64_sramc_variant,
-- 
2.17.1
