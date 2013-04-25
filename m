From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 25 Apr 2013 22:43:27 +0800
Subject: [PATCH v2 1/2] dma: imx: change enum definitions to macros
In-Reply-To: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
References: <1366901008-7593-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1366901008-7593-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change enum sdma_peripheral_type and imx_dma_prio to macro definitions
for easing the migration to generic DMA device tree bindings later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/imx-sdma.c                |    4 +--
 include/linux/platform_data/dma-imx.h |   56 +++++++++++++++------------------
 2 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 092867b..e57a0c6 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -249,7 +249,7 @@ struct sdma_channel {
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
-	enum sdma_peripheral_type	peripheral_type;
+	int				peripheral_type;
 	unsigned int			event_id0;
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
@@ -580,7 +580,7 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
  * sets the pc of SDMA script according to the peripheral type
  */
 static void sdma_get_pc(struct sdma_channel *sdmac,
-		enum sdma_peripheral_type peripheral_type)
+		int peripheral_type)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
 	int per_2_emi = 0, emi_2_per = 0;
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index f6d30cc..8a8a684 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -16,40 +16,36 @@
 /*
  * This enumerates peripheral types. Used for SDMA.
  */
-enum sdma_peripheral_type {
-	IMX_DMATYPE_SSI,	/* MCU domain SSI */
-	IMX_DMATYPE_SSI_SP,	/* Shared SSI */
-	IMX_DMATYPE_MMC,	/* MMC */
-	IMX_DMATYPE_SDHC,	/* SDHC */
-	IMX_DMATYPE_UART,	/* MCU domain UART */
-	IMX_DMATYPE_UART_SP,	/* Shared UART */
-	IMX_DMATYPE_FIRI,	/* FIRI */
-	IMX_DMATYPE_CSPI,	/* MCU domain CSPI */
-	IMX_DMATYPE_CSPI_SP,	/* Shared CSPI */
-	IMX_DMATYPE_SIM,	/* SIM */
-	IMX_DMATYPE_ATA,	/* ATA */
-	IMX_DMATYPE_CCM,	/* CCM */
-	IMX_DMATYPE_EXT,	/* External peripheral */
-	IMX_DMATYPE_MSHC,	/* Memory Stick Host Controller */
-	IMX_DMATYPE_MSHC_SP,	/* Shared Memory Stick Host Controller */
-	IMX_DMATYPE_DSP,	/* DSP */
-	IMX_DMATYPE_MEMORY,	/* Memory */
-	IMX_DMATYPE_FIFO_MEMORY,/* FIFO type Memory */
-	IMX_DMATYPE_SPDIF,	/* SPDIF */
-	IMX_DMATYPE_IPU_MEMORY,	/* IPU Memory */
-	IMX_DMATYPE_ASRC,	/* ASRC */
-	IMX_DMATYPE_ESAI,	/* ESAI */
-};
+#define IMX_DMATYPE_SSI		0  /* MCU domain SSI */
+#define IMX_DMATYPE_SSI_SP	1  /* Shared SSI */
+#define IMX_DMATYPE_MMC		2  /* MMC */
+#define IMX_DMATYPE_SDHC	3  /* SDHC */
+#define IMX_DMATYPE_UART	4  /* MCU domain UART */
+#define IMX_DMATYPE_UART_SP	5  /* Shared UART */
+#define IMX_DMATYPE_FIRI	6  /* FIRI */
+#define IMX_DMATYPE_CSPI	7  /* MCU domain CSPI */
+#define IMX_DMATYPE_CSPI_SP	8  /* Shared CSPI */
+#define IMX_DMATYPE_SIM		9  /* SIM */
+#define IMX_DMATYPE_ATA		10 /* ATA */
+#define IMX_DMATYPE_CCM		11 /* CCM */
+#define IMX_DMATYPE_EXT		12 /* External peripheral */
+#define IMX_DMATYPE_MSHC	13 /* Memory Stick Host Controller */
+#define IMX_DMATYPE_MSHC_SP	14 /* Shared Memory Stick Host Controller */
+#define IMX_DMATYPE_DSP		15 /* DSP */
+#define IMX_DMATYPE_MEMORY	16 /* Memory */
+#define IMX_DMATYPE_FIFO_MEMORY	17 /* FIFO type Memory */
+#define IMX_DMATYPE_SPDIF	18 /* SPDIF */
+#define IMX_DMATYPE_IPU_MEMORY	19 /* IPU Memory */
+#define IMX_DMATYPE_ASRC	20 /* ASRC */
+#define IMX_DMATYPE_ESAI	21 /* ESAI */
 
-enum imx_dma_prio {
-	DMA_PRIO_HIGH = 0,
-	DMA_PRIO_MEDIUM = 1,
-	DMA_PRIO_LOW = 2
-};
+#define DMA_PRIO_HIGH		0
+#define DMA_PRIO_MEDIUM		1
+#define DMA_PRIO_LOW		2
 
 struct imx_dma_data {
 	int dma_request; /* DMA request line */
-	enum sdma_peripheral_type peripheral_type;
+	int peripheral_type;
 	int priority;
 };
 
-- 
1.7.9.5
