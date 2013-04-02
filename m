From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:55 -0700
Subject: [PATCH V2 12/12] spi/mxs: Use u32 instead of uint32_t
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-12-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's consistent with all the other spi drivers that way.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 12794ea..aafd069 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -129,9 +129,9 @@ static int mxs_spi_setup(struct spi_device *dev)
 	return 0;
 }
 
-static uint32_t mxs_spi_cs_to_reg(unsigned cs)
+static u32 mxs_spi_cs_to_reg(unsigned cs)
 {
-	uint32_t select = 0;
+	u32 select = 0;
 
 	/*
 	 * i.MX28 Datasheet: 17.10.1: HW_SSP_CTRL0
@@ -153,7 +153,7 @@ static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
 	struct mxs_ssp *ssp = &spi->ssp;
-	uint32_t reg;
+	u32 reg;
 
 	do {
 		reg = readl_relaxed(ssp->base + offset);
@@ -197,11 +197,11 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	const int sgs = DIV_ROUND_UP(len, desc_len);
 	int sg_count;
 	int min, ret;
-	uint32_t ctrl0;
+	u32 ctrl0;
 	struct page *vm_page;
 	void *sg_buf;
 	struct {
-		uint32_t		pio[4];
+		u32			pio[4];
 		struct scatterlist	sg;
 	} *dma_xfer;
 
-- 
1.7.10.4
