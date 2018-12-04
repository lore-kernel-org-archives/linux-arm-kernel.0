Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B0EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D401D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UKUuFlHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D401D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bj85HQydJjcE2NdNkr71FsMX1jdknW/AWvhC2H1lUUA=; b=UKUuFlHdRMVG1Q
	zWG2Zw8jHbkuD46wBHpOPfYCmOwjGIqbaYwEqf6amvWd5+2LEZLpynVF6wZiZ3vPVfk5N1sy7oFd8
	mrDwpu2MG7YLRYvv9M3k5c1ZrcgQ7epSgjLr/l6wvKa4VVsAIu1zOSIbv/hSYVX3xlwAty6J2pAZ7
	8sF+WuQ5uWO49o3/Lyy1Ai2CIsrh7lgxd78V6qdMNV5/04OXVlsEj3SeDt4fJuMlAx2+ZHruRZIZ0
	ewryTpSiHpH/1BMwt6wvaRuaXJWOqfbL9QPV/fs45tMo1cl2QlBYb+O76Y1cLdgC5gUeG4FeQIeK0
	NCpDXlZSNFwU7RiLcvWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU912-0002VB-2s; Tue, 04 Dec 2018 11:37:24 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU90y-0002U4-Sn
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:37:22 +0000
Received: by mail-lf1-f68.google.com with SMTP id i26so11705738lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IPaANYg+BKvew3Ns6tmkF9qat1yGp0JhQQkX999AOmA=;
 b=He630TzMXpyQD3+hUzpGkY9SWvlwHNU49oq75UwbKBGq6IkzdjA1oKY5kE409+9dRF
 C9PrFMT+oWIjPxsNV67hO6sLTF3B9/fwq3qQ+oFEEq6oF7GxxFHr1Ze0eIHq08V0yJQk
 pAaNfr8u320WtZv8zBlvSyAxU00VNX7cib141UIjUibhF1L/KXX5BurbecXBHOaVkuLT
 8lw6VQU5D4/Smdd0gDUkPOOoH+GkmJmpCSn53ySwaGOmfwX7Acsays2slTxOyvh1X1Po
 4tCUiL4VZh8my0eNLu1+fmPgOamPIKodf6wnPRB6FkfZehN+rOcUX/pYMnwlcsJSM6FW
 BqrQ==
X-Gm-Message-State: AA+aEWbTJ44l7XJQzMIc6K02d0Lpa85yYFTb8wwRPYztiiTAqcGE9Vo3
 LpkD00YF8h2k2gqlC1d/jOE=
X-Google-Smtp-Source: AFSGD/Vp5vXzXS4X9QTXmNF5hhCzfpnIqUNuj24oPKEvSrTWjEa04sxBZOR8RlzvO3cj6YwgW26BQQ==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr11966423lfg.36.1543923428923; 
 Tue, 04 Dec 2018 03:37:08 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id a20-v6sm3086214ljf.28.2018.12.04.03.37.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:37:08 -0800 (PST)
Date: Tue, 4 Dec 2018 13:37:01 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 05/10] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <f5222457908099bdcbbbca2f3138c34abf7f019c.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033720_953737_7235F8AE 
X-CRM114-Status: GOOD (  13.24  )
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
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use devm based clkdev lookup registration to avoid leaking lookup
structures.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/x86/clk-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index 3a0996f2d556..25d4b97aff9b 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -52,7 +52,8 @@ static int st_clk_probe(struct platform_device *pdev)
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
-	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
+				    NULL);
 
 	return 0;
 }
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
