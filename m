Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF03C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997472087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eb5paXAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997472087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F9BqDwba0lDLVcrlVz2hZCyuF6TNE3jBMD4ubrjkZ/E=; b=eb5paXArm6dvHa
	0uVIlAeeHgEgCay1ydiSnuRdkZ9LED5D26eRyTJaGSC9YFxjMMFiK54Tgz/YoxEIuIj58vU8KsD7M
	OhDlGzF7LqDRpHv9Ph/ktruizSOcPuUM94dIVhKiUucPTTUyV4kTMDbAJ81dlPMAy11PvCwqwTDW7
	Y8LA9f3UNIF43H4RN56LXmptsdMXWfuLNazdpyuhgyrYZcWQ1ZP5cWx1f2Jw7cyIf8eT2obm00Ucx
	aK3kSXoQb1TRitxB2TpBarz+AgH2t5Ir8TMmoiOJVdidT3X87NMX9gZ495Fanxb0C9OolpJcKe1T1
	MtwUNEtL1wLhb5cAC2EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU92c-0003Q8-1A; Tue, 04 Dec 2018 11:39:02 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU92Y-0003Mx-0d
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:38:59 +0000
Received: by mail-lf1-f66.google.com with SMTP id e26so11709306lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZdU1eWJ3OUe0zNYgDLJWqUhZGKZPNEOFUSCmMYIOKrc=;
 b=jhcSlf7EzBtY+r1zarDIwB5xE4gyhE7mA/sOrhaWhMJyoLX7jVOvR8wJke8exnuts6
 UEj73JI7y2sgYsnEaRgtKmwrUlGZt15q2IPoPt/RASdvuS+skMVd1xR3LU37XcV19kTj
 3oigF5m0FlASJecV3ebCFOMlF6FAfpiII8SMx+ZWLhivhkCiEBuFFDDYbm+A2dQunueK
 J1Rp5ar9u8JdBCgNeBtjry9gBYmu2oMqt6VImLFjCTxj1RutHIOkH9w2MkqCUY4areII
 TinO4FF4z0MWKkRyNtb5fycarKME+vLzpjQREHecmPP0V6xWma+s1sdwx8D185/pt/i6
 yq5Q==
X-Gm-Message-State: AA+aEWbYwlW6VeYSqjaFd8hUEB/fl8PeVN0T88gOYvFURkd7OIPeANbF
 SGFczNNcs51U+pDc0obFsAA=
X-Google-Smtp-Source: AFSGD/V1xPO8IerCWDRq/eowaUVH5Dlt/SrQkU+0AKRmpC8SX2ZuRWhXGwxxjPIdY1NB+9b4oHQB5Q==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr8364473lfi.2.1543923526355; 
 Tue, 04 Dec 2018 03:38:46 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id r27-v6sm3146758lja.65.2018.12.04.03.38.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:38:45 -0800 (PST)
Date: Tue, 4 Dec 2018 13:38:32 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 08/10] clk: clk-twl6040: Free of_provider at remove
Message-ID: <e00097fb5b52f1d4002c8febdb3887736e84acd0.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033858_048979_D70E2123 
X-CRM114-Status: GOOD (  13.15  )
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

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 25dfe050ae9f..ea846f77750b 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
