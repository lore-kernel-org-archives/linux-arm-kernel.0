Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C88C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFD1218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aD2DNBmg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="Be58ebP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFD1218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hoxLb1vzzZGh58tcjf9vVuOU160ttt8gX53iR9g1fL0=; b=aD2DNBmgOyBSl9
	+jydGjgX5t3NaEh0xY9jqlMwAtKj/71rHwx/EYAQT/nR4JqLSSHnWmH1EJsum7EqWdZ9Gv8ZXkoI7
	BZNHdTcM4+7gvD/AO7BEPYMkDfn9eax0WuvsExxamjYF925vpICfF/NhPcxO2emHTeaPg6W2LAV4N
	yWJb2OsLGXWs/AxBiAFC4ApP8KQbOQYi2Z4Mt/1AL+t9NEeA/cUQBfogs2CwDptpIK20q8pnwWovO
	VMI3u1qsjwoQ4drhG7NYMOmevjG1QA2hmb8W4rZOt9/XSawXkbxzkHq8hGdIjyylYc98zJ5Py/Ly3
	p963IFcx96oqN0Bi8sRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0XF-0007JP-OO; Fri, 25 Jan 2019 12:24:37 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0XB-0007IR-KU
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:24:35 +0000
Received: by mail-lj1-x242.google.com with SMTP id n18-v6so8202044lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
 b=Be58ebP2NyXkKjVLpYKmbQRZZfz3qxFpZX7JJYIlPVc6kI0GGagVOkjSCFTr14Ep+t
 FlIUuKrIHL8l2PmaM4wewKSzvatj23DhHsfnun9xWLo0OS/geLz2KKMzWndKvVEz+Oy1
 DTlyM6cACpHEwEssEelAj/7ctskzid88crHwIz36ABtIHF9JUT04DkyWk5t5Pp8KsKWa
 FeagTCAQNkJMnmDdG1TOui7yuBE4MZlzJCRRo8pN7L+2sbT3QFFCLKKieVOikawdEH/1
 /KTwz+u9RAwyEOcAfFs72Rocd5M1PIxQVf8Qa/Inbule02RoAPGYLaKSh0eZJGq0qKtf
 JiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H4asA/HrfRTCLZ9s+7ODb9ujqrC02barVnHHP3w4OeE=;
 b=fA7/H72AV7aLbtTmqyKL7OwV3ath28FlGRfrHwbw9P1/+0JXks+DF0GP+HzL/9A4pS
 KB3BU+DgBd3TIEd0Y/4crCSDrthkmHiToRu++CZSVpzlYAkzkttDNiR0ERooGjJNpCBL
 JnuKW5YpNt3LAQOacZ+IWHsqbhQjVdscyUgkx6TGk+qAbI6WXHzLNJrYki4Epsb6yj5h
 ZJbY7jLqOCwmE2fHzPHhUVbAB7R7rtn1iwinG7ih7uJXt6U1DNO0QnS71DqZ4hsLBHWk
 do2eV2NU/RJhd18Vu/yrnKA8Pdan5gRSiBL1ljsgDEcn+7lbRORmkiVD/ss2c4zStyNg
 Yamg==
X-Gm-Message-State: AJcUukf6Ums5Jx7V+N3Kbabwo0lC1YMli4e6/VGy/2K0Cy5F63uf5d6z
 8xrWvycEv6WiwWyQYB6uImoBT7tVtpE=
X-Google-Smtp-Source: ALg8bN4X4/JA2vr3rvz97Rl0G1OZlJYP7AKI1v1U8VIF8CdEcalqNEa9fD/7XSaILMfEB9KpjufNBQ==
X-Received: by 2002:a2e:7d15:: with SMTP id
 y21-v6mr8583036ljc.77.1548419070963; 
 Fri, 25 Jan 2019 04:24:30 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id y81-v6sm1508376lje.30.2019.01.25.04.24.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:24:30 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] spi-atmel: support inter-word delay
Date: Fri, 25 Jan 2019 13:24:25 +0100
Message-Id: <20190125122425.30676-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125122425.30676-1-jonas@norrbonn.se>
References: <20190125122425.30676-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_042434_310691_078F50F9 
X-CRM114-Status: GOOD (  12.75  )
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
