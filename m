From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:17:50 +0100
Subject: [PATCH 2/8] ARM: s3c64xx: Add DMA slave maps for PL080 devices
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478791076-19528-3-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA slave map tables to the pl080 devices's
platform_data in order to support the new channel request API.
A few devices for which there was no DMA support with current
code are omitted in the tables.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c64xx/pl080.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
index 89c5a62..261820a 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c64xx/pl080.c
@@ -117,6 +117,25 @@ static void pl08x_put_xfer_signal(const struct pl08x_channel_data *cd, int ch)
 	}
 };
 
+static const struct dma_slave_map s3c64xx_dma0_slave_map[] = {
+	{ "s3c6400-uart.0", "tx", &s3c64xx_dma0_info[0] },
+	{ "s3c6400-uart.0", "rx", &s3c64xx_dma0_info[1] },
+	{ "s3c6400-uart.1", "tx", &s3c64xx_dma0_info[2] },
+	{ "s3c6400-uart.1", "rx", &s3c64xx_dma0_info[3] },
+	{ "s3c6400-uart.2", "tx", &s3c64xx_dma0_info[4] },
+	{ "s3c6400-uart.2", "rx", &s3c64xx_dma0_info[5] },
+	{ "s3c6400-uart.3", "tx", &s3c64xx_dma0_info[6] },
+	{ "s3c6400-uart.3", "rx", &s3c64xx_dma0_info[7] },
+	{ "samsung-pcm.0", "tx", &s3c64xx_dma0_info[8] },
+	{ "samsung-pcm.0", "rx", &s3c64xx_dma0_info[9] },
+	{ "samsung-i2s.0", "tx", &s3c64xx_dma0_info[10] },
+	{ "samsung-i2s.0", "rx", &s3c64xx_dma0_info[11] },
+	{ "s3c6410-spi.0", "tx", &s3c64xx_dma0_info[12] },
+	{ "s3c6410-spi.0", "rx", &s3c64xx_dma0_info[13] },
+	{ "samsung-i2s.2", "tx", &s3c64xx_dma0_info[14] },
+	{ "samsung-i2s.2", "rx", &s3c64xx_dma0_info[15] },
+};
+
 struct pl08x_platform_data s3c64xx_dma0_plat_data = {
 	.memcpy_channel = {
 		.bus_id = "memcpy",
@@ -134,6 +153,8 @@ struct pl08x_platform_data s3c64xx_dma0_plat_data = {
 	.put_xfer_signal = pl08x_put_xfer_signal,
 	.slave_channels = s3c64xx_dma0_info,
 	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma0_info),
+	.slave_map = s3c64xx_dma0_slave_map,
+	.slave_map_len = ARRAY_SIZE(s3c64xx_dma0_slave_map),
 };
 
 static AMBA_AHB_DEVICE(s3c64xx_dma0, "dma-pl080s.0", 0,
@@ -207,6 +228,15 @@ static AMBA_AHB_DEVICE(s3c64xx_dma0, "dma-pl080s.0", 0,
 	},
 };
 
+static const struct dma_slave_map s3c64xx_dma1_slave_map[] = {
+	{ "samsung-pcm.1", "tx", &s3c64xx_dma1_info[0] },
+	{ "samsung-pcm.1", "rx", &s3c64xx_dma1_info[1] },
+	{ "samsung-i2s.1", "tx", &s3c64xx_dma1_info[2] },
+	{ "samsung-i2s.1", "rx", &s3c64xx_dma1_info[3] },
+	{ "s3c6410-spi.1", "tx", &s3c64xx_dma1_info[4] },
+	{ "s3c6410-spi.1", "rx", &s3c64xx_dma1_info[5] },
+};
+
 struct pl08x_platform_data s3c64xx_dma1_plat_data = {
 	.memcpy_channel = {
 		.bus_id = "memcpy",
@@ -224,6 +254,8 @@ struct pl08x_platform_data s3c64xx_dma1_plat_data = {
 	.put_xfer_signal = pl08x_put_xfer_signal,
 	.slave_channels = s3c64xx_dma1_info,
 	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma1_info),
+	.slave_map = s3c64xx_dma1_slave_map,
+	.slave_map_len = ARRAY_SIZE(s3c64xx_dma1_slave_map),
 };
 
 static AMBA_AHB_DEVICE(s3c64xx_dma1, "dma-pl080s.1", 0,
-- 
1.9.1
