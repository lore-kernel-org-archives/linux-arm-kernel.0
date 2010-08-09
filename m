From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Aug 2010 11:05:42 +0200
Subject: [PATCH 7/8] ARM i.MX3: add dma request resources to ssi/sdhc devices
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281344743-2029-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 1c6578a..c0d5d98 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -80,6 +80,10 @@ static struct resource mxcsdhc0_resources[] = {
 		.start = MXC_INT_MMC_SDHC1,
 		.end = MXC_INT_MMC_SDHC1,
 		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = MX31_DMA_REQ_SDHC1,
+		.end = MX31_DMA_REQ_SDHC1,
+		.flags = IORESOURCE_DMA,
 	},
 };
 
@@ -92,6 +96,10 @@ static struct resource mxcsdhc1_resources[] = {
 		.start = MXC_INT_MMC_SDHC2,
 		.end = MXC_INT_MMC_SDHC2,
 		.flags = IORESOURCE_IRQ,
+	}, {
+		.start = MX31_DMA_REQ_SDHC2,
+		.end = MX31_DMA_REQ_SDHC2,
+		.flags = IORESOURCE_DMA,
 	},
 };
 
@@ -312,6 +320,26 @@ static struct resource imx_ssi_resources0[] = {
 		.start	= MX31_INT_SSI1,
 		.end	= MX31_INT_SSI1,
 		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "tx0",
+		.start	= MX3x_DMA_REQ_SSI1_TX1,
+		.end	= MX3x_DMA_REQ_SSI1_TX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "tx1",
+		.start	= MX3x_DMA_REQ_SSI1_TX2,
+		.end	= MX3x_DMA_REQ_SSI1_TX2,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx0",
+		.start	= MX3x_DMA_REQ_SSI1_RX1,
+		.end	= MX3x_DMA_REQ_SSI1_RX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx1",
+		.start	= MX3x_DMA_REQ_SSI1_RX2,
+		.end	= MX3x_DMA_REQ_SSI1_RX2,
+		.flags	= IORESOURCE_DMA,
 	},
 };
 
@@ -324,6 +352,26 @@ static struct resource imx_ssi_resources1[] = {
 		.start	= MX31_INT_SSI2,
 		.end	= MX31_INT_SSI2,
 		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "tx0",
+		.start	= MX3x_DMA_REQ_SSI2_TX1,
+		.end	= MX3x_DMA_REQ_SSI2_TX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "tx1",
+		.start	= MX3x_DMA_REQ_SSI2_TX2,
+		.end	= MX3x_DMA_REQ_SSI2_TX2,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx0",
+		.start	= MX3x_DMA_REQ_SSI2_RX1,
+		.end	= MX3x_DMA_REQ_SSI2_RX1,
+		.flags	= IORESOURCE_DMA,
+	}, {
+		.name	= "rx1",
+		.start	= MX3x_DMA_REQ_SSI2_RX2,
+		.end	= MX3x_DMA_REQ_SSI2_RX2,
+		.flags	= IORESOURCE_DMA,
 	},
 };
 
-- 
1.7.1
