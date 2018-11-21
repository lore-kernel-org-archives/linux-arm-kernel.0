From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:46 +0300
Subject: [RFC PATCH v3 13/17] SoC: sunxi: Add support for Allwinner ARMv5
 F1C100s sram
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <89f6179c17a98f160301fdeef27df35b359847e3.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner ARMv5 F1C100s has similar sram controller to sun4i A10
Add compatible strings for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b4b0f34..27f0607 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -99,6 +99,10 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 		.compatible	= "allwinner,sun50i-a64-sram-c",
 		.data		= &sun50i_a64_sram_c.data,
 	},
+	{
+		.compatible	= "allwinner,suniv-f1c100s-sram-d",
+		.data		= &sun4i_a10_sram_d.data,
+	},
 	{}
 };
 
@@ -389,6 +393,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-a64-system-control",
 		.data = &sun50i_a64_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,suniv-f1c100s-system-control",
+		.data = &sun4i_a10_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.7.4
