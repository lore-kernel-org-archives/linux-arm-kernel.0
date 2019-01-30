Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0511C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0EE21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvZcrGBv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="dmjrwl7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0EE21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/YvWEc4rMcUXSP9IQXlixXq/WEH498Gr8g+Z80LzbW0=; b=BvZcrGBvTfhKQQ
	ZbviN2LY9fPBjJrf4MFLba+5ZaPqtAr5xKHgly2BJvAQ77QA2qK3PA+I0cYg1hILpKsiEAWIcOhbj
	CitUFgn6sNlPjGmycuN9x7YydBzu7Q9pGL0e8PkMqPhe6rIgSZvJftwfjaZiXXqpUWdUB8ZOvYOZ6
	0zPmtYHZKyooO/ZQqUrdxkiY4K+NHiYKjKo8a/7T1GK1s9NXgxJ/ZgDPrqZQF3e+OUW4S/BeVwhyt
	ey9ffa+gbfM3emWBgo00OEIVCsv0CU0+2Ze/Rm/wahQwCEyo61Nz/l//0qLyf/kbT6v+z3hc86b0P
	yaqVqCPy60rQROg0xloQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golPv-0001UP-F2; Wed, 30 Jan 2019 08:40:19 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golPp-0001M7-RM
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:40:15 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so19962824lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4YH1qzEHTsrJPYWTxDoTQQojGlkWsi2+2TPbuMpCJp8=;
 b=dmjrwl7a+PyLOExvhqVETNBsg9L2raflvETv36m3+TLSGt3mG1OxVjze34yNEZFGPn
 POiZGeCQ4b0ABoPEzKomDnavISSlV9FKY7MVqalDKzp1AUGVPxsIt1woChp3imUwnz2G
 J1sdUj0q709LDqQmI5ViUIxnL7BGtHdVX32/joz7AW63jDiVoksYsJHJJXBppVuLXvAj
 kr07AqrIhJY5dQRVILRQg68DSN7vFRPdsiKziasuu7OweOEcZIM7ijPHSASBG9tqeDUq
 FA3hHamxpp5vrOYKjqu1GQYkxYoaKyYzGAiS2B1mt/jwo6JMF1zL2mJ0tt9O1cDVTz4e
 DAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4YH1qzEHTsrJPYWTxDoTQQojGlkWsi2+2TPbuMpCJp8=;
 b=gQkeKz03BYJJH3Y5xVZOPaxPTZw+V2UhfYkZUuXI4Bt1TbRPeeju14AZf2DtSif9if
 HcHHcpIeW+dBcJ7wUG6w3zHjQhAOccUgn5PLybidBoBPsbA+wBsPqR52jTl+x2Ils9wL
 jc/RHes4gTBYeZXpdEQb6nNMrk/0J8KsnC9GWXGYhXRiXzveXgD8i3Qai/ZBqJv+ZZ85
 jDHAZM49/rVe/j5iG3gHvb7LCdFN0q88xiC3dPVg2ZOXb7G+InKfpQFWb6kosHfXHR7R
 rR21qLynM/yaPebaW3MS4LcTpC4jH+XMVdLd8IEyKfln2mnDIw29cBL3lDldvO77nFeQ
 ck2A==
X-Gm-Message-State: AJcUukd6B3jwH9pn0RNYoAS9TC+8QZ4Fp2okGfDuA/LnG2sp73Veuig3
 E1YhC8ei+Phfgy3Ne68fEnlfaA==
X-Google-Smtp-Source: ALg8bN4N+z1oUOLWxj3BtwtxZeQyWP5iPwSp51f13wh7g+Yr3bzLODwzkmouBkcGq76+wFKvU+ZufQ==
X-Received: by 2002:a2e:8087:: with SMTP id
 i7-v6mr23266267ljg.179.1548837611033; 
 Wed, 30 Jan 2019 00:40:11 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id q67sm176734lfe.19.2019.01.30.00.40.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 00:40:10 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] spi-atmel: support inter-word delay
Date: Wed, 30 Jan 2019 09:40:05 +0100
Message-Id: <20190130084005.18649-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130084005.18649-1-jonas@norrbonn.se>
References: <20190130084005.18649-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004013_997592_1C408842 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonas Bonn <jonas@norrbonn.se>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..4954f0ab1606 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 *
-	 * DLYBCT would add delays between words, slowing down transfers.
-	 * It could potentially be useful to cope with DMA bottlenecks, but
-	 * in those cases it's probably best to just use a lower bitrate.
 	 */
 	csr |= SPI_BF(DLYBS, 0);
-	csr |= SPI_BF(DLYBCT, 0);
+
+	/* DLYBCT adds delays between words.  This is useful for slow devices
+	 * that need a bit of time to setup the next transfer.
+	 */
+	csr |= SPI_BF(DLYBCT,
+			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
