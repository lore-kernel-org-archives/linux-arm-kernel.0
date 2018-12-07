Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B5C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C73C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uIhe0huz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SbsVst67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C73C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gr3oYPL5eHitldSKeq6SxrBKUe/EE/vqb34jqpx4Cgk=; b=uIhe0huz53DDZl
	Z8KyAzL+CSKdgNkFxQwT0VBvXArQl3ZYdEGab4DFoi9/NI4VNaCBaqdzDk5rHmWyjNwwIiUdvlstG
	ymwx/ZM1QOAGvtKikV+1XKC4hH2t42jHjYuzsWP50+0vQ/7JuiVfC9+0sBKumSzJr4bN1mgUYocaY
	cVWI4es3vSu/6JgKVWXXZG1gNnChPmCBQtbAkHJ/UU6J3qV7bMiCD5gDW8e/FN9Ni2vfyN2bGfGX2
	wz3WTVUKpXAHe5Nl7UxzEi7TF+mThOoI8LAmKxCfUAQBpDuBD6cbVeotEcl1NIwm/UaWdmGSiiqMs
	Rqev5QUZUzCpI4/tz1LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEGd-0004jk-Dq; Fri, 07 Dec 2018 11:25:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEGb-0004dA-Sq
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 11:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C+QFX5ZVtWnMLn09mrcjeXEfm3+SxpJLl35PxOTC/Sw=; b=SbsVst67aQ7bk7DNnEGEGFMQX
 xwWq5ubj7qMqB+gsEU4V/MXkejmWwiSIt0M6nInKujlUp2CacBKV1p+dv9FZ96p1Uepljq8UYHTIz
 pC9pKPaKPh+4cHrAX7H2fx1DFE2oMPlLwsDnUuJisItcybTmZn69aaQ23O+AA1E7ldSOz42oL3LCZ
 mclf9PfIOWQ9NwXsG2cjhviKWziLS3F/GpiH8270YY5iEt0hcbf5758QTWhsraAQu6/VH9zlFqucG
 NoYnD060R6ZWtEYsk/UHRplBJTFj48DvH/nwqhzvzQafn5Fkl+5wOsE6ULCNSZrgZ6J33a5kUFdV6
 V4wq3RWOg==;
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVE1k-0005SJ-7j
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:10:37 +0000
Received: by mail-lf1-f67.google.com with SMTP id p86so2731210lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 03:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C+QFX5ZVtWnMLn09mrcjeXEfm3+SxpJLl35PxOTC/Sw=;
 b=IF6mUPYVPP7P9Tj5Em9RUCYP9hI4F2aCXwea9ikUooFCPnURqNOX3B2Ba+KBcSYlKi
 YGuVeyfHPc/D2ZISm5GneIIAY38kKjSiUpay/7MDOhiWf0GKyiOyS0Yx2np1nV/QT4PA
 IZq68lgf96oguejtMPAQrRqaHUts9KIovAyPaB4/SPGv2/SXGKQ64lWFyh1pvxaAQDiC
 XyU1HEJzX86zT0DjbT8XA5M+qlQVXBYWiVXdXqj3LcHYMPjZfZjOL30ZKLizb5lgbxpR
 DlZS7pSSa/l1+moR8EUxp0815LNNVEocOdSW60rQCijbAZQqexEZHIGjSxscQt2i1wLK
 iV5Q==
X-Gm-Message-State: AA+aEWZRh45C5agNRwsh2Uu9g0Kyw9+jbrDw1e2ECf2P/2Xa9c7bsElf
 54rsZCXpv6/rTpDAXH46V+8=
X-Google-Smtp-Source: AFSGD/Whm5MmfMrEEnOtTwnd4+77ZXPMpVbXHuumw8iiSi8SYe4BVa/dBSDett9NRYCGJAb1M6Hi0Q==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr1119787lfe.73.1544181024117; 
 Fri, 07 Dec 2018 03:10:24 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id z9sm533992lfj.79.2018.12.07.03.10.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 03:10:23 -0800 (PST)
Date: Fri, 7 Dec 2018 13:10:15 +0200
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
Subject: [PATCH v7 2/3] clk: clk-max77686: Clean clkdev lookup leak and use
 devm
Message-ID: <05409aafa108c77b2b878ed9663717c4b4a183ca.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_111036_266711_43DBDECE 
X-CRM114-Status: GOOD (  16.96  )
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

clk-max77686 never clean clkdev lookup at remove. This can cause
oops if clk-max77686 is removed and inserted again. Fix leak by
using new devm clkdev lookup registration. Simplify also error
path by using new devm_of_clk_add_hw_provider.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Please note that the patch #2 requires this change to work correctly:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570

 drivers/clk/clk-max77686.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 22c937644c93..3727d5472450 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -235,8 +235,9 @@ static int max77686_clk_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = clk_hw_register_clkdev(&max_clk_data->hw,
-					     max_clk_data->clk_idata.name, NULL);
+		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
+						  max_clk_data->clk_idata.name,
+						  NULL);
 		if (ret < 0) {
 			dev_err(dev, "Failed to clkdev register: %d\n", ret);
 			return ret;
@@ -244,8 +245,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
 	}
 
 	if (parent->of_node) {
-		ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
-					     drv_data);
+		ret = devm_of_clk_add_hw_provider(dev, of_clk_max77686_get,
+						  drv_data);
 
 		if (ret < 0) {
 			dev_err(dev, "Failed to register OF clock provider: %d\n",
@@ -261,27 +262,11 @@ static int max77686_clk_probe(struct platform_device *pdev)
 					 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT);
 		if (ret < 0) {
 			dev_err(dev, "Failed to config low-jitter: %d\n", ret);
-			goto remove_of_clk_provider;
+			return ret;
 		}
 	}
 
 	return 0;
-
-remove_of_clk_provider:
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return ret;
-}
-
-static int max77686_clk_remove(struct platform_device *pdev)
-{
-	struct device *parent = pdev->dev.parent;
-
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return 0;
 }
 
 static const struct platform_device_id max77686_clk_id[] = {
@@ -297,7 +282,6 @@ static struct platform_driver max77686_clk_driver = {
 		.name  = "max77686-clk",
 	},
 	.probe = max77686_clk_probe,
-	.remove = max77686_clk_remove,
 	.id_table = max77686_clk_id,
 };
 
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
