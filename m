Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB59EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC36820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQORP7px";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="R2s3ESfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC36820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+YJ03BVXyK6+3NWB4R1cP6vjhduxSuAUs+b43OJppQo=; b=QQORP7pxV7hChp
	+cZn2qqQ/2HPc//Xn5qrcMLOt6pb6ey5D1jY2fOOSPyASBnIYsxZS3fnBLnsFiEEfv4KNT/F0kyWn
	8eyrqJKt7yHe8b+MV9kFc2C/RWVzF5/F+FYDJNR5oyxYuioCLN3OmmJSFPSMFq9s6RMorAnM6RMk3
	4V4ndFe0L9i/WbNJQu7kHV5UymNVDyBWGSnfvbJv1Y81nBEFA5CttcYKIRHe1NatJA+LLelXy8MNu
	imzzem7R2zFJSRwSqkiy+/jX/abIGTw0/THRI3kWpEhxm7Ig2QA3dn/E592M7bFUTTfw6sSow7ZFY
	osqD/BDj17Mi66qTZhEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goaPd-00014v-Cs; Tue, 29 Jan 2019 20:55:17 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goaPZ-0000Xh-Jm
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:55:15 +0000
Received: by mail-lf1-x144.google.com with SMTP id l10so15699289lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Adu7r7feIgD220eJhrZ8nREsuxr7WzIV5vIaaUUOmX8=;
 b=R2s3ESfnLLcxPKelxgl+NXEG8xnvOoijCdQhE07518wuxwwp0VMih0qBEWxulr+AsV
 q6sFN/bNB/N+ZAoRy5S/+rJDQOR4bMFDOVunBdWem8tPCRvchZt0Gk9QMyS6vRV6+9vU
 HFnDNPmjjWj/revgDQRb9LK2xRBiPB8dFhr2T1VEVB/1xEBB9s42JNyRyrozyTwy5bqI
 6nDwfnhs1c8RofkvOYeGxPAnrs+yMnif1a1pSa0R19GVUL/oi7YgREisDqDUa7wbUUYH
 pKdL2rxbl/m6EYvYhVaZpAh6YmM3SkDS1TBXXYXDi2tWQ7jjP+Yv/6QKPr4SRiG6g1gO
 38pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Adu7r7feIgD220eJhrZ8nREsuxr7WzIV5vIaaUUOmX8=;
 b=G0HIl9w5MX/g4e03af4oWrNGeD/H2jv94igWarl187jx+Eo5WaGAZtUNzpUkzoO7sQ
 yWlN2H9mBN72F8FBfK15VXzNBWvySU2yUumpJgZKcJNwrEQjG1Kg6IkDCNGqn9M02WEF
 1w7AXVjCwWXyxGvTie+XD+h/Z/BAmIZXrqS1oxL4ZFfxQZNvJ8DVtCKHjRJKcIrdTsgo
 WyGIdZq64XWi1e8rtA9ZtR4r+LsVcMB3B15sxDDkXiTtj0X8G/ViEDMufrBn/kYeCsff
 SvLw8fDill/Y//YBN2WFiHiq9CyUam+8Nc2alt8v0uJVDEmD/lLwnHjKmL5YYG3REOoq
 j+9w==
X-Gm-Message-State: AJcUuke4YtJFVOStzis2q60ynan0fvRpKOVL8aQVt0lxdeEay/5j1Iau
 VAS0VytDqUwDw6+85Ip+9eHzVA==
X-Google-Smtp-Source: ALg8bN4tEAq/wKoIVj0YK0yHNk+mhqAeMD87gXVK3Y26fyShCMUnlSClIx4Kj+/8zfro6UrYIRvSZA==
X-Received: by 2002:a19:980f:: with SMTP id a15mr21220369lfe.103.1548795307852; 
 Tue, 29 Jan 2019 12:55:07 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id o17sm3677287lff.77.2019.01.29.12.55.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 12:55:07 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] spi-atmel: support inter-word delay
Date: Tue, 29 Jan 2019 21:55:02 +0100
Message-Id: <20190129205502.7741-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129205502.7741-1-jonas@norrbonn.se>
References: <20190129205502.7741-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_125513_653855_CB313670 
X-CRM114-Status: GOOD (  12.32  )
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
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..57cc7110f9e8 100644
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
+			(as->spi_clk / 1000000 * spi->word_delay_us) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
