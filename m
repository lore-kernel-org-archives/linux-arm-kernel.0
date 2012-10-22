From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 22 Oct 2012 18:17:55 +0800
Subject: [PATCH 1/5] ARM: at91: atmel-ssc: add platform device id table
Message-ID: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using platform device id to check whether the Atmel SOC support dma for
data transfer

If match "at91rm9200_ssc" which does not support DMA transfer
If match "at91sam9g45_ssc" which support DMA transfer

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/at91rm9200.c          |    6 +++---
 arch/arm/mach-at91/at91rm9200_devices.c  |    6 +++---
 arch/arm/mach-at91/at91sam9260.c         |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261.c         |    6 +++---
 arch/arm/mach-at91/at91sam9261_devices.c |    6 +++---
 arch/arm/mach-at91/at91sam9263.c         |    4 ++--
 arch/arm/mach-at91/at91sam9263_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9g45.c         |    4 ++--
 arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9rl.c          |    4 ++--
 arch/arm/mach-at91/at91sam9rl_devices.c  |    4 ++--
 drivers/misc/atmel-ssc.c                 |   23 +++++++++++++++++++++++
 include/linux/atmel-ssc.h                |    5 +++++
 14 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index b4f0565..85d53c5 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -184,9 +184,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91rm9200", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index a563189..59ceea1 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -752,7 +752,7 @@ static struct resource ssc0_resources[] = {
 };
 
 static struct platform_device at91rm9200_ssc0_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc0_dmamask,
@@ -794,7 +794,7 @@ static struct resource ssc1_resources[] = {
 };
 
 static struct platform_device at91rm9200_ssc1_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 1,
 	.dev	= {
 		.dma_mask		= &ssc1_dmamask,
@@ -836,7 +836,7 @@ static struct resource ssc2_resources[] = {
 };
 
 static struct platform_device at91rm9200_ssc2_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 2,
 	.dev	= {
 		.dma_mask		= &ssc2_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index ad29f93..2c8aab0 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -210,7 +210,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9260", &twi_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20", &twi_clk),
 	/* more usart lookup table for DT entries */
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 805ef95..9cfdc3f 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -742,7 +742,7 @@ static struct resource ssc_resources[] = {
 };
 
 static struct platform_device at91sam9260_ssc_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 8d999eb..4e8c56e 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -174,9 +174,9 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9261", &twi_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g10", &twi_clk),
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 9752f17..299637f 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -706,7 +706,7 @@ static struct resource ssc0_resources[] = {
 };
 
 static struct platform_device at91sam9261_ssc0_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc0_dmamask,
@@ -748,7 +748,7 @@ static struct resource ssc1_resources[] = {
 };
 
 static struct platform_device at91sam9261_ssc1_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 1,
 	.dev	= {
 		.dma_mask		= &ssc1_dmamask,
@@ -790,7 +790,7 @@ static struct resource ssc2_resources[] = {
 };
 
 static struct platform_device at91sam9261_ssc2_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 2,
 	.dev	= {
 		.dma_mask		= &ssc2_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 6a01d03..95a5471 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -186,8 +186,8 @@ static struct clk *periph_clocks[] __initdata = {
 static struct clk_lookup periph_clocks_lookups[] = {
 	/* One additional fake clock for macb_hclk */
 	CLKDEV_CON_ID("hclk", &macb_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.0", &mmc0_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.1", &mmc1_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 8dde220..df89a00 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1199,7 +1199,7 @@ static struct resource ssc0_resources[] = {
 };
 
 static struct platform_device at91sam9263_ssc0_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc0_dmamask,
@@ -1241,7 +1241,7 @@ static struct resource ssc1_resources[] = {
 };
 
 static struct platform_device at91sam9263_ssc1_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 1,
 	.dev	= {
 		.dma_mask		= &ssc1_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 84af1b5..f4f96a6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -239,8 +239,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g10.0", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g10.1", &twi1_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91sam9g45_ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91sam9g45_ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel-trng", &trng_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_sha", &aestdessha_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel_tdes", &aestdessha_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b159607..27e3bf6 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1459,7 +1459,7 @@ static struct resource ssc0_resources[] = {
 };
 
 static struct platform_device at91sam9g45_ssc0_device = {
-	.name	= "ssc",
+	.name	= "at91sam9g45_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc0_dmamask,
@@ -1501,7 +1501,7 @@ static struct resource ssc1_resources[] = {
 };
 
 static struct platform_device at91sam9g45_ssc1_device = {
-	.name	= "ssc",
+	.name	= "at91sam9g45_ssc",
 	.id	= 1,
 	.dev	= {
 		.dma_mask		= &ssc1_dmamask,
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 72e9084..4110b54 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -184,8 +184,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tc0_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.0", &tc1_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
-	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc0_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.0", &twi0_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20.1", &twi1_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index d6ca054..01220c7 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -832,7 +832,7 @@ static struct resource ssc0_resources[] = {
 };
 
 static struct platform_device at91sam9rl_ssc0_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc0_dmamask,
@@ -874,7 +874,7 @@ static struct resource ssc1_resources[] = {
 };
 
 static struct platform_device at91sam9rl_ssc1_device = {
-	.name	= "ssc",
+	.name	= "at91rm9200_ssc",
 	.id	= 1,
 	.dev	= {
 		.dma_mask		= &ssc1_dmamask,
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index ac00f83..f40abd8 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -68,6 +68,26 @@ void ssc_free(struct ssc_device *ssc)
 }
 EXPORT_SYMBOL(ssc_free);
 
+static struct atmel_ssc_platform_data at91rm9200_config = {
+	.use_dma = 0,
+};
+
+static struct atmel_ssc_platform_data at91sam9g45_config = {
+	.use_dma = 1,
+};
+
+static const struct platform_device_id atmel_ssc_devtypes[] = {
+	{
+		.name = "at91rm9200_ssc",
+		.driver_data = (unsigned long) &at91rm9200_config,
+	}, {
+		.name = "at91sam9g45_ssc",
+		.driver_data = (unsigned long) &at91sam9g45_config,
+	}, {
+		/* sentinel */
+	}
+};
+
 static int ssc_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
@@ -80,6 +100,8 @@ static int ssc_probe(struct platform_device *pdev)
 	}
 
 	ssc->pdev = pdev;
+	ssc->pdata = (struct atmel_ssc_platform_data *)
+			platform_get_device_id(pdev)->driver_data;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -139,6 +161,7 @@ static struct platform_driver ssc_driver = {
 		.name		= "ssc",
 		.owner		= THIS_MODULE,
 	},
+	.id_table	= atmel_ssc_devtypes,
 	.probe		= ssc_probe,
 	.remove		= __devexit_p(ssc_remove),
 };
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 4eb3175..1ca0e32 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -5,10 +5,15 @@
 #include <linux/list.h>
 #include <linux/io.h>
 
+struct atmel_ssc_platform_data {
+	int			use_dma;
+};
+
 struct ssc_device {
 	struct list_head	list;
 	void __iomem		*regs;
 	struct platform_device	*pdev;
+	struct atmel_ssc_platform_data *pdata;
 	struct clk		*clk;
 	int			user;
 	int			irq;
-- 
1.7.9.5
