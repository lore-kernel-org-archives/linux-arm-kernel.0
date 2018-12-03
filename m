Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1289C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FC120848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxinW6K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FC120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ZP6tsZGTxewNaWC9OBecNMG2ahLcPcbsOwx6HVJi0U=; b=lxinW6K/yAv26V
	MTZYjcE0qPccaY4N6Orl6fFysBZzsZDskNHnuBM05ThT5adHgFwOFv9oiVn7Z2+m9yqOZ/0ettkg5
	2jc9Rb0WwqoAt2gJo3JR97lmBQYx27J4PoLC6qwqTE87LO6upCxTQz3doS40JTba6CktXE31tw1kz
	7fYJtFmAZ1O0mC0cBlQYSsvTd1u6oMocnHx02ggRmJzdHFsgGNPYL57xUS/7AYiCg2wq0dnYhxKbC
	zwzls9qc1NPA6rl5lnlvhfNKd21ExIAgqbV+HtNI/i5hu9PRJv+nHoE9mzbYdcZ57I8D9hvel0n3L
	UyP5OJO6CDbmPIquhWug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnDa-0001Ts-Ta; Mon, 03 Dec 2018 12:20:54 +0000
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnDV-0001O8-LY
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:20:52 +0000
Received: by mail-lf1-f65.google.com with SMTP id p86so8950525lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4fWmEQHDymzQumdk/aytbyrz8Sfb7MJtwS0fcAz0+8Q=;
 b=atc9K/XTYTP/cxAx9Vip36EgzVJ85Eb29tYX1osDLuF3wU7wNoZniIYLtO6CHWG4YD
 3RaYlB2G2T3gj/NHiL34K29jFNtvxHyVWDKTF9JHd1W3aPBI3g4Jjk91xUAZ+tcgvIH7
 LEpSxHeD0KGK7bmSO8OUyTCuCwi8aEDvzDxGidpO/anI9xCCd69xT0CNPaoazrhYBk3t
 04leuHYDlz6nm2wp2+YizR2hDWeY8NwSSVqZA8D1esxXj5xvnqppFvAULAthyTWMsgIW
 mJqsiIYZ/4vK3nCs32DheW9cbHTXnuerGsxxfVt1IY87RPjAkixjHWmzl2KrlKfnvMF0
 HLxQ==
X-Gm-Message-State: AA+aEWbHfvA8Tiqvuzj0CGIW5VwSFGJHYZNgQCBB347Tkft6McvAF8me
 FGMg+XbirCBtgsPWeplkcMA=
X-Google-Smtp-Source: AFSGD/WUn+TU8jWSv6p2bow14ZEV4fNB+5lLXo3ld62urHnH5WLQdIkJ6KONpT1VZAHYGoeTi5pofw==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr6230009lfh.6.1543839637235;
 Mon, 03 Dec 2018 04:20:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id z15-v6sm2688556ljb.9.2018.12.03.04.20.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:20:36 -0800 (PST)
Date: Mon, 3 Dec 2018 14:20:23 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 4/9] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <397a0da87031430a4c50958f99f0b1e35cb01e85.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042049_784917_2595ECB9 
X-CRM114-Status: GOOD (  13.61  )
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


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
