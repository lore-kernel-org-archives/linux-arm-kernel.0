From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:25:09 -0500
Subject: [PATCH 360/493] mfd: remove use of __devinitconst
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-360-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-arm-kernel at lists.infradead.org 
Cc: patches at opensource.wolfsonmicro.com 
---
 drivers/mfd/ab3100-core.c |  5 ++---
 drivers/mfd/sta2x11-mfd.c | 10 +++++-----
 drivers/mfd/timberdale.c  | 24 ++++++++++++------------
 drivers/mfd/wm8994-core.c |  6 +++---
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 84b2303..bf188bc 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -661,8 +661,7 @@ struct ab3100_init_setting {
 	u8 setting;
 };
 
-static const struct ab3100_init_setting __devinitconst
-ab3100_init_settings[] = {
+static const struct ab3100_init_setting ab3100_init_settings[] = {
 	{
 		.abreg = AB3100_MCA,
 		.setting = 0x01
@@ -803,7 +802,7 @@ struct ab_family_id {
 	char	*name;
 };
 
-static const struct ab_family_id ids[] __devinitconst = {
+static const struct ab_family_id ids[] = {
 	/* AB3100 */
 	{
 		.id = 0xc0,
diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index 1438be54..57f3361 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -305,7 +305,7 @@ enum bar1_cells {
 		.flags = IORESOURCE_MEM, \
 		}
 
-static const __devinitconst struct resource gpio_resources[] = {
+static const struct resource gpio_resources[] = {
 	{
 		.name = "sta2x11_gpio", /* 4 consecutive cells, 1 driver */
 		.start = 0,
@@ -313,17 +313,17 @@ static const __devinitconst struct resource gpio_resources[] = {
 		.flags = IORESOURCE_MEM,
 	}
 };
-static const __devinitconst struct resource sctl_resources[] = {
+static const struct resource sctl_resources[] = {
 	CELL_4K("sta2x11-sctl", STA2X11_SCTL),
 };
-static const __devinitconst struct resource scr_resources[] = {
+static const struct resource scr_resources[] = {
 	CELL_4K("sta2x11-scr", STA2X11_SCR),
 };
-static const __devinitconst struct resource time_resources[] = {
+static const struct resource time_resources[] = {
 	CELL_4K("sta2x11-time", STA2X11_TIME),
 };
 
-static const __devinitconst struct resource apbreg_resources[] = {
+static const struct resource apbreg_resources[] = {
 	CELL_4K("sta2x11-apbreg", STA2X11_APBREG),
 };
 
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 294e14d..a305ac1 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -89,7 +89,7 @@ timberdale_ocores_platform_data = {
 	.num_devices = ARRAY_SIZE(timberdale_i2c_board_info)
 };
 
-static const __devinitconst struct resource timberdale_xiic_resources[] = {
+static const struct resource timberdale_xiic_resources[] = {
 	{
 		.start	= XIICOFFSET,
 		.end	= XIICEND,
@@ -102,7 +102,7 @@ static const __devinitconst struct resource timberdale_xiic_resources[] = {
 	},
 };
 
-static const __devinitconst struct resource timberdale_ocores_resources[] = {
+static const struct resource timberdale_ocores_resources[] = {
 	{
 		.start	= OCORESOFFSET,
 		.end	= OCORESEND,
@@ -151,7 +151,7 @@ static struct xspi_platform_data timberdale_xspi_platform_data = {
 	 */
 };
 
-static const __devinitconst struct resource timberdale_spi_resources[] = {
+static const struct resource timberdale_spi_resources[] = {
 	{
 		.start 	= SPIOFFSET,
 		.end	= SPIEND,
@@ -170,7 +170,7 @@ static struct ks8842_platform_data
 	.tx_dma_channel = DMA_ETH_TX
 };
 
-static const __devinitconst struct resource timberdale_eth_resources[] = {
+static const struct resource timberdale_eth_resources[] = {
 	{
 		.start	= ETHOFFSET,
 		.end	= ETHEND,
@@ -190,7 +190,7 @@ static struct timbgpio_platform_data
 	.irq_base = 200,
 };
 
-static const __devinitconst struct resource timberdale_gpio_resources[] = {
+static const struct resource timberdale_gpio_resources[] = {
 	{
 		.start	= GPIOOFFSET,
 		.end	= GPIOEND,
@@ -203,7 +203,7 @@ static const __devinitconst struct resource timberdale_gpio_resources[] = {
 	},
 };
 
-static const __devinitconst struct resource timberdale_mlogicore_resources[] = {
+static const struct resource timberdale_mlogicore_resources[] = {
 	{
 		.start	= MLCOREOFFSET,
 		.end	= MLCOREEND,
@@ -221,7 +221,7 @@ static const __devinitconst struct resource timberdale_mlogicore_resources[] = {
 	},
 };
 
-static const __devinitconst struct resource timberdale_uart_resources[] = {
+static const struct resource timberdale_uart_resources[] = {
 	{
 		.start	= UARTOFFSET,
 		.end	= UARTEND,
@@ -234,7 +234,7 @@ static const __devinitconst struct resource timberdale_uart_resources[] = {
 	},
 };
 
-static const __devinitconst struct resource timberdale_uartlite_resources[] = {
+static const struct resource timberdale_uartlite_resources[] = {
 	{
 		.start	= UARTLITEOFFSET,
 		.end	= UARTLITEEND,
@@ -262,7 +262,7 @@ static struct timb_video_platform_data
 	}
 };
 
-static const __devinitconst struct resource
+static const struct resource
 timberdale_radio_resources[] = {
 	{
 		.start	= RDSOFFSET,
@@ -291,7 +291,7 @@ static struct timb_radio_platform_data
 	.dsp = &timberdale_saa7706_i2c_board_info
 };
 
-static const __devinitconst struct resource timberdale_video_resources[] = {
+static const struct resource timberdale_video_resources[] = {
 	{
 		.start	= LOGIWOFFSET,
 		.end	= LOGIWEND,
@@ -362,7 +362,7 @@ static struct timb_dma_platform_data timb_dma_platform_data = {
 	}
 };
 
-static const __devinitconst struct resource timberdale_dma_resources[] = {
+static const struct resource timberdale_dma_resources[] = {
 	{
 		.start	= DMAOFFSET,
 		.end	= DMAEND,
@@ -606,7 +606,7 @@ static struct mfd_cell timberdale_cells_bar0_cfg3[] = {
 	},
 };
 
-static const __devinitconst struct resource timberdale_sdhc_resources[] = {
+static const struct resource timberdale_sdhc_resources[] = {
 	/* located in bar 1 and bar 2 */
 	{
 		.start	= SDHC0OFFSET,
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 4642949..4e2432d 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -374,21 +374,21 @@ static int wm8994_ldo_in_use(struct wm8994_pdata *pdata, int ldo)
 }
 #endif
 
-static const __devinitconst struct reg_default wm8994_revc_patch[] = {
+static const struct reg_default wm8994_revc_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0x56, 0x3 },
 	{ 0x817, 0x0 },
 	{ 0x102, 0x0 },
 };
 
-static const __devinitconst struct reg_default wm8958_reva_patch[] = {
+static const struct reg_default wm8958_reva_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0xcb, 0x81 },
 	{ 0x817, 0x0 },
 	{ 0x102, 0x0 },
 };
 
-static const __devinitconst struct reg_default wm1811_reva_patch[] = {
+static const struct reg_default wm1811_reva_patch[] = {
 	{ 0x102, 0x3 },
 	{ 0x56, 0xc07 },
 	{ 0x5d, 0x7e },
-- 
1.8.0
