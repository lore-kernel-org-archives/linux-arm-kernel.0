Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7620DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C98C217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MCO4vNBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C98C217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w0fCFk7+6iK39kpzSi5+QBvfj1wUZKW1EhqVsYfwt74=; b=MCO4vNBQFkgTkb
	+Kqobo3F4/GzDMoUW1UQqJamHys5Y0M4IV9bXaWN7U5KLJU5MuDS98JwLkCO+mrJmAYmtTr2IfJrD
	nMkzF0jlxON3Di64RcigagqJEoxkmRf+CJH0WBYhozwP3BiEM9KiQUmqMRZvPiMHUlxPT8emRgLyz
	59fZex3f3NfuOekYsVW+rXeEwX3azwEuL/03UFialeJiP6uUaOx0ybSqDaflLrVZx5VSPHrdWj/A0
	QcuDXM3WzqE3bOjgHSLrlo2wgWCxgff7gJ0dNydB4p99B6Fwd9VAjq/SSIdM3fGINmpWJIy9AT3s5
	j5jcdl22VuhSR+Fv1RRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyPkB-00020W-4U; Mon, 25 Feb 2019 23:33:07 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyPk7-000202-P2
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:33:05 +0000
Received: by mail-ot1-f66.google.com with SMTP id z19so9540139otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mhas2O7WqxcWkIgrao2rHLIS8cG0frp/MOnMjnOJTzA=;
 b=p4fKPtgdhdjP2MnQsVlE4IRWIRyoSnmIerM50JEw36a7tHk7NOREl/EHJUsahTDeZ4
 Vc5Zr/veoWfKJsURVoQNGBd24fN0CACEyRu5zjmF1s4Xix1uV1Y56OgabIDHvsJmStGM
 LcIcbAQbrSKdn063DTUIlc0/4VSPc+rBtPIxg+gCB5bO1kMIDZ9Zz4eXB+2HByorB+XP
 w9Nd6KOVZEBxPncAu6d7hdiqyJ/TAhNzBVnOj2mVpdGsBqfiBOiWGGk+LQugmFD7Eq/3
 bQmpdo97ANj7decKvZquX1dF8NHdcS4DbB0OOJipBxyY/xC3yniEEcKCxpKjrHTw+2SS
 yZKw==
X-Gm-Message-State: AHQUAuaeh+/7yIAHV7Lt+RJ13lqekEkDlcrxlMAFPj3H0+JdEPfTYHPH
 VO2Ghb5WhEI7gIfxSS9Zhg==
X-Google-Smtp-Source: AHgI3IaVF7mDjxMWRMY30ll1EnVc0aPiNkILCLnvf1UGJWihq5Eu+CZ+Wj1P+T0PHRVxuLvZ2iAHRQ==
X-Received: by 2002:a9d:6755:: with SMTP id w21mr12737548otm.87.1551137582792; 
 Mon, 25 Feb 2019 15:33:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d18sm4519450oth.9.2019.02.25.15.33.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 15:33:02 -0800 (PST)
Date: Mon, 25 Feb 2019 17:33:01 -0600
From: Rob Herring <robh@kernel.org>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: spi: Add Support for Allwinner F1C100s
Message-ID: <20190225233301.GA25780@bogus>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_153303_807914_4CEB8466 
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
Cc: devicetree@vger.kernel.org, Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019 12:21:10 +0300, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar SPI controllers as sun8i H3.
> Add compatible string for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sun6i.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
