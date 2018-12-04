Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D285C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81422087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ean8ozJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81422087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVRJk671irnXSEWWQ0IRmNLempcf6DfsLu//rOQf4H4=; b=Ean8ozJswD4uAM
	8hR7wa5VyroEADUxVes6IAAs1xvxcSh6WXO8uOkjYrJXxgnBjfn6KXlVCKv6FzD5LBkk3BgFblJXr
	4k9vjthyX47M/gTAbPH8GNmJbPH+XXJuDUGZIYKprfOVbXr1Qompl7XauL/5QjcHIbpxhfpKZxQ3r
	2YOE6Q3j8IYfgle7ix8ap7NVbQbXvYyPG/GPkGQgSCqAn9RDZcbM5TUkRstAjpBoE3bIwzw4PNaK2
	fYZv8i2EYQP8OBuFcpEysdZyXnzCQB1mVHKlOWf70X+J/67vvlsHuAhwMjXOH7wTLmVcGz7ao03tF
	nVff1qqMjoiKFxqmNhiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU939-0003lk-14; Tue, 04 Dec 2018 11:39:35 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU935-0003k9-Dt
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:39:32 +0000
Received: by mail-lf1-f68.google.com with SMTP id f23so11670131lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cNeaSJewQo7AXSXmTlRQsr8ytveIkz3c28c/Of06XVA=;
 b=QiXDmYVQxtW03bx/otluzare4kK/jaQvAcvXtxENDzc0zHuC3CR5H6ZSjUEVX5lOzT
 COhkYAKOeOQa3ecPZgs2TlEkzDQSf4Pcny3K6KqTnBgJQyueafQRNPszPc3AVHdYFSaw
 wG2bAfZwAITpfdqIDcL8siW0DpEKLiKZvNtpmmN7AAFpZeUaxNzU0UHRQO9uqVN4tdhC
 LY35V/zfsIInUPoxAkar2lCn6jEn1LQGscYz8m3Z8cQcoJVLbXduCG9iiqe3/yToiWA7
 zgjkwzSxVJChZN2ja2zDZk1yI9dRyiYv/WdBJROywW9iRZPCGsY+F71VfLL5p/9hNinU
 uvVQ==
X-Gm-Message-State: AA+aEWbdYuN7ipf8SNLyay4I/6cv7MIhoR8WRGWUaU1i6ojDl/SdcHXc
 gtRBDdRI/zHA1YUPRtlwTrgJKLeaJ/A=
X-Google-Smtp-Source: AFSGD/WGPbXiwSzE4jKPtOlbYWM67fnnrX8eiQEaP9mRC9t2UdhES4t4nq388kSaR7O2DigQrVo5hg==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr8365647lfi.2.1543923559787; 
 Tue, 04 Dec 2018 03:39:19 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id d15-v6sm3078114lja.38.2018.12.04.03.39.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:39:19 -0800 (PST)
Date: Tue, 4 Dec 2018 13:39:06 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 09/10] clk: apcs-msm8916: simplify probe cleanup by using
 devm
Message-ID: <1c73fcc1dcb63aa0e5c65492692658a9e74f3c2d.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033931_463699_85443EAB 
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

use devm variant for of_provider registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/qcom/apcs-msm8916.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index b1cc8dbcd327..caa9b0d53d68 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -96,8 +96,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &a53cc->clkr.hw);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &a53cc->clkr.hw);
 	if (ret) {
 		dev_err(dev, "failed to add clock provider: %d\n", ret);
 		goto err;
@@ -118,7 +118,6 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 	struct device *parent = pdev->dev.parent;
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
-	of_clk_del_provider(parent->of_node);
 
 	return 0;
 }
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
