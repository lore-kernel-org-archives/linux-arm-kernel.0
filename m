Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B8C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5EF21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZzXhseu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McwmtjNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5EF21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CjBSuDdMY55v9+AZIMOP+3UlBJh6s59MyUdil0fJO68=; b=AZzXhseutVnYTiYMKgIh2ngrxq
	ave+yzwO9md/xBUTMDyWiiMKap1+5WBXBYuPKx3ZssA33Dzgk12r1cCe1dTdMqP/9SvILsBpNEdSN
	gZWUicaxwq3XT4s5RgX6Ngzb860M2YhQ87oGxulFgIULGHXubCgP9JzCLwTdLJHDYjJfxWDjfSjp1
	16piMvf6QBCpBMmNjXJi5y6QeQA4hklfiS2ae0t8Flsb3XhPZKyMulCktfJg+Zu2Mu8AhFmGfjIUF
	5MnJg4x0Z8Ck0EfnWdirCT9NBUIGda7d2/AJYmsGZkErANgK9//DaKEb0uSze7Tm0Asv4F2TY8mr4
	Zz/hyxbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYI7-0004oE-Eb; Mon, 24 Dec 2018 22:01:39 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHd-0004HN-I7
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:13 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so12005378wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lHFX12DgGW+zTzGc5a848Bc5uC876FgFYUc+YWPtWvM=;
 b=McwmtjNp6/axCPfNmGt5fzAS0Msh6jstn67m7iK/rmbAKHAcCJ9BVS+VadBtbmFQEf
 d5QCPBtc5AATaNk8ChmRGB6ap8jyJY+QY1VeqTrNPBRqN2TL46Dn/7wPXrAbBzVNsrRb
 xxZyPeq/joy8IOCT9peXvCDBiZbZ4I7WzTlRHAvliO39t6uS6RhW8lxWvkt2xNiDctXO
 K9IUCu91tLxlZxzAXOEjnhCz3/Dt0i54oYThFNiKwn1KMfQ2T68D1GWEixsMIsvYyWPx
 glIQL9KA57jBAjPj7/S6XI5113bJDWsgkq5ay9r60ptzsMCb8cNaIkxxh8YVFhx+xKgT
 8abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lHFX12DgGW+zTzGc5a848Bc5uC876FgFYUc+YWPtWvM=;
 b=KFJlkIc1Nt3fOOqbHPkkzk3amBIRDQ2Ipawq40aCbmcfzmZcAklgXHzvdZ/TZ6uY1j
 dZ/UAvmVliR2lpxE9iqMpbWZkPAMwtgsQOP4qPlsNnZtCiDTHLyaUSUGECfZMy/dr4J0
 5ETMMIHCK4gGq+9yDa7riwtCZzcA9d9jjUz14WxXf0DyH2lKgNL/PMX/zPBzZ3t0f0Z2
 ZQYZqX9aPjacumkw335PS2Z/DKtepMb4q0BizZqslUUPlMvmbx8Y4E0acVp0+P+w08o4
 s+dkpqNwG+8JnEWq0qAzA5osIK0Ncl4uMLi2gsV6jgfjP/qzn3CKz3wIXOPWucyPBqXw
 Ykew==
X-Gm-Message-State: AJcUukf1NemgoADMYrOnpJq13P2UkTMZE7+0Mp9qEhzK0IqVCUf5NGKs
 xYgzVikCUYWicHvwErz+Hq0=
X-Google-Smtp-Source: ALg8bN7R2kRNFTbUYyGu0FySRHrQ0YHLM2W+FDSoVw+BsSCQ0kP6PevrUiPdA67OF/r8XcleIH7T3w==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr602766wme.101.1545688855770;
 Mon, 24 Dec 2018 14:00:55 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:00:55 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 02/14] spi: stm32: use NULL pointer instead of plain integer
Date: Mon, 24 Dec 2018 23:00:28 +0100
Message-Id: <1545688840-23992-3-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140109_920259_A494EF03 
X-CRM114-Status: GOOD (  13.34  )
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

Patch fixes sparse warning: Using plain integer as NULL pointer. Replaces
second argument of function devm_clk_get from 0 to NULL.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5f30578..51d7f72 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1100,7 +1100,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, 0);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
