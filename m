Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA7C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:03:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CFF2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xmtjub7D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4Aactj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CFF2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1iRUJQzVTPQGjQylYzUKuV23Hs9eDj3P80FbyJjpHuU=; b=Xmtjub7DVbd0jXyc6436MtYVWA
	UpEhhnWANBP1O9jW+xNVxSjAAykhHC7IADiHG/a+w9wy68lwaXYCipL6IHrubCWtNtj2TWQ2swSvX
	fx4Jolqvu7ndVqUPfqpziqG6AxgeTvGECk+wNqlqj3mph1A8LmJu3Lgzfm+9ktE7O+X5lsT6DITXR
	jyQevCRDZINCFHcxAcFCsyzoNZ6/oE9hZw7o5VCni2AapqqgPYePftDRRpw83d2C3Oc1IktGvsgmg
	mYUjZZ++YMpUKiQejP1CcTGsf9kXcsUV6pK97z8auHuRraiBvpoqYxPrlWg2Jn/7S9NNwMsQxDvDf
	+a9Z6M3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYJR-00063s-60; Mon, 24 Dec 2018 22:03:01 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHi-0004KB-8m
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:20 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so12538645wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z25qU1Gd2RNparvr3msaNkK+mb9KyV51aUQZgpnOltw=;
 b=s4Aactj3pMwWVGPktsMfEhcBhBwyuKkrVkCv7wW3ZebzpNntT23v2JvQV2US8TgAlX
 +2X47nr6Ajs+VtKMRKRGQkF8BI6Fwzy+8L+veQvBoFeRmNNT1JBFoVKIHXe+N5Xe7AfS
 OQqmw5pU/wV2SPRRloQ7E/tme/ahkC9Jg/8GBnWKqF6W4GtsRVF5HMGtumZkdzQeDf4/
 RIqo6CVJkKKdWktuyZ77j/Dfo5eCAHypOJu78d927JHyk1gfRXfm8hEulQNwCudgtaXo
 6u2g2iMFZw4SvyKAMkszBWLKwxBO7Sk/Ela9L6yi6/E2qpeB6KFk3UKw8eQOup21Smhk
 Znnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=z25qU1Gd2RNparvr3msaNkK+mb9KyV51aUQZgpnOltw=;
 b=n8t8/MUA4mJBJDTKP6UJbM2WNtPdcR9A4z+EXgja5W4id01IGfSGBBlCmGZa0ZxoXq
 RVZTnTJnRfaBYGljbCUAIR+Wyis+h8D6nHNbLxAq4AkvO9+lGMbS1hPvO9t3cLoE2Di/
 23s+7FneOPJDPAJbmgIUYSw40kSdFXs9B5tGBS+70gtXfu//FMii8CirpuJ6304eIXm9
 SrTmSALYGGC952mpjVSaEgOaKlSlwfyv0wlOG71XTsxeItnrgHKeXGQRfeeG956LObeF
 B/x3x8ZFbn58cPz2OugjfIxpNu6LTmicibzLqN26F36dfuGY6rITXNYnpsv6zTBVwKdz
 jnGQ==
X-Gm-Message-State: AJcUukeiz80yJEGu2nP6TXfLm86UhSvkhRMeG2XEVuEYEC5Z1OzT7yR8
 JPmxk0Bv6+pqwU/emW+F8gw=
X-Google-Smtp-Source: ALg8bN5sUn6t/qQVtpNnEhk7IBxihKXCFbWe6/aOi3aISToUdQPZvgpZcIx2N+DMLp4St6rVeZH17A==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr12812261wrr.201.1545688869106; 
 Mon, 24 Dec 2018 14:01:09 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:08 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 10/14] spi: stm32: add start dma transfer function
Date: Mon, 24 Dec 2018 23:00:36 +0100
Message-Id: <1545688840-23992-11-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140114_920612_BDD2D2AE 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add transfer_one_dma_start function to be more generic for other
stm32 SPI family drivers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index bc8513f..b19d02b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -748,6 +748,23 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
+ * stm32_spi_transfer_one_dma_start - Set SPI driver registers to start transfer
+ *				      using DMA
+ */
+static void stm32_spi_transfer_one_dma_start(struct stm32_spi *spi)
+{
+	/* Enable the interrupts relative to the end of transfer */
+	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
+						 STM32H7_SPI_IER_TXTFIE |
+						 STM32H7_SPI_IER_OVRIE |
+						 STM32H7_SPI_IER_MODFIE);
+
+	stm32_spi_enable(spi);
+
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+}
+
+/**
  * stm32_spi_transfer_one_dma - transfer a single spi_transfer using DMA
  *
  * It must returns 0 if the transfer is finished or 1 if the transfer is still
@@ -759,7 +776,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	struct dma_slave_config tx_dma_conf, rx_dma_conf;
 	struct dma_async_tx_descriptor *tx_dma_desc, *rx_dma_desc;
 	unsigned long flags;
-	u32 ier = 0;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -829,14 +845,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 				   STM32H7_SPI_CFG1_TXDMAEN);
 	}
 
-	/* Enable the interrupts relative to the end of transfer */
-	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
-	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
-	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
-
-	stm32_spi_enable(spi);
-
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+	stm32_spi_transfer_one_dma_start(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
