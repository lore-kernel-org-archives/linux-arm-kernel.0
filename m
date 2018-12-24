Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A70C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:03:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86552070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DQcjniMe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ23oMi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86552070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Dd7xZyAq7yJC2Zp3oXfX40i84hAL0DoMMAfVcQ8ZYV4=; b=DQcjniMeGsKa9jO6lQ8Imd7klD
	zjs8EQc/gml9QVYmqBPG7jT6EwamjFGnDGJDpf02zNiC0YdESVKi3wNfNZe9WAPsmlAyYgENHFAeE
	9DwHV11KzIloA79uuOQC8Y1sAqVdtOWfaVUMUzBL07jaNPhEa+n3WFbv06LKpN6PIGjtL9ZecHFbh
	R8Ff4wNTTpmjsP/K3xdN64AqOvzYrrsu2yuylx6DaubblqIu73P+Rn62midfvAuQNmmxbX7l1aeRH
	V5G4le/xwvs6k2hcXPrSWNDRzZEJ3LPfA8u61ALz1lMkNDWk4UjZXZ6iALN7S8ujYSmQ94OBjG9EB
	HdUVMFng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYJf-0006Gs-Rp; Mon, 24 Dec 2018 22:03:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHi-0004I2-8u
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id c14so12557846wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GGnsImLEJas/NCseLAI8aIfWslIulfuhj1PcOtADAf8=;
 b=CZ23oMi6wENbcxj7WbCjP5YgM+0Dd+MD748+cmAHihjwVZJh84iUpzLtoU3aGf2l/W
 ZSY1mfxTel8ODCp/HT19RfKKwryTggajfhV9XAJWuL1pMFyAJrZhFkmdii83N9U8sZtk
 /86wVqxuT2fmIWn/r/y37fN53hGVMhpLRzNXllxmfjXX38+K6W1dTWmnCcTvLhFJPCW7
 oNfP8kL9zvptaBc5Xx6m3qVs/nZhKVzepQX47du4hq+H0JeVXDCkgMmeWavus44L3bk3
 BkBOP5Y3/1zg7FTN84UwbpE3TrdanW+UOAygHR0NsJeBZKfiBCA23xy8sFof9BXK47+X
 cZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GGnsImLEJas/NCseLAI8aIfWslIulfuhj1PcOtADAf8=;
 b=mGP8W9I99jI3uvLRc4q0b1MajgmWSRgX6QgieKWALWnYLX8fti48Z3uo5CfZ2nxvHn
 R1z7Y+89YpQBOdTvtTrJ6ODiHrpLHCROMU1NWwgOOIEhmz2JhHjENDflbOn52d7wPYQD
 g+aDzZN+HGiZvSIlwKPf9HKPOg4YH3aKsGTjFKHSC9NZ3ZHCRogdxLHue0QgG41042SE
 kxAGaaOw3VxifaeimUyaAyTQ8BbxgSqHQxaXU+vpf/Zv1FCK4uGZx6nBgEpxMHRJbV4B
 YmUs00yRSuo8jXxFMrxmdSb622IPKv0OyAgQW9Sh0IZM3fiL4bSw29dCZUgrpUjFqwKN
 NgDA==
X-Gm-Message-State: AJcUukcwBsFKWqbDfA0lSAigtFKmd5oBwXVnSeytT8roXBJfJ/4iO0Bs
 uBGjWKMj18JQyulwsx/StUU=
X-Google-Smtp-Source: ALg8bN40hFS++7/EeyfQeA3w3xfLqb4EK61aM566f0n123LvqurVUABzjFeqmBv8CMt9u8EZnA2x3g==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr13673585wrq.133.1545688862368; 
 Mon, 24 Dec 2018 14:01:02 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:01 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 06/14] spi: stm32: remove SPI LOOP mode
Date: Mon, 24 Dec 2018 23:00:32 +0100
Message-Id: <1545688840-23992-7-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140114_950285_BE1E9F21 
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

This driver does not support SPI LOOP mode by configuration
in registers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f7056b7..b639be7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1143,7 +1143,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_3WIRE | SPI_LOOP;
+			    SPI_3WIRE;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
 	master->min_speed_hz = spi->clk_rate / SPI_MBR_DIV_MAX;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
