Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B3EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6197920660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ApQN8M+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6197920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S4z0qVCEppAPNm9Km2GpWN4oi37aen+nIdRjdjTMTx4=; b=ApQN8M+HvlmJGt
	kPNLHQ/maHZxAeK3qTGteokoh+fjrpKg7n3qX8WpdfwdOjhv8EXGZgNj85mLvdMz1ICWy+o5fmCew
	czxWa28VvjF+6Qa/9vYBpbtPyTUB5bUoEpvk3iCXmhrMpttTUIt0PJhNrT+ELMm0FdofLf39TWsjZ
	GFS+8od0BrnqPVFomgWUVkfBPv8fbjGa86R+EmwHsk4xDJkn84191/eAYDiJho9kBg160CWPiRPaH
	0+SqfHPJ4HZPvifX/5WIzdJUxEfmAFkd2LJk+X0+7d6fLi/mjXrGAb1ifCLRxPVqJdaSzyH4RKyBh
	QtchdTjVsZwNaUNZoV1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU92A-00039P-0k; Tue, 04 Dec 2018 11:38:34 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU923-00035v-LI
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:38:31 +0000
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so14603427lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=s0eoIBAlLdqa/lK+b31yZx/TLpcNisuF7h28Wa3I9ec=;
 b=NohyG44iqVPxcVAxuUhrTvIx3kGX+sHfSH7m0DJuuhkG3IvHccH/kDc+YJXma4LNBV
 QRq64ZfNNCRKT1CHeGcCf2Pk0ETseHV814KJOFvbL1vO0feZPFaXxWKpF7+XZPeWV76Y
 Zs7jyx0r7Z7o4lNgL1L2KLmSUBAOg2yYvv44S62BGEj5egy5GYeWeMpEmPrYUO1UQUIB
 PrvFA7pwlUVYXrDXH7vwqyeaWSwBvck8UpzsaPMbhVQz+JJrrTUbgd+jtdQOLyYGftOj
 JfIv5d9ZXdw/w28Bso91JFIMt8DY78yS5nLs2h42Kt/Cpm+ZajikW/ONhq3oh3flSRaF
 EXRQ==
X-Gm-Message-State: AA+aEWbsqUECAQHFfrhpzDfMfyyLVZPSDRFlYo4FTt+BR8KmfltxHDjK
 D00+JJuWttLR0G6ZVGNIbu7Cw1t++YY=
X-Google-Smtp-Source: AFSGD/Uvsg6v6MNTQzmy8FcIl7zel0Oo0WeO1tgPHUa42MfR8TPjKSMum2kB50pJjhclNHQStDf3VA==
X-Received: by 2002:a2e:880a:: with SMTP id
 x10-v6mr13737293ljh.174.1543923495868; 
 Tue, 04 Dec 2018 03:38:15 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id q21-v6sm3068085ljc.5.2018.12.04.03.38.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:38:15 -0800 (PST)
Date: Tue, 4 Dec 2018 13:38:03 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 07/10] clk: rk808: use managed version of of_provider
 registration
Message-ID: <d515dafab5f22e24f3c6dd9606993e3e1255045a.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033827_805913_40E2639E 
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

Simplify clean-up for rk808 by using managed version of of_provider
registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-rk808.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 6461f2820a5b..8d90bdf5b946 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -138,23 +138,12 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(node, of_clk_rk808_get, rk808_clkout);
-}
-
-static int rk808_clkout_remove(struct platform_device *pdev)
-{
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
-	struct device_node *node = client->dev.of_node;
-
-	of_clk_del_provider(node);
-
-	return 0;
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rk808_get,
+					   rk808_clkout);
 }
 
 static struct platform_driver rk808_clkout_driver = {
 	.probe = rk808_clkout_probe,
-	.remove = rk808_clkout_remove,
 	.driver		= {
 		.name	= "rk808-clkout",
 	},
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
