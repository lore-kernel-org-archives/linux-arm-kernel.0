Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E66C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E9F20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIqfwiP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QpH8HecrNR1pLzLREtiGkpldbGFuuAbIQrkjJyF/58=; b=NIqfwiP4z8V1u/
	SU7/VFRHZstFIcq4uu4dw5l2NtAtKUDP1K90bk9M4VquMIPb816pS1fcZAOq56sK5Ti5RU6vrrDSg
	L5gTd5NXfUy+VDO+9Xhr9CMv+wWW+T5oMjsxnMeDFuiCpaoR7nRVQAyDsD4FJZ43Jnis20XKL0Awr
	ngWpBmJkiGtqxjJN+UU8HXtfdpC0lkPWd3PZ/BVWaQu6EoH27Z2KFknJLDds8+c+roxF5fkY7QVb7
	XvssR9Wh9Y9/dZDNTa1OqBes8L0c3IGJAmw4RvcNWSr/+H9kTjorZP81ehrsONKHiosFom0MOaJYj
	bz38tsR5kFOS6u5gB0uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnE1-0001jt-VT; Mon, 03 Dec 2018 12:21:21 +0000
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnDz-0001gZ-5G
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:21:20 +0000
Received: by mail-lf1-f67.google.com with SMTP id p6so8959158lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GkHc1XDfS2zAEG1O6tNrzFVGgOycf/0Y3wU3cQalzu0=;
 b=n6MVrYkrWgTfXbQl+iGM/18FnaG2QXNPVW9TXZog3SCX0sG+xgtAw658kFMU7YOMSk
 qnECYtPdw4tK6k/vMd5UPWzX+skAFnfOhujCgyVt0Ry/aIpUAQBJUv+0aN6cFbDd+11D
 ymwPIU2OBSyogi9Q1RfSQxD/eE+aGjgdxa3hOUX3dHPIDLgMf+WP+vdPBlPD+A+uAd6x
 z0UX/Tf3NmW1nx+gYCyo9x0enEnLOWhaa5ml1c4JjfSDem/dNJupiQnsD7vglZ2raKJ8
 2BA1FyIVwyLZK28h6CNc6TIM7ZxZRmkx9j/VVJyPo8Cq03wzNPC2V81o6Jrgi4kxrTSO
 giLg==
X-Gm-Message-State: AA+aEWZkD7iaKYIhJqvyjXrOmTE+MhV7NmUzXEq6Wssp6i+VQV9JQQJP
 l2Fm9gH/HkIGN4BVE1umF2o=
X-Google-Smtp-Source: AFSGD/UIhtvqjU6BNrGF0/rqLaJcmiDSDN4ffyuRVXpnM7XbhS2pcD1MTsCxuFekt7tWfH9jmI+vxQ==
X-Received: by 2002:a19:cfc6:: with SMTP id f189mr9694002lfg.102.1543839666538; 
 Mon, 03 Dec 2018 04:21:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id y81-v6sm2482409lje.30.2018.12.03.04.21.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:21:05 -0800 (PST)
Date: Mon, 3 Dec 2018 14:20:53 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 5/9] clk: clk-hi655x: Free of_provider at remove
Message-ID: <cd8810afccfcc953d6cad308f820830d1afd2f36.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042119_207588_865D1559 
X-CRM114-Status: GOOD (  14.44  )
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
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..394d0109104d 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+				of_clk_hw_simple_get, &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
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
