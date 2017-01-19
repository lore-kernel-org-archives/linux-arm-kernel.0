From: codekipper@gmail.com (codekipper at gmail.com)
Date: Thu, 19 Jan 2017 20:52:58 +0100
Subject: [PATCH v2 2/2] ASoC: sun4i-spdif: Add support for the H3 SoC
In-Reply-To: <20170119195258.29652-1-codekipper@gmail.com>
References: <20170119195258.29652-1-codekipper@gmail.com>
Message-ID: <20170119195258.29652-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The H3 SoC uses the same SPDIF block as found in earlier SoCs, but its
TXFIFO is mapped to another address.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index fec62ee1fc72..c03cd07a9b19 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -103,6 +103,8 @@
 	#define SUN4I_SPDIF_ISTA_RXOSTA			BIT(1)
 	#define SUN4I_SPDIF_ISTA_RXASTA			BIT(0)
 
+#define SUN8I_SPDIF_TXFIFO	(0x20)
+
 #define SUN4I_SPDIF_TXCNT	(0x24)
 
 #define SUN4I_SPDIF_RXCNT	(0x28)
@@ -417,6 +419,11 @@ static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.has_reset	= true,
 };
 
+static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
+	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-spdif",
@@ -426,6 +433,10 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun6i-a31-spdif",
 		.data = &sun6i_a31_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-spdif",
+		.data = &sun8i_h3_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.11.0
