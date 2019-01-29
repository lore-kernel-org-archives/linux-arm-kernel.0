Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB038C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787832177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LvGIwSWD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="CL5xW77T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787832177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2qn2F6K/UDC9/jmALIY0QXT5xLf5tmJkPaKmjjN25k=; b=LvGIwSWDg1M9uu
	49ZoFI2s9Anag87MVupXDiP3c/Xwhw6VQUIlAigV9rnamchF30IKVLY7AHDJw7WQ/ilso7JFj3gVh
	Zp+fxaHZOA+L0pfeBby7np9LdboJ8czUYUtyCOJAwCDs13+HbNhOUnekr4hJ6kX70TdxA2gOe2f2G
	kG5cX2nA4eDQw3QPlFADe8MYMkEdE4ZZDRYUDnKNbSA2mYmImX4Ud8DJsovT9Tf7cFFqKtAE+mUcq
	tekWoOUDV72eXdF+Wyp4C5ohHUZTksboeA6lYzP3j21qm46Db2VW2/D+whir40mqw1UGx4AlEb6o4
	HdUt3QjKd2GP5ABG7vMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOv4-0005Ty-PY; Tue, 29 Jan 2019 08:38:58 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOv1-0005TG-9q
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:38:57 +0000
Received: by mail-lf1-x144.google.com with SMTP id b20so13955332lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFJ3nBA8p9KGkEXUMN8LgR+LVkNu7VqCUoJbVk76olw=;
 b=CL5xW77Thup6ohaDQqVmY1HP62gAvOC1xMEf+n/Mbwy7R9/dkXjl6tsL5bf7xyPdqR
 v1GpdH34nhEmAZ+kcWCqjBG0E9VDWJqcl/TJGdM4dV39rT1Cbc2okrCOIoHVvK3omiGu
 54Te3Wc0Au0j1SELZT75IdQ1+UXMpkoajMT4Q0kHL2OhBr7NAuP789CTuNpfiAQ21wmV
 eWF5Uxx7VkkPeLAeTPXLXIYMIDYIP+AQIawhM7X/qm96aFuL99oWC5c8FesqiAAY5Vx9
 sSSzXAc+GBHL0oC4tIsgNC2VM0e3XsH/K9AuVzq6LWNI0wLd+TceMDIsXRMvd+GTyUrz
 4iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFJ3nBA8p9KGkEXUMN8LgR+LVkNu7VqCUoJbVk76olw=;
 b=E7GIiufTrubswr+jdnuZVfY6Dd+pSdcZDwvlYx7VoRtIj2ZsqwpDxswLb3Y7Ca00JE
 hir6n4xBJ+QghEHCR+6dPBARVQWLA9VPh6KCmMWC8fAE+emuKJdPnfmdBzMXEN2E7eGS
 OTrQlo1lXfmM4/q/4eVvaHI4+s86AC0HNFHwVVcMR+WWW/+Q84j8xRS44H8xAqJgCUlT
 WRFuFaiV2CWEZrNl4YVQeuooSiddxRsBe4zHckugNRFwHYZklH6VT6HUfpXjAkX9KKsz
 WDmWMXp6u+kKryrddog8QGfazAWxn7bzAWwwKMtorfuYAplfibKyxPSn8Y6ERW7YXYyu
 aKIw==
X-Gm-Message-State: AJcUukeF3ei3uDyAwP0MmQnXcv+RXJDYEAuM9tWtk3ErokAqEb9Vctt3
 2P4EM92aGKx4zE9bPSL2EjmtAg==
X-Google-Smtp-Source: ALg8bN6lpEv3wzPw3S7JpYCz5CoMP59wC3+ohlF42zABtxIdUVUisID8Z8e8md6wy9SmjKO2ggClJg==
X-Received: by 2002:a19:660a:: with SMTP id a10mr20615215lfc.146.1548751131801; 
 Tue, 29 Jan 2019 00:38:51 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id v17-v6sm3378774ljg.32.2019.01.29.00.38.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 00:38:51 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] spi-atmel: support inter-word delay
Date: Tue, 29 Jan 2019 09:38:44 +0100
Message-Id: <20190129083844.20572-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129083844.20572-1-jonas@norrbonn.se>
References: <20190129083844.20572-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_003855_401811_8A8BF848 
X-CRM114-Status: GOOD (  12.70  )
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
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/spi/spi-atmel.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 74fddcd3282b..6389a228d2f5 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1209,13 +1209,21 @@ static int atmel_spi_setup(struct spi_device *spi)
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
+	if (spi->word_delay_us) {
+		csr |= SPI_BF(DLYBCT,
+			clamp_t(u8,
+				(as->spi_clk/1000000*spi->word_delay_us)>>5,
+				1, 255));
+	} else {
+		csr |= SPI_BF(DLYBCT, 0);
+	}
+
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
