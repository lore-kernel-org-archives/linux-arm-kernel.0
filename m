Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F3C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B680D20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZjmB0dC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBkjHG8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B680D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IbVYIQWeHRaq2obgB7VaMGMy2c4/RMHMhh9PWveEse4=; b=ZZjmB0dCdlnZ7dZ0Z++06oedYF
	3ahyxecFrfp8Od/oHkJkwCpPNgWsRlUPYwGgC2cmkXSgbhOhE65T+0g82TPZ3ewRYQV0lIYJ5GmyL
	2qEl4HntxznSItT9ARGzkqjNk4jyOOefF/G3ep50jDgmo8Sjy/eSf/3ml8RIM4vLNxqMJenb+YxgF
	8x2CM/RJ++wB60LGKE/y8FT0UtttfqWqDBS+VHxSyC7oEAg/wM8fgVFxTKirHNsQ8QDudndMoWY39
	YGVfViI4i7yBGxDHe9YN4T+RNF9jqWEl3oRbp5DpeSWqA76Hyt2DyjucGKKL9KJDvrNxY5ijYNtZA
	Jc6+Gg8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBjc-0006J5-A3; Mon, 28 Jan 2019 18:34:16 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBik-0005a2-U2
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:26 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so15111564wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RRgZHYe/sVOgOfTVgbFLvS25NV8X1dawYq/ksWlnIWI=;
 b=aBkjHG8f4o7l4eAKKLn0A5CYBd6ZjbqSwcMHrsKnKYYsX+97CiBkCBRosG00FDtOec
 6bj0G87MmFaIKC27H2bBs+H41I3bzjfQof/VXxY65M62SBLpVr3H1oeLoz6tIVhdXu1C
 fA825X/ocmyVr9XKqUYCZitYuJ7skV1pTC4Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RRgZHYe/sVOgOfTVgbFLvS25NV8X1dawYq/ksWlnIWI=;
 b=DHxeYMGERNbkU8s3BASHYnbWY50Yk18BRbl8/cIGYMADr+n9z3VdrUSCpTqt1xeae7
 aMyU7zsHrf02NwH5Y9Fe40y8NBs0Q3+AXcRCxM6gqOpq0LGvfq4lyw/8nNuKV2B2RLIX
 beXZhVTcXgWDy3Fak5Ls0YjvhbZGJkxHYQ5UsR8Uo1IaajH6NftDfZbCYUQPMEsq7hld
 iOJy+MP7y7v2mnP+nIn1FNFJiyBWihIfu3jtMvIOcJABjY/kMF8Lt3coUMJH6LmjzXx/
 YteHh/8urixohZpPz9+EV8bYTJT07hqnKuqTNYflUNVoCAI1gDIyT7mkXwQu1W5WXyDs
 aqsw==
X-Gm-Message-State: AJcUukfG1gX65OjMSogh4vdcdclJXGBJB2VgzzceFYzdKH1fszmK5v7C
 Lu2CTDpQh/akE05Sumus2QEnrQ==
X-Google-Smtp-Source: ALg8bN6cE9J4XbUBm/UdlGabrLL56GfQlK48Skq315vXOb+ojjzflSNy6lUxVrSh2ha2PeblIBB66g==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr18771984wme.6.1548700401391; 
 Mon, 28 Jan 2019 10:33:21 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:20 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 03/14] mbox: qcom: replace integer with valid macro
Date: Mon, 28 Jan 2019 19:32:50 +0100
Message-Id: <1548700381-22376-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103323_567392_E2A83389 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the correct macro when registering the platform device.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 0d64aa5..7a1b4ff 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 register_clk:
 	apcs->clk = platform_device_register_data(&pdev->dev,
 						  "qcom-apcs-msm8916-clk",
-						  -1, NULL, 0);
+						  PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(apcs->clk))
 		dev_err(&pdev->dev, "failed to register APCS clk\n");
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
