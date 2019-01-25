Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1629C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EAE218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OjAuu1we";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="GEUhvkW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EAE218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JPW/I5L1stgJ1W4bLAveski9FT8DePaKoyyoDs9MD30=; b=OjAuu1weqmmtx9
	cckXZHdpXNWDxLwjXUMt23Sx84DA4b6E1QpREpDI/H61qiduwPqQT8hZWUdhXiZ6rKkMHPnMhdGlS
	o98plw8qKW/4y3ZxLhcfu+Knv6VjoQqSLrMMa/i+h5TrhXOA7L//EWTgVisfQBB0uXs5R2sz2g4vW
	2gx+k1BzOQjgmX+4zaOc0BxIXE2i0kNDmJwyot52MR+utHI37zbr8r/HMNSdm8bEaK5VRbbQr8yaH
	YXKPbWA0rSNAYWW8+BaxG0Ut+UE0LhpKd4aNXjhNRvOpb9vADHUNlZ9ae3+K3ozvUauORkfyMt+nu
	owx3dPQZVWzDs+RK4NtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzua-0007c9-4x; Fri, 25 Jan 2019 11:44:40 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzuW-0007bS-Qs
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:44:38 +0000
Received: by mail-lj1-x243.google.com with SMTP id k15-v6so8097643ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uu+GXREpN4UO7hWlKWeYJkb2H2GuTbzfegM7LkbZ/S8=;
 b=GEUhvkW0Aw6GHc3vSCXnmV8GTX+YAf3myHFSu3fzEAnbXvX5jP4hXHpfVi7RFjWnja
 elrrK7YvfIRcN9CgC/dZF3gn1rPhSfenaHc44zUrV1dK5Gl2X73Qp2C4YRSEWiyrJXYl
 ZErLRdaCPITbBF5zegxKL9TEv1aW3ySw7OiCPhQKLLJPLuw3ncrhK3VapBNZABn2IFKZ
 VEWtlB1mF61toNnCH8oEtzitthO/MpcHWX5gIyJyfqcLOEZpkLTVqrrrgL4rjQe962m8
 /VKS6rDm++8Wdg1694dCdU/BOaExp+AHisTiVIFzbC8BBmVLmh0fD8k/4qNxrb2NNgeQ
 3RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uu+GXREpN4UO7hWlKWeYJkb2H2GuTbzfegM7LkbZ/S8=;
 b=ExwimZFMJJRwctY1OuxQors5kY4saY5lvvfVL8njDrHG1nNQ7ZSBhOrcGgeS7mXjX5
 UqLeuGxCCuLwm1wJ38JxypsABbxj4sB486rrQO3NCcNNCZMa9ntGJoUvTl5OGOPPm9Hj
 0cJ4HoaszB79jbGJgPK9KGQjP6KLYc1V+nlBb17LVuk77fNfNxFV1JTA0eebtUrW2TW1
 b6ac6oomtfNaGskqqpFvbNc7PyGIhL994RFhVbwy7XRB06NdsRqL7Iexuip2n4pHWIR8
 QPGW5GCmi85X6uNItE4Wq/xuYw0qzQpgzlwPSHSM4siXR3A5zIFpFqrE+GFtx1Zxe/H0
 6YFA==
X-Gm-Message-State: AJcUukfjbEPgwUOKMXVNQnMvbP5I6pzTA0REmTGzU3/jJUAzqoBG4bX0
 sHUkSK3gIdq0mzxCq245FLFxqQ==
X-Google-Smtp-Source: ALg8bN6XRXLKpFi04wXl+PQPSrzZMHYzuhRqTgfnNVEGIcDJwLrq8NNqXEeEDxsjqRcBDXesy2Gkrg==
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr7678933lja.19.1548416674512; 
 Fri, 25 Jan 2019 03:44:34 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id l3-v6sm1490962ljg.21.2019.01.25.03.44.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 03:44:34 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi-atmel: support inter-word delay
Date: Fri, 25 Jan 2019 12:44:29 +0100
Message-Id: <20190125114429.20066-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125114429.20066-1-jonas@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_034436_876469_FB582336 
X-CRM114-Status: GOOD (  11.83  )
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
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 74fddcd3282b..88ff3fef56e9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1209,13 +1209,14 @@ static int atmel_spi_setup(struct spi_device *spi)
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
+		clamp_t(u8, (as->spi_clk/1000000*spi->word_delay)>>5, 1, 255));
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned long)spi->controller_data;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
