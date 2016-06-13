From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:50 -0000
Subject: [PATCH v3 06/13] spi: sunxi: rename sun4i,sun6i -> sunxi
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <c151f18b4cbfe224b1866f2a81007e0edd6c3bcb.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare to merge drivers.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 274 +++++++++++++++++++++++-----------------------
 drivers/spi/spi-sun6i.c | 284 ++++++++++++++++++++++++------------------------
 2 files changed, 279 insertions(+), 279 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index ba2b5c8..155d720 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -22,58 +22,58 @@
 
 #include <linux/spi/spi.h>
 
-#define SUN4I_FIFO_DEPTH		64
-
-#define SUN4I_RXDATA_REG		0x00
-
-#define SUN4I_TXDATA_REG		0x04
-
-#define SUN4I_CTL_REG			0x08
-#define SUN4I_CTL_ENABLE			BIT(0)
-#define SUN4I_CTL_MASTER			BIT(1)
-#define SUN4I_CTL_CPHA				BIT(2)
-#define SUN4I_CTL_CPOL				BIT(3)
-#define SUN4I_CTL_CS_ACTIVE_LOW			BIT(4)
-#define SUN4I_CTL_LMTF				BIT(6)
-#define SUN4I_CTL_TF_RST			BIT(8)
-#define SUN4I_CTL_RF_RST			BIT(9)
-#define SUN4I_CTL_XCH				BIT(10)
-#define SUN4I_CTL_CS_MASK			0x3000
-#define SUN4I_CTL_CS(cs)			(((cs) << 12) & SUN4I_CTL_CS_MASK)
-#define SUN4I_CTL_DHB				BIT(15)
-#define SUN4I_CTL_CS_MANUAL			BIT(16)
-#define SUN4I_CTL_CS_LEVEL			BIT(17)
-#define SUN4I_CTL_TP				BIT(18)
-
-#define SUN4I_INT_CTL_REG		0x0c
-#define SUN4I_INT_CTL_TC			BIT(16)
-
-#define SUN4I_INT_STA_REG		0x10
-
-#define SUN4I_DMA_CTL_REG		0x14
-
-#define SUN4I_WAIT_REG			0x18
-
-#define SUN4I_CLK_CTL_REG		0x1c
-#define SUN4I_CLK_CTL_CDR2_MASK			0xff
-#define SUN4I_CLK_CTL_CDR2(div)			((div) & SUN4I_CLK_CTL_CDR2_MASK)
-#define SUN4I_CLK_CTL_CDR1_MASK			0xf
-#define SUN4I_CLK_CTL_CDR1(div)			(((div) & SUN4I_CLK_CTL_CDR1_MASK) << 8)
-#define SUN4I_CLK_CTL_DRS			BIT(12)
-
-#define SUN4I_BURST_CNT_REG		0x20
-#define SUN4I_BURST_CNT(cnt)			((cnt) & 0xffffff)
-
-#define SUN4I_XMIT_CNT_REG		0x24
-#define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
-
-#define SUN4I_FIFO_STA_REG		0x28
-#define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
-#define SUN4I_FIFO_STA_RF_CNT_BITS		0
-#define SUN4I_FIFO_STA_TF_CNT_MASK		0x7f
-#define SUN4I_FIFO_STA_TF_CNT_BITS		16
-
-struct sun4i_spi {
+#define SUNXI_FIFO_DEPTH		64
+
+#define SUNXI_RXDATA_REG		0x00
+
+#define SUNXI_TXDATA_REG		0x04
+
+#define SUNXI_CTL_REG			0x08
+#define SUNXI_CTL_ENABLE		BIT(0)
+#define SUNXI_CTL_MASTER		BIT(1)
+#define SUNXI_CTL_CPHA			BIT(2)
+#define SUNXI_CTL_CPOL			BIT(3)
+#define SUNXI_CTL_CS_ACTIVE_LOW		BIT(4)
+#define SUNXI_CTL_LMTF			BIT(6)
+#define SUNXI_CTL_TF_RST		BIT(8)
+#define SUNXI_CTL_RF_RST		BIT(9)
+#define SUNXI_CTL_XCH			BIT(10)
+#define SUNXI_CTL_CS_MASK		0x3000
+#define SUNXI_CTL_CS(cs)		(((cs) << 12) & SUNXI_CTL_CS_MASK)
+#define SUNXI_CTL_DHB			BIT(15)
+#define SUNXI_CTL_CS_MANUAL		BIT(16)
+#define SUNXI_CTL_CS_LEVEL		BIT(17)
+#define SUNXI_CTL_TP			BIT(18)
+
+#define SUNXI_INT_CTL_REG		0x0c
+#define SUNXI_INT_CTL_TC		BIT(16)
+
+#define SUNXI_INT_STA_REG		0x10
+
+#define SUNXI_DMA_CTL_REG		0x14
+
+#define SUNXI_WAIT_REG			0x18
+
+#define SUNXI_CLK_CTL_REG		0x1c
+#define SUNXI_CLK_CTL_CDR2_MASK		0xff
+#define SUNXI_CLK_CTL_CDR2(div)		((div) & SUNXI_CLK_CTL_CDR2_MASK)
+#define SUNXI_CLK_CTL_CDR1_MASK		0xf
+#define SUNXI_CLK_CTL_CDR1(div)		(((div) & SUNXI_CLK_CTL_CDR1_MASK) << 8)
+#define SUNXI_CLK_CTL_DRS		BIT(12)
+
+#define SUNXI_BURST_CNT_REG		0x20
+#define SUNXI_BURST_CNT(cnt)		((cnt) & 0xffffff)
+
+#define SUNXI_XMIT_CNT_REG		0x24
+#define SUNXI_XMIT_CNT(cnt)		((cnt) & 0xffffff)
+
+#define SUNXI_FIFO_STA_REG		0x28
+#define SUNXI_FIFO_STA_RF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_RF_CNT_BITS	0
+#define SUNXI_FIFO_STA_TF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_TF_CNT_BITS	16
+
+struct sunxi_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
@@ -86,37 +86,37 @@ struct sun4i_spi {
 	int			len;
 };
 
-static inline u32 sun4i_spi_read(struct sun4i_spi *sspi, u32 reg)
+static inline u32 sunxi_spi_read(struct sunxi_spi *sspi, u32 reg)
 {
 	return readl(sspi->base_addr + reg);
 }
 
-static inline void sun4i_spi_write(struct sun4i_spi *sspi, u32 reg, u32 value)
+static inline void sunxi_spi_write(struct sunxi_spi *sspi, u32 reg, u32 value)
 {
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline void sun4i_spi_drain_fifo(struct sun4i_spi *sspi, int len)
+static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
 {
 	u32 reg, cnt;
 	u8 byte;
 
 	/* See how much data is available */
-	reg = sun4i_spi_read(sspi, SUN4I_FIFO_STA_REG);
-	reg &= SUN4I_FIFO_STA_RF_CNT_MASK;
-	cnt = reg >> SUN4I_FIFO_STA_RF_CNT_BITS;
+	reg = sunxi_spi_read(sspi, SUNXI_FIFO_STA_REG);
+	reg &= SUNXI_FIFO_STA_RF_CNT_MASK;
+	cnt = reg >> SUNXI_FIFO_STA_RF_CNT_BITS;
 
 	if (len > cnt)
 		len = cnt;
 
 	while (len--) {
-		byte = readb(sspi->base_addr + SUN4I_RXDATA_REG);
+		byte = readb(sspi->base_addr + SUNXI_RXDATA_REG);
 		if (sspi->rx_buf)
 			*sspi->rx_buf++ = byte;
 	}
 }
 
-static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
+static inline void sunxi_spi_fill_fifo(struct sunxi_spi *sspi, int len)
 {
 	u8 byte;
 
@@ -125,28 +125,28 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
-		writeb(byte, sspi->base_addr + SUN4I_TXDATA_REG);
+		writeb(byte, sspi->base_addr + SUNXI_TXDATA_REG);
 		sspi->len--;
 	}
 }
 
-static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
+static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(spi->master);
 	u32 reg;
 
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
+	reg = sunxi_spi_read(sspi, SUNXI_CTL_REG);
 
-	reg &= ~SUN4I_CTL_CS_MASK;
-	reg |= SUN4I_CTL_CS(spi->chip_select);
+	reg &= ~SUNXI_CTL_CS_MASK;
+	reg |= SUNXI_CTL_CS(spi->chip_select);
 
 	/* We want to control the chip select manually */
-	reg |= SUN4I_CTL_CS_MANUAL;
+	reg |= SUNXI_CTL_CS_MANUAL;
 
 	if (enable)
-		reg |= SUN4I_CTL_CS_LEVEL;
+		reg |= SUNXI_CTL_CS_LEVEL;
 	else
-		reg &= ~SUN4I_CTL_CS_LEVEL;
+		reg &= ~SUNXI_CTL_CS_LEVEL;
 
 	/*
 	 * Even though this looks irrelevant since we are supposed to
@@ -160,23 +160,23 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 	 * low.
 	 */
 	if (spi->mode & SPI_CS_HIGH)
-		reg &= ~SUN4I_CTL_CS_ACTIVE_LOW;
+		reg &= ~SUNXI_CTL_CS_ACTIVE_LOW;
 	else
-		reg |= SUN4I_CTL_CS_ACTIVE_LOW;
+		reg |= SUNXI_CTL_CS_ACTIVE_LOW;
 
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_CTL_REG, reg);
 }
 
-static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
+static size_t sunxi_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN4I_FIFO_DEPTH - 1;
+	return SUNXI_FIFO_DEPTH - 1;
 }
 
-static int sun4i_spi_transfer_one(struct spi_master *master,
+static int sunxi_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
@@ -184,10 +184,10 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
+	if (tfr->len > SUNXI_FIFO_DEPTH)
 		return -EMSGSIZE;
 
-	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
+	if (tfr->tx_buf && tfr->len >= SUNXI_FIFO_DEPTH)
 		return -EMSGSIZE;
 
 	reinit_completion(&sspi->done);
@@ -196,33 +196,33 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	sspi->len = tfr->len;
 
 	/* Clear pending interrupts */
-	sun4i_spi_write(sspi, SUN4I_INT_STA_REG, ~0);
+	sunxi_spi_write(sspi, SUNXI_INT_STA_REG, ~0);
 
 
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
+	reg = sunxi_spi_read(sspi, SUNXI_CTL_REG);
 
 	/* Reset FIFOs */
-	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			reg | SUN4I_CTL_RF_RST | SUN4I_CTL_TF_RST);
+	sunxi_spi_write(sspi, SUNXI_CTL_REG,
+			reg | SUNXI_CTL_RF_RST | SUNXI_CTL_TF_RST);
 
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
 	 */
 	if (spi->mode & SPI_CPOL)
-		reg |= SUN4I_CTL_CPOL;
+		reg |= SUNXI_CTL_CPOL;
 	else
-		reg &= ~SUN4I_CTL_CPOL;
+		reg &= ~SUNXI_CTL_CPOL;
 
 	if (spi->mode & SPI_CPHA)
-		reg |= SUN4I_CTL_CPHA;
+		reg |= SUNXI_CTL_CPHA;
 	else
-		reg &= ~SUN4I_CTL_CPHA;
+		reg &= ~SUNXI_CTL_CPHA;
 
 	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUN4I_CTL_LMTF;
+		reg |= SUNXI_CTL_LMTF;
 	else
-		reg &= ~SUN4I_CTL_LMTF;
+		reg &= ~SUNXI_CTL_LMTF;
 
 
 	/*
@@ -230,11 +230,11 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUN4I_CTL_DHB;
+		reg &= ~SUNXI_CTL_DHB;
 	else
-		reg |= SUN4I_CTL_DHB;
+		reg |= SUNXI_CTL_DHB;
 
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
@@ -258,39 +258,39 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	 * frequency, fall back to CDR1.
 	 */
 	div = mclk_rate / (2 * tfr->speed_hz);
-	if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
+	if (div <= (SUNXI_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
-		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
+		reg = SUNXI_CLK_CTL_CDR2(div) | SUNXI_CLK_CTL_DRS;
 	} else {
 		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
-		reg = SUN4I_CLK_CTL_CDR1(div);
+		reg = SUNXI_CLK_CTL_CDR1(div);
 	}
 
-	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_CLK_CTL_REG, reg);
 
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
 
 	/* Setup the counters */
-	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len));
-	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
+	sunxi_spi_write(sspi, SUNXI_BURST_CNT_REG, SUNXI_BURST_CNT(tfr->len));
+	sunxi_spi_write(sspi, SUNXI_XMIT_CNT_REG, SUNXI_XMIT_CNT(tx_len));
 
 	/*
 	 * Fill the TX FIFO
 	 * Filling the FIFO fully causes timeout for some reason
 	 * at least on spi2 on A10s
 	 */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
+	sunxi_spi_fill_fifo(sspi, SUNXI_FIFO_DEPTH - 1);
 
 	/* Enable the interrupts */
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, SUNXI_INT_CTL_TC);
 
 	/* Start the transfer */
-	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
-	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
+	reg = sunxi_spi_read(sspi, SUNXI_CTL_REG);
+	sunxi_spi_write(sspi, SUNXI_CTL_REG, reg | SUNXI_CTL_XCH);
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
@@ -306,22 +306,22 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+	sunxi_spi_drain_fifo(sspi, SUNXI_FIFO_DEPTH);
 
 out:
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, 0);
 
 	return ret;
 }
 
-static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
+static irqreturn_t sunxi_spi_handler(int irq, void *dev_id)
 {
-	struct sun4i_spi *sspi = dev_id;
-	u32 status = sun4i_spi_read(sspi, SUN4I_INT_STA_REG);
+	struct sunxi_spi *sspi = dev_id;
+	u32 status = sunxi_spi_read(sspi, SUNXI_INT_STA_REG);
 
 	/* Transfer complete */
-	if (status & SUN4I_INT_CTL_TC) {
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
+	if (status & SUNXI_INT_CTL_TC) {
+		sunxi_spi_write(sspi, SUNXI_INT_STA_REG, SUNXI_INT_CTL_TC);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -329,10 +329,10 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int sun4i_spi_runtime_resume(struct device *dev)
+static int sunxi_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -347,8 +347,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 		goto err;
 	}
 
-	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+	sunxi_spi_write(sspi, SUNXI_CTL_REG,
+			SUNXI_CTL_ENABLE | SUNXI_CTL_MASTER | SUNXI_CTL_TP);
 
 	return 0;
 
@@ -358,10 +358,10 @@ out:
 	return ret;
 }
 
-static int sun4i_spi_runtime_suspend(struct device *dev)
+static int sunxi_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(sspi->mclk);
 	clk_disable_unprepare(sspi->hclk);
@@ -369,14 +369,14 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sun4i_spi_probe(struct platform_device *pdev)
+static int sunxi_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
-	struct sun4i_spi *sspi;
+	struct sunxi_spi *sspi;
 	struct resource	*res;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun4i_spi));
+	master = spi_alloc_master(&pdev->dev, sizeof(struct sunxi_spi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
@@ -399,8 +399,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
-			       0, "sun4i-spi", sspi);
+	ret = devm_request_irq(&pdev->dev, irq, sunxi_spi_handler,
+			       0, "sunxi-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -409,14 +409,14 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	sspi->master = master;
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz =          3 * 1000;
-	master->set_cs = sun4i_spi_set_cs;
-	master->transfer_one = sun4i_spi_transfer_one;
+	master->set_cs = sunxi_spi_set_cs;
+	master->transfer_one = sunxi_spi_transfer_one;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun4i_spi_max_transfer_size;
+	master->max_transfer_size = sunxi_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
@@ -438,7 +438,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
 	 */
-	ret = sun4i_spi_runtime_resume(&pdev->dev);
+	ret = sunxi_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
 		goto err_free_master;
@@ -458,40 +458,40 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	sun4i_spi_runtime_suspend(&pdev->dev);
+	sunxi_spi_runtime_suspend(&pdev->dev);
 err_free_master:
 	spi_master_put(master);
 	return ret;
 }
 
-static int sun4i_spi_remove(struct platform_device *pdev)
+static int sunxi_spi_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
-static const struct of_device_id sun4i_spi_match[] = {
+static const struct of_device_id sunxi_spi_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-spi", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun4i_spi_match);
+MODULE_DEVICE_TABLE(of, sunxi_spi_match);
 
-static const struct dev_pm_ops sun4i_spi_pm_ops = {
-	.runtime_resume		= sun4i_spi_runtime_resume,
-	.runtime_suspend	= sun4i_spi_runtime_suspend,
+static const struct dev_pm_ops sunxi_spi_pm_ops = {
+	.runtime_resume		= sunxi_spi_runtime_resume,
+	.runtime_suspend	= sunxi_spi_runtime_suspend,
 };
 
-static struct platform_driver sun4i_spi_driver = {
-	.probe	= sun4i_spi_probe,
-	.remove	= sun4i_spi_remove,
+static struct platform_driver sunxi_spi_driver = {
+	.probe	= sunxi_spi_probe,
+	.remove	= sunxi_spi_remove,
 	.driver	= {
-		.name		= "sun4i-spi",
-		.of_match_table	= sun4i_spi_match,
-		.pm		= &sun4i_spi_pm_ops,
+		.name		= "sunxi-spi",
+		.of_match_table	= sunxi_spi_match,
+		.pm		= &sunxi_spi_pm_ops,
 	},
 };
-module_platform_driver(sun4i_spi_driver);
+module_platform_driver(sunxi_spi_driver);
 
 MODULE_AUTHOR("Pan Nan <pannan@allwinnertech.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 06759d0..a27bf8f 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -23,62 +23,62 @@
 
 #include <linux/spi/spi.h>
 
-#define SUN6I_FIFO_DEPTH		128
-
-#define SUN6I_GBL_CTL_REG		0x04
-#define SUN6I_GBL_CTL_BUS_ENABLE		BIT(0)
-#define SUN6I_GBL_CTL_MASTER			BIT(1)
-#define SUN6I_GBL_CTL_TP			BIT(7)
-#define SUN6I_GBL_CTL_RST			BIT(31)
-
-#define SUN6I_TFR_CTL_REG		0x08
-#define SUN6I_TFR_CTL_CPHA			BIT(0)
-#define SUN6I_TFR_CTL_CPOL			BIT(1)
-#define SUN6I_TFR_CTL_SPOL			BIT(2)
-#define SUN6I_TFR_CTL_CS_MASK			0x30
-#define SUN6I_TFR_CTL_CS(cs)			(((cs) << 4) & SUN6I_TFR_CTL_CS_MASK)
-#define SUN6I_TFR_CTL_CS_MANUAL			BIT(6)
-#define SUN6I_TFR_CTL_CS_LEVEL			BIT(7)
-#define SUN6I_TFR_CTL_DHB			BIT(8)
-#define SUN6I_TFR_CTL_FBS			BIT(12)
-#define SUN6I_TFR_CTL_XCH			BIT(31)
-
-#define SUN6I_INT_CTL_REG		0x10
-#define SUN6I_INT_CTL_RF_OVF			BIT(8)
-#define SUN6I_INT_CTL_TC			BIT(12)
-
-#define SUN6I_INT_STA_REG		0x14
-
-#define SUN6I_FIFO_CTL_REG		0x18
-#define SUN6I_FIFO_CTL_RF_RST			BIT(15)
-#define SUN6I_FIFO_CTL_TF_RST			BIT(31)
-
-#define SUN6I_FIFO_STA_REG		0x1c
-#define SUN6I_FIFO_STA_RF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_RF_CNT_BITS		0
-#define SUN6I_FIFO_STA_TF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_TF_CNT_BITS		16
-
-#define SUN6I_CLK_CTL_REG		0x24
-#define SUN6I_CLK_CTL_CDR2_MASK			0xff
-#define SUN6I_CLK_CTL_CDR2(div)			(((div) & SUN6I_CLK_CTL_CDR2_MASK) << 0)
-#define SUN6I_CLK_CTL_CDR1_MASK			0xf
-#define SUN6I_CLK_CTL_CDR1(div)			(((div) & SUN6I_CLK_CTL_CDR1_MASK) << 8)
-#define SUN6I_CLK_CTL_DRS			BIT(12)
-
-#define SUN6I_BURST_CNT_REG		0x30
-#define SUN6I_BURST_CNT(cnt)			((cnt) & 0xffffff)
-
-#define SUN6I_XMIT_CNT_REG		0x34
-#define SUN6I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
-
-#define SUN6I_BURST_CTL_CNT_REG		0x38
-#define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & 0xffffff)
-
-#define SUN6I_TXDATA_REG		0x200
-#define SUN6I_RXDATA_REG		0x300
-
-struct sun6i_spi {
+#define SUNXI_FIFO_DEPTH		128
+
+#define SUNXI_GBL_CTL_REG		0x04
+#define SUNXI_GBL_CTL_BUS_ENABLE	BIT(0)
+#define SUNXI_GBL_CTL_MASTER		BIT(1)
+#define SUNXI_GBL_CTL_TP		BIT(7)
+#define SUNXI_GBL_CTL_RST		BIT(31)
+
+#define SUNXI_TFR_CTL_REG		0x08
+#define SUNXI_TFR_CTL_CPHA		BIT(0)
+#define SUNXI_TFR_CTL_CPOL		BIT(1)
+#define SUNXI_TFR_CTL_SPOL		BIT(2)
+#define SUNXI_TFR_CTL_CS_MASK		0x30
+#define SUNXI_TFR_CTL_CS(cs)		(((cs) << 4) & SUNXI_TFR_CTL_CS_MASK)
+#define SUNXI_TFR_CTL_CS_MANUAL		BIT(6)
+#define SUNXI_TFR_CTL_CS_LEVEL		BIT(7)
+#define SUNXI_TFR_CTL_DHB		BIT(8)
+#define SUNXI_TFR_CTL_FBS		BIT(12)
+#define SUNXI_TFR_CTL_XCH		BIT(31)
+
+#define SUNXI_INT_CTL_REG		0x10
+#define SUNXI_INT_CTL_RF_OVF		BIT(8)
+#define SUNXI_INT_CTL_TC		BIT(12)
+
+#define SUNXI_INT_STA_REG		0x14
+
+#define SUNXI_FIFO_CTL_REG		0x18
+#define SUNXI_FIFO_CTL_RF_RST		BIT(15)
+#define SUNXI_FIFO_CTL_TF_RST		BIT(31)
+
+#define SUNXI_FIFO_STA_REG		0x1c
+#define SUNXI_FIFO_STA_RF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_RF_CNT_BITS	0
+#define SUNXI_FIFO_STA_TF_CNT_MASK	0x7f
+#define SUNXI_FIFO_STA_TF_CNT_BITS	16
+
+#define SUNXI_CLK_CTL_REG		0x24
+#define SUNXI_CLK_CTL_CDR2_MASK		0xff
+#define SUNXI_CLK_CTL_CDR2(div)		(((div) & SUNXI_CLK_CTL_CDR2_MASK) << 0)
+#define SUNXI_CLK_CTL_CDR1_MASK		0xf
+#define SUNXI_CLK_CTL_CDR1(div)		(((div) & SUNXI_CLK_CTL_CDR1_MASK) << 8)
+#define SUNXI_CLK_CTL_DRS		BIT(12)
+
+#define SUNXI_BURST_CNT_REG		0x30
+#define SUNXI_BURST_CNT(cnt)		((cnt) & 0xffffff)
+
+#define SUNXI_XMIT_CNT_REG		0x34
+#define SUNXI_XMIT_CNT(cnt)		((cnt) & 0xffffff)
+
+#define SUNXI_BURST_CTL_CNT_REG		0x38
+#define SUNXI_BURST_CTL_CNT_STC(cnt)	((cnt) & 0xffffff)
+
+#define SUNXI_TXDATA_REG		0x200
+#define SUNXI_RXDATA_REG		0x300
+
+struct sunxi_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
@@ -92,37 +92,37 @@ struct sun6i_spi {
 	int			len;
 };
 
-static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
+static inline u32 sunxi_spi_read(struct sunxi_spi *sspi, u32 reg)
 {
 	return readl(sspi->base_addr + reg);
 }
 
-static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
+static inline void sunxi_spi_write(struct sunxi_spi *sspi, u32 reg, u32 value)
 {
 	writel(value, sspi->base_addr + reg);
 }
 
-static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
+static inline void sunxi_spi_drain_fifo(struct sunxi_spi *sspi, int len)
 {
 	u32 reg, cnt;
 	u8 byte;
 
 	/* See how much data is available */
-	reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
-	reg &= SUN6I_FIFO_STA_RF_CNT_MASK;
-	cnt = reg >> SUN6I_FIFO_STA_RF_CNT_BITS;
+	reg = sunxi_spi_read(sspi, SUNXI_FIFO_STA_REG);
+	reg &= SUNXI_FIFO_STA_RF_CNT_MASK;
+	cnt = reg >> SUNXI_FIFO_STA_RF_CNT_BITS;
 
 	if (len > cnt)
 		len = cnt;
 
 	while (len--) {
-		byte = readb(sspi->base_addr + SUN6I_RXDATA_REG);
+		byte = readb(sspi->base_addr + SUNXI_RXDATA_REG);
 		if (sspi->rx_buf)
 			*sspi->rx_buf++ = byte;
 	}
 }
 
-static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
+static inline void sunxi_spi_fill_fifo(struct sunxi_spi *sspi, int len)
 {
 	u8 byte;
 
@@ -131,27 +131,27 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
-		writeb(byte, sspi->base_addr + SUN6I_TXDATA_REG);
+		writeb(byte, sspi->base_addr + SUNXI_TXDATA_REG);
 		sspi->len--;
 	}
 }
 
-static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
+static void sunxi_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(spi->master);
 	u32 reg;
 
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	reg &= ~SUN6I_TFR_CTL_CS_MASK;
-	reg |= SUN6I_TFR_CTL_CS(spi->chip_select);
+	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
+	reg &= ~SUNXI_TFR_CTL_CS_MASK;
+	reg |= SUNXI_TFR_CTL_CS(spi->chip_select);
 
 	/* We want to control the chip select manually */
-	reg |= SUN6I_TFR_CTL_CS_MANUAL;
+	reg |= SUNXI_TFR_CTL_CS_MANUAL;
 
 	if (enable)
-		reg |= SUN6I_TFR_CTL_CS_LEVEL;
+		reg |= SUNXI_TFR_CTL_CS_LEVEL;
 	else
-		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
+		reg &= ~SUNXI_TFR_CTL_CS_LEVEL;
 
 	/*
 	 * Even though this looks irrelevant since we are supposed to
@@ -165,23 +165,23 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	 * low.
 	 */
 	if (spi->mode & SPI_CS_HIGH)
-		reg &= ~SUN6I_TFR_CTL_SPOL;
+		reg &= ~SUNXI_TFR_CTL_SPOL;
 	else
-		reg |= SUN6I_TFR_CTL_SPOL;
+		reg |= SUNXI_TFR_CTL_SPOL;
 
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 }
 
-static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
+static size_t sunxi_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN6I_FIFO_DEPTH - 1;
+	return SUNXI_FIFO_DEPTH - 1;
 }
 
-static int sun6i_spi_transfer_one(struct spi_master *master,
+static int sunxi_spi_transfer_one(struct spi_master *master,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
@@ -189,7 +189,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN6I_FIFO_DEPTH)
+	if (tfr->len > SUNXI_FIFO_DEPTH)
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
@@ -198,43 +198,43 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sspi->len = tfr->len;
 
 	/* Clear pending interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
+	sunxi_spi_write(sspi, SUNXI_INT_STA_REG, ~0);
 
 	/* Reset FIFO */
-	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
-			SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);
+	sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
+			SUNXI_FIFO_CTL_RF_RST | SUNXI_FIFO_CTL_TF_RST);
 
 	/*
 	 * Setup the transfer control register: Chip Select,
 	 * polarities, etc.
 	 */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
 
 	if (spi->mode & SPI_CPOL)
-		reg |= SUN6I_TFR_CTL_CPOL;
+		reg |= SUNXI_TFR_CTL_CPOL;
 	else
-		reg &= ~SUN6I_TFR_CTL_CPOL;
+		reg &= ~SUNXI_TFR_CTL_CPOL;
 
 	if (spi->mode & SPI_CPHA)
-		reg |= SUN6I_TFR_CTL_CPHA;
+		reg |= SUNXI_TFR_CTL_CPHA;
 	else
-		reg &= ~SUN6I_TFR_CTL_CPHA;
+		reg &= ~SUNXI_TFR_CTL_CPHA;
 
 	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUN6I_TFR_CTL_FBS;
+		reg |= SUNXI_TFR_CTL_FBS;
 	else
-		reg &= ~SUN6I_TFR_CTL_FBS;
+		reg &= ~SUNXI_TFR_CTL_FBS;
 
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
 	if (sspi->rx_buf)
-		reg &= ~SUN6I_TFR_CTL_DHB;
+		reg &= ~SUNXI_TFR_CTL_DHB;
 	else
-		reg |= SUN6I_TFR_CTL_DHB;
+		reg |= SUNXI_TFR_CTL_DHB;
 
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
@@ -258,37 +258,37 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * frequency, fall back to CDR1.
 	 */
 	div = mclk_rate / (2 * tfr->speed_hz);
-	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
+	if (div <= (SUNXI_CLK_CTL_CDR2_MASK + 1)) {
 		if (div > 0)
 			div--;
 
-		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
+		reg = SUNXI_CLK_CTL_CDR2(div) | SUNXI_CLK_CTL_DRS;
 	} else {
 		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
-		reg = SUN6I_CLK_CTL_CDR1(div);
+		reg = SUNXI_CLK_CTL_CDR1(div);
 	}
 
-	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
+	sunxi_spi_write(sspi, SUNXI_CLK_CTL_REG, reg);
 
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
 
 	/* Setup the counters */
-	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
-	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
-	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
-			SUN6I_BURST_CTL_CNT_STC(tx_len));
+	sunxi_spi_write(sspi, SUNXI_BURST_CNT_REG, SUNXI_BURST_CNT(tfr->len));
+	sunxi_spi_write(sspi, SUNXI_XMIT_CNT_REG, SUNXI_XMIT_CNT(tx_len));
+	sunxi_spi_write(sspi, SUNXI_BURST_CTL_CNT_REG,
+			SUNXI_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sunxi_spi_fill_fifo(sspi, SUNXI_FIFO_DEPTH);
 
 	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, SUNXI_INT_CTL_TC);
 
 	/* Start the transfer */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
+	reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
+	sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg | SUNXI_TFR_CTL_XCH);
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
@@ -304,22 +304,22 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sunxi_spi_drain_fifo(sspi, SUNXI_FIFO_DEPTH);
 
 out:
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
+	sunxi_spi_write(sspi, SUNXI_INT_CTL_REG, 0);
 
 	return ret;
 }
 
-static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
+static irqreturn_t sunxi_spi_handler(int irq, void *dev_id)
 {
-	struct sun6i_spi *sspi = dev_id;
-	u32 status = sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
+	struct sunxi_spi *sspi = dev_id;
+	u32 status = sunxi_spi_read(sspi, SUNXI_INT_STA_REG);
 
 	/* Transfer complete */
-	if (status & SUN6I_INT_CTL_TC) {
-		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
+	if (status & SUNXI_INT_CTL_TC) {
+		sunxi_spi_write(sspi, SUNXI_INT_STA_REG, SUNXI_INT_CTL_TC);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -327,10 +327,10 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int sun6i_spi_runtime_resume(struct device *dev)
+static int sunxi_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -351,8 +351,8 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 		goto err2;
 	}
 
-	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
-			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
+	sunxi_spi_write(sspi, SUNXI_GBL_CTL_REG,
+			SUNXI_GBL_CTL_BUS_ENABLE | SUNXI_GBL_CTL_MASTER | SUNXI_GBL_CTL_TP);
 
 	return 0;
 
@@ -364,10 +364,10 @@ out:
 	return ret;
 }
 
-static int sun6i_spi_runtime_suspend(struct device *dev)
+static int sunxi_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sunxi_spi *sspi = spi_master_get_devdata(master);
 
 	reset_control_assert(sspi->rstc);
 	clk_disable_unprepare(sspi->mclk);
@@ -376,14 +376,14 @@ static int sun6i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sun6i_spi_probe(struct platform_device *pdev)
+static int sunxi_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
-	struct sun6i_spi *sspi;
+	struct sunxi_spi *sspi;
 	struct resource	*res;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
+	master = spi_alloc_master(&pdev->dev, sizeof(struct sunxi_spi));
 	if (!master) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
@@ -406,8 +406,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 		goto err_free_master;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
-			       0, "sun6i-spi", sspi);
+	ret = devm_request_irq(&pdev->dev, irq, sunxi_spi_handler,
+			       0, "sunxi-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
 		goto err_free_master;
@@ -416,14 +416,14 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	sspi->master = master;
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz =          3 * 1000;
-	master->set_cs = sun6i_spi_set_cs;
-	master->transfer_one = sun6i_spi_transfer_one;
+	master->set_cs = sunxi_spi_set_cs;
+	master->transfer_one = sunxi_spi_transfer_one;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun6i_spi_max_transfer_size;
+	master->max_transfer_size = sunxi_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
@@ -452,7 +452,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	 * This wake-up/shutdown pattern is to be able to have the
 	 * device woken up, even if runtime_pm is disabled
 	 */
-	ret = sun6i_spi_runtime_resume(&pdev->dev);
+	ret = sunxi_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
 		goto err_free_master;
@@ -472,40 +472,40 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	sun6i_spi_runtime_suspend(&pdev->dev);
+	sunxi_spi_runtime_suspend(&pdev->dev);
 err_free_master:
 	spi_master_put(master);
 	return ret;
 }
 
-static int sun6i_spi_remove(struct platform_device *pdev)
+static int sunxi_spi_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
 
-static const struct of_device_id sun6i_spi_match[] = {
+static const struct of_device_id sunxi_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun6i_spi_match);
+MODULE_DEVICE_TABLE(of, sunxi_spi_match);
 
-static const struct dev_pm_ops sun6i_spi_pm_ops = {
-	.runtime_resume		= sun6i_spi_runtime_resume,
-	.runtime_suspend	= sun6i_spi_runtime_suspend,
+static const struct dev_pm_ops sunxi_spi_pm_ops = {
+	.runtime_resume		= sunxi_spi_runtime_resume,
+	.runtime_suspend	= sunxi_spi_runtime_suspend,
 };
 
-static struct platform_driver sun6i_spi_driver = {
-	.probe	= sun6i_spi_probe,
-	.remove	= sun6i_spi_remove,
+static struct platform_driver sunxi_spi_driver = {
+	.probe	= sunxi_spi_probe,
+	.remove	= sunxi_spi_remove,
 	.driver	= {
-		.name		= "sun6i-spi",
-		.of_match_table	= sun6i_spi_match,
-		.pm		= &sun6i_spi_pm_ops,
+		.name		= "sunxi-spi",
+		.of_match_table	= sunxi_spi_match,
+		.pm		= &sunxi_spi_pm_ops,
 	},
 };
-module_platform_driver(sun6i_spi_driver);
+module_platform_driver(sunxi_spi_driver);
 
 MODULE_AUTHOR("Pan Nan <pannan@allwinnertech.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-- 
2.8.1
