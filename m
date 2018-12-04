Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EDC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458E32087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tu4XaZol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458E32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9dZ5jyX6cNArBHYQq6Pd5LZjNOiqbOZVibpaqjLTz7s=; b=Tu4XaZolzK9rkk
	s9WTZrOqIHpCJIU5pRw+wVi21hlWMSGIzOwrekVKKmKwoKEqkUYoOh8qmyU9GuDdFDBAeMaFiPKng
	yc1CElpaHqvHNp/ynf0HZXu1NwkoXA5oRvy+9T5c6Elo+g5SFPrXxkTkLUfCYo2liHbty+JgnE1+w
	yPzMoHPam/HavuZCOpOt2xKoF8ahlX0K3Fo9gdfuWhrFfwmF5K9wV9Ve89nH3xhTdDU756orA0DuU
	BWDFGfp0/dVwpFNRCLSPxoZaJQjZx5koW+wJLxJSdciSrp0gth5vkh4zsZ+hHXfPOnMIzOZ9AMZeU
	GS9UexuA3gIa6m0Y+SYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU91Y-0002mt-TB; Tue, 04 Dec 2018 11:37:56 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU91W-0002lL-1C
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:37:55 +0000
Received: by mail-lf1-f68.google.com with SMTP id p86so11688516lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GIzu5TM0Q0ij7JdKvBe/DIJ+uIu2SF/SLoojaqBlAkU=;
 b=BmR9QGS6lKKmLRR/99GR3eWN4Lg3X2E05YVKWEp/Vn6RwcsiSe+hQMX5joY0Bct9d6
 tD/q5AcBSBgywkqNOBvon30YlEzIh673w8uwObnuHXFmrHYWtSQVkMimRFIZfjG7pY4p
 tYVnUrWmZOUgxd/KqT67+Zlp3j/Fby6Mo0QVuSjvEXV51Bz7wqr3Uvksm0fYR/oFwmBa
 Hg0gBIfcrPNT7XgVqRZ6ODDvsOmSiLU8sbrhiZz7e4M4vMxVrfKJgeov9ripz9t+SGNq
 k+Nd6+AR9LltSVHEXpGpCRUJvKSefOAaFtVG+qkpVjko7b2oZ/qEBCnysom1o458g/iA
 md1g==
X-Gm-Message-State: AA+aEWZgPQ+qUlH7NP1zsGQo1Aj6jGTrHYIV60jW+A/fLnJI5o1n/Cy9
 LrEY2OtIFTEu/LoM6FNJQLE=
X-Google-Smtp-Source: AFSGD/VViV3CLRN5jn1QfIg3yeByA6Pca3qlmf7TgBZw3CGSaVwAwPUi2LOC5/ENoK1+9KOlr9U1dA==
X-Received: by 2002:a19:5402:: with SMTP id i2mr11152848lfb.128.1543923462510; 
 Tue, 04 Dec 2018 03:37:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id e94sm2935609lfi.23.2018.12.04.03.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:37:41 -0800 (PST)
Date: Tue, 4 Dec 2018 13:37:29 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 06/10] clk: clk-hi655x: Free of_provider at remove
Message-ID: <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033754_071402_52AD943C 
X-CRM114-Status: GOOD (  13.90  )
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
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..a0de3315df2e 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
