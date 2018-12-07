Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C01C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:11:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC94420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RVzH9QTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC94420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bj85HQydJjcE2NdNkr71FsMX1jdknW/AWvhC2H1lUUA=; b=RVzH9QTYnBijcs
	nIVVovW1wLuFR2jY1425y0hzy2LV0BZiD5dFOpE/kFDHPLXpnlljv55Mfrq8jUldB2Az7bpY2y6RC
	hJ4UmQK8fKQAC+iTq70WAU9TLU/D+s7g5bxYNTu2SCbSOGEfc7cF094euawG2qXLABwI7ez4zLO+m
	5RswtWP3VwAx0eWmVnL5Dz+CpdwB3UVLwc4PnMr6pAhRXXwY+SuKBLw4SP4JM7gMbpHECpGH7qZ0q
	QLbrqcfcHDRAzc4fmVlG6PxABO3GXyyTjzDbdGUDdKwAmL9zuO56Lr11wqtyWI49NiIJX4JbcF29p
	6my5QFOT7vYRrKOWFD9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVE2M-0007QG-BS; Fri, 07 Dec 2018 11:11:14 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVE2J-0007M9-Eq
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:11:12 +0000
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so3203448lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 03:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IPaANYg+BKvew3Ns6tmkF9qat1yGp0JhQQkX999AOmA=;
 b=DhKREUIgeCAl8rCb4187t9PeS6a5fLRe5AfolRZQ/JBpLNaQVCXlK2ZTBWIrh1oKeS
 g4OVy0Xnjx1rY/DKVYcrNvamPvi7rFnWwSND48eiiuxboLNKofNewqxOG+R8bBMafPiP
 gyEoyplPs+YrOwWW+ZTwF/Yyy75d8VUVVV+Y1I/kLwsYEk0Xuf67SZiPE0jq7Rv4wOCx
 naQbsrNqSUSg1c/FDelnFQI44cnly/VmnSAL8iAbt+p1x/4qyBz9a3y6lVPj44LbxA2A
 r2rfoEqmK4tJxWtEdrVI/gpUnvP4DN4rSG0IGZsVC4yDIyZzXObjVy5YBed68BMuHXzZ
 lVsg==
X-Gm-Message-State: AA+aEWavP4avmL2R16K9byllxSS7VhwOI/ypIrpuz1sZ4zJNY9hzevod
 IDWnUCl9C3rl1Rjk+OfdYqA=
X-Google-Smtp-Source: AFSGD/XfomwTlfwAe22p+SJG0lO7BIYoQtcGAA7ynED9gQVIJ8DPFu04mYExY5/4RW93QAjgp7daSg==
X-Received: by 2002:a2e:197:: with SMTP id
 f23-v6mr1095815lji.144.1544181059423; 
 Fri, 07 Dec 2018 03:10:59 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id q127-v6sm571001ljq.45.2018.12.07.03.10.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 03:10:58 -0800 (PST)
Date: Fri, 7 Dec 2018 13:10:51 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
 corbet@lwn.net, cw00.choi@samsung.com, krzk@kernel.org,
 b.zolnierkie@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
 linux@armlinux.org.uk, pombredanne@nexb.com, sre@kernel.org,
 vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
 sjhuang@iluvatar.ai, andrew.smirnov@gmail.com, djkurtz@chromium.org,
 akshu.agrawal@amd.com, rafael.j.wysocki@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 3/3] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <f40c69fc858cc7ec3cc722c6664d933ea6558fb9.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_031111_498582_77CEA81E 
X-CRM114-Status: GOOD (  12.44  )
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
