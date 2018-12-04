Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3439C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:04:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NvMnlp7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=byT532EU75nsgGbuEBKWfaY/FrN68o/bYkfRFTmW844=; b=NvMnlp7AqbwNki
	0J8eR9PJRCrypEndJ+1UGez62xjC6Gp1wHuFT5L2cY9EEG1/H38HdFAIPSkE+sWO/pd0cKkMTD2OZ
	SCwXmrJPmE3AFSU21p5ZcNktI5UG7JgRwNZYNjQF3WptATFwjw7ZvPrSNUFhLU94i3SXt+wrnwLlA
	KAOZ96AWpMMih1yHXqTcyhLXvZ8pH2+fHJqN0bhnwykDKJ03tIr3JMb3Fx84Y5HZy4VgQnW5tQXfM
	8UJOzcnvSp7MmgZ2pAd7bHRMS6SGx4sMILKsMg1BtgEDfk6ggCG4SBRNVd8Oi0vpTKvKglwwBedyd
	sOKH0cfciwOLsas5khhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5gV-0004wL-HO; Tue, 04 Dec 2018 08:03:59 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5gP-0004uS-NR
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:03:57 +0000
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so13995533lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 00:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fgPj/u/cz0JV2Wgf14qUC+gVFxhWVypKSVSkLhduCpo=;
 b=b1AXMF8QYu9zJJxDcUIMomDehOWscH5O0W2JebCVmsJT6ZmrODAbL4E+wDuCaih7Ip
 L4l9Z+jzTv2+sWcBrxnbgWkCejdepgrDhHt3i7WIFWMQbl5hiSQ9FY5ogMrO+wWu2lHw
 C/bPlJaqbpjlq2mGscyUER7wgdObg2awuMVTiphFSioNLvdZJvM/+jeB4IAENEug7MeX
 AS5Mo+2ChXAnyTeRIJ5CP6iEAlZNVpA+7YXfCBxMRT16sNjQHsbzsKFzOKLTwP7mQfAs
 Rwaz8lEvO58qLJMEte6zyTzrsMARqDQEJRO84PEYR2mbpthbAr/w299ZcKf34u2vtJ0m
 qGwg==
X-Gm-Message-State: AA+aEWbyQaj3V0R77HTVWJvtF4IS3jqVAfZ96qU9XK8KhEtlkLN75nXx
 nWwdxu7W8NhPmVmuyP1c/0Q=
X-Google-Smtp-Source: AFSGD/XzR8al4PJv1hjBQ6E90ofwrr0mxzqNq5Rj8cjmq74JEG21KXDsbLsLtgg7X1mpy6ks0z5cRw==
X-Received: by 2002:a2e:9715:: with SMTP id
 r21-v6mr12121391lji.30.1543910621825; 
 Tue, 04 Dec 2018 00:03:41 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id c22sm2808778lfd.88.2018.12.04.00.03.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 00:03:41 -0800 (PST)
Date: Tue, 4 Dec 2018 10:03:38 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 1/9] clkdev: add managed clkdev lookup registration
Message-ID: <20181204080338.GB31204@localhost.localdomain>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203180612.GM30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180612.GM30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_000353_758339_A4A5F7B3 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, sboyd@kernel.org,
 mturquette@baylibre.com, mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, andrew.smirnov@gmail.com,
 sjhuang@iluvatar.ai, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Russell,

Thanks for the review. I do appreciate this. I'll send out v6 where I'll
have these fixed =)

On Mon, Dec 03, 2018 at 06:06:12PM +0000, Russell King - ARM Linux wrote:
> > +static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
> > +{
> > +	struct clk_lookup **l = res;
> > +
> > +	if (!l || !*l) {
> > +		WARN_ON(!l || !*l);
> 
> How can "l" be NULL here?  How can *l be NULL?

I really don't know if there is any "sane" way to end up having the
devres data NULLed. I admit I looked an example on how others had
implemented the match. These checks were present in devm_clk_match
and devm_regmap_irq_chip_match so I assumed there is a way to end up
having NULL there. Thus I played safe. OTOH it seems that for example
devm_hwmon_match does omit these checks and I really don't see right
away why the dr->data would be NULL. So I'll remove the check.

Br,
	Matti Vaittinen

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
