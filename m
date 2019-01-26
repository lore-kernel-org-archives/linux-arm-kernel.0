Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFECC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFDC218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBI/Yta4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="1Dw3YGg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFDC218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hoxLb1vzzZGh58tcjf9vVuOU160ttt8gX53iR9g1fL0=; b=TBI/Yta4nBnnLJ
	4dNk4GIV6kZebOozz0y+wJlaTCLbQMjMpDiE7Duj54go48Dqh2CSfjlTYtCV5LopioYkTAxj/4sRX
	EAwE0sH9usq40Yj5vQxtSnVhJFgNCNjH0LzsF6OnXVkSZ4aT3rHBSu09m36UVyELMwYVwS4Im7gOU
	DLvhmG6AGc1iL5gfhVEXgCLM/DYuloj4R9ua1HPk84rBRBTkAYfphNWSwKQVIlJkrUBP6QKbuJ2hs
	gsYeaSAcLkQjDQGEvPbh/Np5HVG6NsCFLJFJ5kA/B6LCwYdBr5xSBpfwaZoVWINz+azLjtaIV8hIy
	HlQuRIPUsIn/sb2+e/CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnQsk-0000IU-BZ; Sat, 26 Jan 2019 16:32:34 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnQsg-0000Hh-3f
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 16:32:31 +0000
Received: by mail-lf1-x143.google.com with SMTP id n18so9018369lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
 b=1Dw3YGg8xJI9+QrCu/LPqQ7Tr/GpytlL6Sj9JOqPWV3qR7JsVOZvTwcLkBmBXK2uSZ
 TFcurMiTzkCaWD95yVxh4ISXWz4SAVqgOKY1IaZeYUf/9QFNcV5k7bFGLvIHyADk5vWy
 +YN52P1zK5m6I6mEfnSzjP8VWEep9DACZXPu6VHTUPEnrcK28uoeDKgzsfU/E8PH800R
 HaXLsnx/buy6A5AdzNPoivt2pFHTu4B9tUtKGGpSKXpY9ygCjl8VdKWo/P9tOtBlfeyL
 shX85Yq4wrOuH5UporbikUTEjIY4YqXfIDN1Ar/apyBE8ldFeEmDCvW4015QH3UkobIS
 lhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
 b=DSwwm5jHn4m25HDaAF2kkP1m1e78FU/9bo1x1MAFq5XbLlu8bLyMG3bvi0Dl1cB7dy
 GBpOaA7QlGw1vvaCziMmpmbPdot54RT+wsx4bnVVJQUn+7jkgdZQ17owgrXxbx/gZ42U
 NYkysyyUfQZ+deY8KAwKm07zZIZ8X3bUMNl481Vl1uA1ufsOw1InV5O5FhdDwvsuk3xr
 k7QIHFs3b5Cf5RpuJMH8OVTa2JPc8nzNotf7r0qzTiNL7vcoBFcrG4y97zyPbkfQlqSn
 9Gdd7HqH7FYhi1BZVlrF/aAs7PoACaxOXA0Hs21Ey8+01XinvNmlnsrxm9Kxp0222Oa/
 yQcA==
X-Gm-Message-State: AJcUukfT2E0vTsTDGEJIdN6+xwsOnKvVksvuEwB/h9GggkjhhdBpoS9I
 01pAzEoQ63y4Ddw3ujSc0AsqBg==
X-Google-Smtp-Source: ALg8bN7ixO5jynANWXsRXQCc6pion+WBh06LKAJNIlpvS/JPjjM6Ib4nje2yFpEoX9h2Cy6IwOzaeA==
X-Received: by 2002:a19:c4cc:: with SMTP id
 u195mr12471052lff.141.1548520346833; 
 Sat, 26 Jan 2019 08:32:26 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id e94sm2170532lfi.23.2019.01.26.08.32.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 26 Jan 2019 08:32:26 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3 2/2] spi-atmel: support inter-word delay
Date: Sat, 26 Jan 2019 17:32:20 +0100
Message-Id: <20190126163220.26421-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190126163220.26421-1-jonas@norrbonn.se>
References: <20190126163220.26421-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_083230_153526_ED62B877 
X-CRM114-Status: GOOD (  13.19  )
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
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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
index 74fddcd3282b..24445bfbd74e 100644
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
+	if (spi->word_delay) {
+		csr |= SPI_BF(DLYBCT,
+			clamp_t(u8,
+				(as->spi_clk/1000000*spi->word_delay)>>5,
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
