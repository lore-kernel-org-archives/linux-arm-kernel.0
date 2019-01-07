Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACB6206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8XJkGOz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cgn/HiBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACB6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=IeyzbAr0otHDkaZt8n+ei57LKR0hxXbXw+H4HajuWFs=; b=V8X
	JkGOzNRpoIIQWzwzyoSPY8y4Qgkd4/q0OqolD2LFCWj2KjmpOUjKfTsRQWooVQk7204tIKHOvrFKQ
	6SzF5t3+fAnMe4rTfVI3VvCbUIFRAphbi20EQqY9EYPXKls0C5utnTlIfI+Yolc+1pNhIlYoGy+Bb
	j03xUE4614FQTMFc5Lmw756BEiKvzL3Qz0eqLoktVCFh1zVkC3GN+VKB79RzaPoIOz2BJ8/HgLJw6
	+c7m7YmPvdTGzVreaYxYMYKvnI5lPykmXM68wT9c+RffOKZqZgkbnaQS4Arv6o7Ipdu/cMnnJWlGJ
	SseHDdNuh9GqU693kAtfVFp7Qdw1GGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gga7h-00031e-KD; Mon, 07 Jan 2019 18:59:41 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gga7C-0002bo-8I
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 18:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=okAL8VWS9WCW0nc86ab82fIw1Bynk92j1pr/Eg6jB+U=; b=cgn/HiBUlu5x
 zCZRKq+r2o5KsTzD1SEZEUS2hfqDUK68d9kfOLoh+kVV9taqNUScA70Ka0rIhVPzhZLcTrldGdB/k
 okHWzaHpvlA1E/3oeYsqtY/tnMbLutoNmgW+2Pa41IDo/nfQSqr/noPDOQYG8ObPgo0GjGuH4M6K6
 HB1rQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gga75-0007qS-Uy; Mon, 07 Jan 2019 18:59:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 814201127491; Mon,  7 Jan 2019 18:59:03 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: Applied "spi: stm32: split transfer one setup function" to the spi
 tree
In-Reply-To: <1545688840-23992-10-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185903.814201127491@debutante.sirena.org.uk>
Date: Mon,  7 Jan 2019 18:59:03 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_105910_695010_A96513EA 
X-CRM114-Status: GOOD (  22.95  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   spi: stm32: split transfer one setup function

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 9d5fce166c7a26ed9811f9b0ae914a079e62c0f8 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:35 +0100
Subject: [PATCH] spi: stm32: split transfer one setup function

Split stm32_spi_transfer_one_setup function into smaller chunks
to be more generic for other stm32 SPI family drivers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 270 ++++++++++++++++++++++++++++------------
 1 file changed, 192 insertions(+), 78 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9cb7d334a5cb..bc8513f088aa 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -101,11 +101,18 @@
 #define STM32H7_SPI_MBR_DIV_MIN		(2 << STM32H7_SPI_CFG1_MBR_MIN)
 #define STM32H7_SPI_MBR_DIV_MAX		(2 << STM32H7_SPI_CFG1_MBR_MAX)
 
-/* SPI Communication mode */
+/* STM32H7 SPI Communication mode */
+#define STM32H7_SPI_FULL_DUPLEX		0
+#define STM32H7_SPI_SIMPLEX_TX		1
+#define STM32H7_SPI_SIMPLEX_RX		2
+#define STM32H7_SPI_HALF_DUPLEX		3
+
+/* SPI Communication type */
 #define SPI_FULL_DUPLEX		0
 #define SPI_SIMPLEX_TX		1
 #define SPI_SIMPLEX_RX		2
-#define SPI_HALF_DUPLEX		3
+#define SPI_3WIRE_TX		3
+#define SPI_3WIRE_RX		4
 
 #define SPI_1HZ_NS		1000000000
 
@@ -232,13 +239,16 @@ static int stm32_spi_get_bpw_mask(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_prepare_mbr - Determine SPI_CFG1.MBR value
+ * stm32_spi_prepare_mbr - Determine baud rate divisor value
  * @spi: pointer to the spi controller data structure
  * @speed_hz: requested speed
+ * @min_div: minimum baud rate divisor
+ * @max_div: maximum baud rate divisor
  *
- * Return SPI_CFG1.MBR value in case of success or -EINVAL
+ * Return baud rate divisor value in case of success or -EINVAL
  */
-static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
+static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
+				 u32 min_div, u32 max_div)
 {
 	u32 div, mbrdiv;
 
@@ -251,8 +261,7 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if (div < STM32H7_SPI_MBR_DIV_MIN ||
-	    div > STM32H7_SPI_MBR_DIV_MAX)
+	if ((div < min_div) || (div > max_div))
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
@@ -802,7 +811,8 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	if (tx_dma_desc) {
-		if (spi->cur_comm == SPI_SIMPLEX_TX) {
+		if (spi->cur_comm == SPI_SIMPLEX_TX ||
+		    spi->cur_comm == SPI_3WIRE_TX) {
 			tx_dma_desc->callback = stm32_spi_dma_cb;
 			tx_dma_desc->callback_param = spi;
 		}
@@ -848,92 +858,130 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 }
 
 /**
- * stm32_spi_transfer_one_setup - common setup to transfer a single
- *				  spi_transfer either using DMA or
- *				  interrupts.
+ * stm32_spi_set_bpw - configure bits per word
+ * @spi: pointer to the spi controller data structure
  */
-static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
-					struct spi_device *spi_dev,
-					struct spi_transfer *transfer)
+static void stm32_spi_set_bpw(struct stm32_spi *spi)
 {
-	unsigned long flags;
-	u32 cfg1_clrb = 0, cfg1_setb = 0, cfg2_clrb = 0, cfg2_setb = 0;
-	u32 mode, nb_words;
-	int ret = 0;
+	u32 bpw, fthlv;
+	u32 cfg1_clrb = 0, cfg1_setb = 0;
 
-	spin_lock_irqsave(&spi->lock, flags);
+	bpw = spi->cur_bpw - 1;
 
-	if (spi->cur_bpw != transfer->bits_per_word) {
-		u32 bpw, fthlv;
-
-		spi->cur_bpw = transfer->bits_per_word;
-		bpw = spi->cur_bpw - 1;
+	cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
+	cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
+		     STM32H7_SPI_CFG1_DSIZE;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
-		cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
-			     STM32H7_SPI_CFG1_DSIZE;
+	spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
+	fthlv = spi->cur_fthlv - 1;
 
-		spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
-		fthlv = spi->cur_fthlv - 1;
+	cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
+	cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
+		     STM32H7_SPI_CFG1_FTHLV;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
-		cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
-			     STM32H7_SPI_CFG1_FTHLV;
-	}
-
-	if (spi->cur_speed != transfer->speed_hz) {
-		int mbr;
+	writel_relaxed(
+		(readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
+		 ~cfg1_clrb) | cfg1_setb,
+		spi->base + STM32H7_SPI_CFG1);
+}
 
-		/* Update spi->cur_speed with real clock speed */
-		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz);
-		if (mbr < 0) {
-			ret = mbr;
-			goto out;
-		}
+/**
+ * stm32_spi_set_mbr - Configure baud rate divisor in master mode
+ * @spi: pointer to the spi controller data structure
+ * @mbrdiv: baud rate divisor value
+ */
+static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
+{
+	u32 cfg1_clrb = 0, cfg1_setb = 0;
 
-		transfer->speed_hz = spi->cur_speed;
+	cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
+	cfg1_setb |= ((u32)mbrdiv << STM32H7_SPI_CFG1_MBR_SHIFT) &
+		STM32H7_SPI_CFG1_MBR;
 
-		cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
-		cfg1_setb |= ((u32)mbr << STM32H7_SPI_CFG1_MBR_SHIFT) &
-			     STM32H7_SPI_CFG1_MBR;
-	}
+	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
+			~cfg1_clrb) | cfg1_setb,
+		       spi->base + STM32H7_SPI_CFG1);
+}
 
-	if (cfg1_clrb || cfg1_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
-				~cfg1_clrb) | cfg1_setb,
-			       spi->base + STM32H7_SPI_CFG1);
+/**
+ * stm32_spi_communication_type - return transfer communication type
+ * @spi_dev: pointer to the spi device
+ * transfer: pointer to spi transfer
+ */
+static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
+						 struct spi_transfer *transfer)
+{
+	unsigned int type = SPI_FULL_DUPLEX;
 
-	mode = SPI_FULL_DUPLEX;
 	if (spi_dev->mode & SPI_3WIRE) { /* MISO/MOSI signals shared */
 		/*
 		 * SPI_3WIRE and xfer->tx_buf != NULL and xfer->rx_buf != NULL
-		 * is forbidden und unvalidated by SPI subsystem so depending
+		 * is forbidden and unvalidated by SPI subsystem so depending
 		 * on the valid buffer, we can determine the direction of the
 		 * transfer.
 		 */
-		mode = SPI_HALF_DUPLEX;
 		if (!transfer->tx_buf)
-			stm32_spi_clr_bits(spi, STM32H7_SPI_CR1,
-					   STM32H7_SPI_CR1_HDDIR);
-		else if (!transfer->rx_buf)
-			stm32_spi_set_bits(spi, STM32H7_SPI_CR1,
-					   STM32H7_SPI_CR1_HDDIR);
+			type = SPI_3WIRE_RX;
+		else
+			type = SPI_3WIRE_TX;
 	} else {
 		if (!transfer->tx_buf)
-			mode = SPI_SIMPLEX_RX;
+			type = SPI_SIMPLEX_RX;
 		else if (!transfer->rx_buf)
-			mode = SPI_SIMPLEX_TX;
+			type = SPI_SIMPLEX_TX;
 	}
-	if (spi->cur_comm != mode) {
-		spi->cur_comm = mode;
 
-		cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
-		cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
-			     STM32H7_SPI_CFG2_COMM;
+	return type;
+}
+
+/**
+ * stm32_spi_set_mode - configure communication mode
+ * @spi: pointer to the spi controller data structure
+ * @comm_type: type of communication to configure
+ */
+static int stm32_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
+{
+	u32 mode;
+	u32 cfg2_clrb = 0, cfg2_setb = 0;
+
+	if (comm_type == SPI_3WIRE_RX) {
+		mode = STM32H7_SPI_HALF_DUPLEX;
+		stm32_spi_clr_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_HDDIR);
+	} else if (comm_type == SPI_3WIRE_TX) {
+		mode = STM32H7_SPI_HALF_DUPLEX;
+		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_HDDIR);
+	} else if (comm_type == SPI_SIMPLEX_RX) {
+		mode = STM32H7_SPI_SIMPLEX_RX;
+	} else if (comm_type == SPI_SIMPLEX_TX) {
+		mode = STM32H7_SPI_SIMPLEX_TX;
+	} else {
+		mode = STM32H7_SPI_FULL_DUPLEX;
 	}
 
+	cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
+	cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
+		     STM32H7_SPI_CFG2_COMM;
+
+	writel_relaxed(
+		(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
+		 ~cfg2_clrb) | cfg2_setb,
+		spi->base + STM32H7_SPI_CFG2);
+
+	return 0;
+}
+
+/**
+ * stm32_spi_data_idleness - configure minimum time delay inserted between two
+ *			     consecutive data frames in master mode
+ * @spi: pointer to the spi controller data structure
+ * @len: transfer len
+ */
+static void stm32_spi_data_idleness(struct stm32_spi *spi, u32 len)
+{
+	u32 cfg2_clrb = 0, cfg2_setb = 0;
+
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
-	if ((transfer->len > 1) && (spi->cur_midi > 0)) {
+	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
 		u32 midi = min((u32)DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
 			       (u32)STM32H7_SPI_CFG2_MIDI >>
@@ -941,15 +989,85 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
-
 		cfg2_setb |= (midi << STM32H7_SPI_CFG2_MIDI_SHIFT) &
 			     STM32H7_SPI_CFG2_MIDI;
 	}
 
-	if (cfg2_clrb || cfg2_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
-				~cfg2_clrb) | cfg2_setb,
-			       spi->base + STM32H7_SPI_CFG2);
+	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
+			~cfg2_clrb) | cfg2_setb,
+		       spi->base + STM32H7_SPI_CFG2);
+}
+
+/**
+ * stm32_spi_number_of_data - configure number of data at current transfer
+ * @spi: pointer to the spi controller data structure
+ * @len: transfer length
+ */
+static int stm32_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
+{
+	u32 cr2_clrb = 0, cr2_setb = 0;
+
+	if (nb_words <= (STM32H7_SPI_CR2_TSIZE >>
+			 STM32H7_SPI_CR2_TSIZE_SHIFT)) {
+		cr2_clrb |= STM32H7_SPI_CR2_TSIZE;
+		cr2_setb = nb_words << STM32H7_SPI_CR2_TSIZE_SHIFT;
+		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CR2) &
+				~cr2_clrb) | cr2_setb,
+			       spi->base + STM32H7_SPI_CR2);
+	} else {
+		return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * stm32_spi_transfer_one_setup - common setup to transfer a single
+ *				  spi_transfer either using DMA or
+ *				  interrupts.
+ */
+static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
+					struct spi_device *spi_dev,
+					struct spi_transfer *transfer)
+{
+	unsigned long flags;
+	unsigned int comm_type;
+	int nb_words, ret = 0;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	if (spi->cur_bpw != transfer->bits_per_word) {
+		spi->cur_bpw = transfer->bits_per_word;
+		stm32_spi_set_bpw(spi);
+	}
+
+	if (spi->cur_speed != transfer->speed_hz) {
+		int mbr;
+
+		/* Update spi->cur_speed with real clock speed */
+		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
+					    STM32H7_SPI_MBR_DIV_MIN,
+					    STM32H7_SPI_MBR_DIV_MAX);
+		if (mbr < 0) {
+			ret = mbr;
+			goto out;
+		}
+
+		transfer->speed_hz = spi->cur_speed;
+		stm32_spi_set_mbr(spi, mbr);
+	}
+
+	comm_type = stm32_spi_communication_type(spi_dev, transfer);
+	if (spi->cur_comm != comm_type) {
+		stm32_spi_set_mode(spi, comm_type);
+
+		if (ret < 0)
+			goto out;
+
+		spi->cur_comm = comm_type;
+	}
+
+	stm32_spi_data_idleness(spi, transfer->len);
 
 	if (spi->cur_bpw <= 8)
 		nb_words = transfer->len;
@@ -957,14 +1075,10 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 16);
 	else
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 32);
-	nb_words <<= STM32H7_SPI_CR2_TSIZE_SHIFT;
 
-	if (nb_words <= STM32H7_SPI_CR2_TSIZE) {
-		writel_relaxed(nb_words, spi->base + STM32H7_SPI_CR2);
-	} else {
-		ret = -EMSGSIZE;
+	ret = stm32_spi_number_of_data(spi, nb_words);
+	if (ret < 0)
 		goto out;
-	}
 
 	spi->cur_xferlen = transfer->len;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
