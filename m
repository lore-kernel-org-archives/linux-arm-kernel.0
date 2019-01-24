Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF93C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA47217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tdHMScKq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MtJBCmuz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kYXku2+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA47217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YG4vYO+wIIqJP3h7G5XFOsaSDamAvETZg+BxQ7trM4o=; b=tdHMScKqLKNnSn
	ugIyj3mtek+G198NgGxnbF452n//QTsCNq5iorhiDLSCx6C0EefNDByaX+FUYKOne+YIjKUKudTjL
	bY/50wZa1tMvYgeQ9vD5e+sTex5hzhBqPIvFp2DyDTSk6oPEJjiLw5DPB1Ck+HqUDBMHC2TM6mRLm
	jwaNxtsYGEVQMCZ3x7kqdlXvb2nvFzS//vLhUpZqJK9de9Yg/aMuCMSyF2javXCw/DHOFpaTPMGwZ
	8ruMWpSLkgs9N+V8rQonWope9GUPP75Bl554EcfFhQyslKl/dqd/iR6EUy9ibYYZgrPtpbivo/kJ3
	Te0f13awhLnNeOHxqOLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlQr-0002S5-Cp; Thu, 24 Jan 2019 20:17:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPl-0001O0-Pp
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MUFV3EbRWTylHEUKUIeOqSoI6gTTKiS0hGHS2pg+s1g=; b=MtJBCmuzfV2VsqYYpETnpVY6Fi
 BUmPXh9e+XKUiepdAkO6O2DU4w6QIBSjeRXhSrfBsPmMB5QLrqgVKbvNvFmPgpKUrnSP2jV+zOpuD
 G0yFigGP7EUVXw5rsbnXk/cxrAi8spd1kS3g4LkbEOSotAPJ+hIGhirXMqCt2gclEi6J3YfmKtr1k
 JlI2RFq1E15kuMxUNtzlhV4ZcDEA2QvdKrBuSJXTXgmQ0zgvStsDnRi18xF+CNPUkWMD7IB3lKieS
 UmI/SzzfBth3wRdtAq7bEE76aklA5TMjLgpmsJavY3cp/xlqSvzu2VlX/yvgxfDmi8n2WjudixRyE
 d/4jGVJA==;
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAh-0001so-96
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:20 +0000
Received: by mail-pf1-x442.google.com with SMTP id g62so3511222pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MUFV3EbRWTylHEUKUIeOqSoI6gTTKiS0hGHS2pg+s1g=;
 b=kYXku2+URiPTdGUN0CnytsHS0hqAI82ylfs+dKmCWQEKJ+BdxgbLh8PPphfZPGNePq
 /96+rmiOaEGSTphtezeUvV1cBmZLCTvSe8ZnniWkfWch6nY6PK715P0JCMiHKchP0yFq
 XLJ8t7+p4LPR665DNVYy0yxzgsbmTfwwiQJkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MUFV3EbRWTylHEUKUIeOqSoI6gTTKiS0hGHS2pg+s1g=;
 b=etWSXk214yzct95z+WpAPeU6IgnZ1brznieaViJdCa//k+ZTO5Fmf3QNDezmZD61Rj
 IBhVHs/xqZNuPe7Rf25FptfnrDrrGr4TtuamtDAipOMI+8YKtHjBHWxtejkQaFgcG3Dt
 YklhiGBNjOqec1FdIZubRtBHg36S0HQFUjjuT/7qAGeW29rEDJ2TsSTH6Hwd6TFIs74/
 yGQMd0osDdWxvirlStj6uysUcc05Z65FzPXwWIQ8w6tf4bJrhuj8eatb1Ylgc8VYCNjD
 X7gRL+4kMrQ7eWdln81lFzXra8WdL60NG6ePFVSuMoFk+M4H9lll1KVAPXSzD9nELrTE
 Zp3g==
X-Gm-Message-State: AJcUukdQjRUFGTCzBp56oYse4QuaUv3aTp3LjUN0pBtWZKVZOz4rnM2Z
 z0r+BUnl/tLm1/NwRsq7iCVXUg==
X-Google-Smtp-Source: ALg8bN5RmRe8ODy7m+XM46GYuK17hUEAO1Y4XOThFEHBmaFLnaGq3Qms+U0Xep8wBNGFIGPxjc1hGw==
X-Received: by 2002:a63:e950:: with SMTP id q16mr7211887pgj.138.1548360017678; 
 Thu, 24 Jan 2019 12:00:17 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:17 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Date: Fri, 25 Jan 2019 01:28:49 +0530
Message-Id: <20190124195900.22620-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200019_361764_E2DA93A1 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Minimum PLL used for MIPI is 500MHz, as per manual, but
lowering the min rate by 300MHz can result proper working
nkms divider with the help of desired dclock rate from
panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 932836d26e2b..296d489aad6e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
