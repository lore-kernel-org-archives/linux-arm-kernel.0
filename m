Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DE5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB62120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WN+peyLG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oMpl0ALA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB62120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nn2GrKkstxEuMo/QX1Euz5H6A1x6BPylesfD0AFE7PM=; b=WN+peyLGt2E6NI
	6TRZHPinl3az4/9Jqk5QRSt4ExfaShIEX54M/OcjFv1uYpKfjpq92PagJX+sA5kiZZYkrN+8LxQfV
	H53pWaqA2Pt9dasjl1NTtw7e7btQvgT1ggdD5YQGs89LyN9TM8HHskIDGPw7N9SxnXNSwc0Vwkr3g
	bgSHTujvaTJ7wT6G33xs/9/SI0CsBZAMr6oNIfmRrBXZxFBxTUwh+j8YnmRATu9V6OBC11TZCPz2u
	+//jLXk0fdO+O3qM1D7Zm3KngA3UcRHVPa3004Gx1++o/bYaytENmBkNPDXzwjXXviZheh9aIsD4E
	okurS8bQjNQ0VJ1sPO9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOQ0-0008NM-Cy; Mon, 10 Dec 2018 16:28:28 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOGD-0007re-NR
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:29 +0000
Received: by mail-wm1-x344.google.com with SMTP id s14so11600516wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SS22PqBK8tWsdyn/FHAwZUavV4dNBBIV2/QUJd77h4k=;
 b=oMpl0ALA9vxGolpUGRPXPTFTlEuGqt8XU2UW+J1+kRVNZR+UkFW6NZi54Y1+q4yANF
 A5ShHj6CNV/Moj5lVh3DVAF17KqVl1oKB01MPypxImmzV+qjVOFe5y4+34Tn/DBLWaIC
 OYOnhYgZcZaax7fueoKLt1tiXL60i45TtsUgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SS22PqBK8tWsdyn/FHAwZUavV4dNBBIV2/QUJd77h4k=;
 b=UF3TKMaXIqjAylFGHXn3AhUgj5gsUrSrZk9EuKlaGqjcOfkTlknmU0TaIHYLCmlhYl
 IzE7fLlxir3j/P3ZVe6wM0rlr8dIVM60qNusNyT0qf30uj/qPe4sx63Tm4n8ptyiFXJd
 Fj9HUL0qON2MN4IBXW0pDn4uiV4bqGiapknP5HodFWRAhIeUZx3oPaFbMwgftfakpuDp
 yy9ZMLHlGsa+J5p7JGPIlZ5qz+9T8e8QOq611Fp79iuJxfDQ2UlrWCQaU5asjbRVgmv7
 C5zfIHWKBMd3HWj1TR61Fe/CWYk0r7Hnogt5pHZ9beXHCa17+083M5PhZ5vTTYffP00A
 LxWA==
X-Gm-Message-State: AA+aEWaraVMVhdnjOHQczEu9f4zmGy3jJmZ6999F7XaHPMfObmQHBIjb
 vCsotLT8bHg66OQTGWwOMLFYUA==
X-Google-Smtp-Source: AFSGD/UkunrLdyF1uFFqybjHZqBmchG32sEgRXZF3wFvzKBtIfF3Z3WDnTjOxaEb/dtfoyprq4epaA==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr11710901wme.106.1544458690275; 
 Mon, 10 Dec 2018 08:18:10 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:09 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 15/17] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Date: Mon, 10 Dec 2018 21:47:27 +0530
Message-Id: <20181210161729.29720-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081822_148421_7C186FFE 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi <linux-sunxi@googlegroups.com>,
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
index 181b599dc163..b623c8150b4f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,		/* Actual rate is 500MHz */
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
