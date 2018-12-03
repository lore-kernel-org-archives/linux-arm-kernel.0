Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F411920848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNbe1gyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F411920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c9edhVeDphT/J1ySnjVWtvDU7b2Uk/DJK3i30gIfFPw=; b=HNbe1gyL5SDNjN
	5xyeH31jjFPbD1+4TsIZ6NRB8Eczawa/9jfCADegBm3pzEigmlbdPceWritRZqBaqo42UU8pzVbMv
	WPz1cCa1Cwc5e+LpzfAm/xcwfqndCPN5jJGHRflKGdfZAAoo7LCMbantm0u1kO1mV3iH2jk7nbU/n
	2s25knPiJ9roPsRXPAk+CCIuOFCDKMRqYPvKU2TDLFjDp29TE5WLBfuNHb5EyLAVSSQyZOrIIOFq7
	jo4XLzGE8Ixgl/YXNhtYeZw4eEdEKD46BGVpbXi8lIiVBn2cf9/q4GNV2ErML3zFot4bNud2Gklj7
	dKJbrhHVXK/WugBHt3IA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnFP-0002Gs-D4; Mon, 03 Dec 2018 12:22:47 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnFM-0002G9-IV
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:22:45 +0000
Received: by mail-lf1-f65.google.com with SMTP id n18so8952223lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Eg2ufM9FdHFhTVDmxheR3tr+ip3I7Xl4uZ2RuWzUJVA=;
 b=rAke8b93EUIaYFKwgEl13zALOXmh/JVCYfq90A3HUfqNeunYM4kBhLB6lN634aPJsr
 L/s57zV7tXtWrmcXgF2yNz+POO+bMyhqIhzH0MlqRWyOe0MHAQVDClEfVSQbhHkGWEvw
 EdioURiorqp1fx1ett5qlSAQ+mPtrbXfG8zbILZpW9V+kfQ4dMRPr90hdjFzxGgqmFYV
 dUFnwy34UQ3ayEpV7IwcbqWOf97iaaFgqNizccYP4NN9UayogJVuPfLAELX1u//HG1Kd
 ZjkVgx9qntZ3TuZ3P6DeaU/60XUZPUzB02unQZxFJPUn/v+mmRou2AS8Dz583cAPa+RB
 Eubw==
X-Gm-Message-State: AA+aEWZvTDbUB7FcV+GlvDLxv3nxDljuDBe1edxnzd6/oSbSzwftmwQQ
 +faQeXfpTxxgFc7+7IWQbho=
X-Google-Smtp-Source: AFSGD/UW/Y17SkEXDYI/3asKglm+pxUJcs8KkBfsyv6BBri5+OgsNM/kNXDc4ufMa+saFjvBX1uM7A==
X-Received: by 2002:a19:2395:: with SMTP id j143mr8716004lfj.107.1543839752957; 
 Mon, 03 Dec 2018 04:22:32 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id p91sm2362753lfg.4.2018.12.03.04.22.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:22:32 -0800 (PST)
Date: Mon, 3 Dec 2018 14:22:17 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 7/9] clk: clk-twl6040: Free of_provider at remove
Message-ID: <a7f245be2d788bb303fcc51e3d372f647b850c65.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042244_604994_28E03500 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, lee.jones@linaro.org,
 sjhuang@iluvatar.ai, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 25dfe050ae9f..e9da09453eb2 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+			of_clk_hw_simple_get, &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
