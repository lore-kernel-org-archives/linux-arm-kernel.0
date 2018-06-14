From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Jun 2018 23:35:47 +0800
Subject: [PATCH v3 3/4] soc: sunxi: sram: Add updated compatible string for
 A64 system control
In-Reply-To: <20180614153548.9644-1-wens@csie.org>
References: <20180614153548.9644-1-wens@csie.org>
Message-ID: <20180614153548.9644-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRAM mapping controls on Allwinner SoCs is located in a block called
"System Controls". This block also has registers for identifying the SoC,
reading the state of an external boot-related pin, and on some newer SoCs,
glue layer controls for the EMAC Ethernet controller.

The A64 variant compatible is renamed to "allwinner,a64-system-control"
to reflect this. The old A64 compatible is deprecated. So far we haven't
seen any actual use of it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/soc/sunxi/sunxi_sram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index eec7fc6e9f66..7fec1b160dbb 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -359,6 +359,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun50i-a64-sram-controller",
 		.data = &sun50i_a64_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-system-control",
+		.data = &sun50i_a64_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.17.1
