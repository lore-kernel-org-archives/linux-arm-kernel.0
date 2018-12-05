Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46744C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131E42082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l0uMMlf6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhngEN08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131E42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P+5TxQd45//Mn8LjaWtH9Sdp58vvEwojvRZtrJFGnHg=; b=l0uMMlf6exiX6J
	jOvAjYRz2U8WwLmdP+9jd+wLcOT9Y3ELqfWU7nh7a0nX75SWFh8itNPZGxhHy1meKSxU/MEyWxovF
	ncz+tPAk2RA5Honjhk1WSRAefPJJGj+ThnttEwGvectrJE6r/wGv+7NxuqNYwD/R86HTQp9aLQ5ej
	4T09t1to8osSVowZGjw8QCN/uYrjwwJESxphKWa1/VZBg24WnFPwPto7NMndP/ybECQi+bepoxOD0
	3T1mQjPe7WuBVE35F3b5qPGpYgWLOS8Fefv8rBnsSXQdYnNP5rl8EzYs2PtW2bCeukH4iur0ri8bm
	s6L0d+4Z6bl4yvnRs25A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSPq-0006zc-6b; Wed, 05 Dec 2018 08:20:18 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSPn-0005uR-CU
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:20:16 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so14018172lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h8DpxLuWQKGUckIYRJD2osQB2nOM7UnAxPQlaFYioRQ=;
 b=GhngEN08B0EMWRLSfZi07M2eyKAkyuUlRfd3zfEOGzLgXq/+OpE5cW133Gbwb4VQxU
 OCOjX2ilEMpSluo+bKi3rUPH9YI1Z8UB9c83AwX89F545srzTuFDotzNmjMAommzcu8U
 7n/7WSMNdw186s5XwNV8SOD6uChJ8VtAAdAR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h8DpxLuWQKGUckIYRJD2osQB2nOM7UnAxPQlaFYioRQ=;
 b=SxFkpohT0VeHUJnqTOvAWUVT2JFb6D1fSUd4R4d4PxiX1ps1aRUyTn+FkamGnzSG/V
 gn79cjp3OSjWIJr20wHc5LbgFeL5rjboy8sgWTWeylI/5cLTMwX19Og3cySOagUKCRh8
 8RpwgKqcLmvWdHKtAbYIr065SL6Wt84PjZJzmk3asKyjFPGMC7fBy4Wl8mKzsZi/6T30
 NjX8qQvwWWJGWnGX2oDk4V/N1WpsIb8BbOb9BhTBOXkDsoQ4+8UMy/eN1lreXb8cVsTM
 dgqAW2GK/yOOTpqP58OCgU834X+adNYNcjMn4FLEDni1C33a4QnRtTzCVeo/Oi8emN0+
 4meg==
X-Gm-Message-State: AA+aEWYcAr2yum2z56QRT4oR6GkEu9dVR3Jlw6XiW4sD++68QzgK9liT
 hCMJk7zotwCcRs3JKbg6HonDt8vBmlCcBzPjHmHDCw==
X-Google-Smtp-Source: AFSGD/V1xjyH0JADyK/snQTG7/5bP5SmF0dvGehmoVjesECINVm9vji9+kIkqQmqDjhiVpAbewT4cuqyPYV1YN/jKsQ=
X-Received: by 2002:a19:c801:: with SMTP id y1mr13258383lff.53.1543998001801; 
 Wed, 05 Dec 2018 00:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
In-Reply-To: <20181205135726.70badac7@xhacker.debian>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Dec 2018 09:19:49 +0100
Message-ID: <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_002015_436800_EB4507BA 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 ext Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 7:02 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> Rob Herring <robh@kernel.org> wrote:

> >     'armada' : 'marvell',
> >     'berlin' : 'marvell',
>
> Now, berlin SoC is synaptics' SoC ;)

This illustrates perfectly the artificial nature of using vendor names
as prefixes with DT properties, prefix names, directories etc.

Companies start out purporting to be some eternal entity and the
next day they buy each other left and right and license their
hardware IP to whoever wants it.

It actually makes much more sense to organize these files by
the SoC family name, because that doesn't change when the
SoC is sold to another company.

omap/* containing all OMAP platforms, msm/* for all Qualcomm
SoCs etc. SoC names/codenames are at least eternal once they
have been manufactured and we can keep them together
no matter what vendor currently controls it.

However I think there was a fork in the road ages ago when
someone or something decided to use vendor prefixes for
DT properties leading to this situation that we can no longer
back out of.

It has the side effect of splitting DTS files with the same SoC
in two different folders marvell/* and synaptics/*
it's a bit meh.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
