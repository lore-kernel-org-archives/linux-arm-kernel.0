From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 15 Nov 2018 15:50:02 +0100
Subject: [PATCH 04/15] soc: sunxi: sram: Enable EMAC clock access for H3
 variant
In-Reply-To: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181115145013.3378-5-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like the A64 and H5, the H3 SoC uses the system control block
to enable the EMAC clock.

Add a variant structure definition for the H3 and use it over the A10
one. This will allow using the H3-specific binding for the syscon node
attached to the EMAC instead of the generic syscon binding.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b4b0f3480bd3..afa86b5506eb 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -300,6 +300,10 @@ static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
 	/* Nothing special */
 };
 
+static const struct sunxi_sramc_variant sun8i_h3_sramc_variant = {
+	.has_emac_clock = true,
+};
+
 static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
 	.has_emac_clock = true,
 };
@@ -379,7 +383,7 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 	},
 	{
 		.compatible = "allwinner,sun8i-h3-system-control",
-		.data = &sun4i_a10_sramc_variant,
+		.data = &sun8i_h3_sramc_variant,
 	},
 	{
 		.compatible = "allwinner,sun50i-a64-sram-controller",
-- 
2.19.1
