Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B34C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1D22084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r00CdDoQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljnEHri/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1D22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TFhI5IQj0vN2qC3r5rtrMEa64IZwxwvyGgYS1pb8a30=; b=r00CdDoQYTv3uJ
	mNpCdQgo6pwcdsBqmJp/Q1QwpsnT/YcTli1FkiAhcwtznSNh21dUCTAW9ioVEGgCzlDcd5PEGL9kX
	aKg3J9rIlWMYJsTS99z3aZomenA/Icck6RurafIAS/wIpOWEkaRtNwSHO2qfP7K2eCw5+88LdKzUY
	dRSWvraVhKvcHL3et+hl12h95QrTgDGyr6pPyheGaYpxeghxZ8HyxnQD4cu4u9zOXu90oh2KVoN0s
	hUCzJy5igLH3GuMsLQFw4wEU+812vnri/kV7Vvxc3M6N4MTJ6zFBwzjU0yOWOgKttg9PWZlTzG09x
	gFoMPmwsXWL7plEoCyWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYh1-0006iX-FL; Wed, 05 Dec 2018 15:02:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYgy-0006hy-92
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:02:25 +0000
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5E3E32151B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544022133;
 bh=o8doxBcd+u5ifweWyhxcvnO0Sd/qkGrQgxpUD5SI1IY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ljnEHri/N0Q0g28n3yIhkQJ7zcYrAYVaI8At5rkl8ahfUFpdrNnjOTyt6VOxVV4Mj
 AaOwDxrFWc5wzFU2CZYVPFjpMDiKMqV2Pwduy4qYhFiSSVQ3yxGBPEDpwtGq7iJYI1
 H/UFdfCdgE2wgFZ7+/3Xgc7M1VX/AQxJTpHZvMCQ=
Received: by mail-qt1-f177.google.com with SMTP id v11so22560511qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:02:13 -0800 (PST)
X-Gm-Message-State: AA+aEWaTTLOgOtg14fVi9v6DjkW3iYjIsNlpMxeTEHjC20Yic5TWHxf0
 o+Lhf24GhPWlqqeEklj9f7xs590sZ378ot7HNQ==
X-Google-Smtp-Source: AFSGD/WZ1fEYBhO9SGNC1Xq743hx1wBuocOno0sP5VWI+Bku6vjRKp13E98L8PhKZkqfjq1ExUrPIveTWtq43e9+m/E=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr23178088qtd.257.1544022132402; 
 Wed, 05 Dec 2018 07:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
In-Reply-To: <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 09:01:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
Message-ID: <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_070224_360417_7945535C 
X-CRM114-Status: GOOD (  18.59  )
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
 Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 2:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Dec 5, 2018 at 7:02 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> > Rob Herring <robh@kernel.org> wrote:
>
> > >     'armada' : 'marvell',
> > >     'berlin' : 'marvell',
> >
> > Now, berlin SoC is synaptics' SoC ;)

But we're not changing the names of existing SoCs and at least so far
there aren't new 32-bit berlin SoCs.

> This illustrates perfectly the artificial nature of using vendor names
> as prefixes with DT properties, prefix names, directories etc.
>
> Companies start out purporting to be some eternal entity and the
> next day they buy each other left and right and license their
> hardware IP to whoever wants it.
>
> It actually makes much more sense to organize these files by
> the SoC family name, because that doesn't change when the
> SoC is sold to another company.

Uh, no. i.MX23 is a Sigmatel chip STMP?? which shared absolutely
nothing with other i.MX chips except for the derivatives that
followed. IIRC, STMP chips were even partially upstream.

Marketing names change at the whim of marketing and don't even require
a sale of a company.

> omap/* containing all OMAP platforms, msm/* for all Qualcomm
> SoCs etc. SoC names/codenames are at least eternal once they
> have been manufactured and we can keep them together
> no matter what vendor currently controls it.

Where do TI amXXXX chips go? Not all QC chips are 'msm' and I think
that name is abandoned now. No solution is going to be perfect.

We are already use vendors for arm64 (except for the oddball exynos),
so if we change arm, we shouldn't do something different. EBBR is also
going with vendor for firmware directories in the EFI system
partition. Speak up if you want to change that before 1.0.

> However I think there was a fork in the road ages ago when
> someone or something decided to use vendor prefixes for
> DT properties leading to this situation that we can no longer
> back out of.

It was simpler times...

> It has the side effect of splitting DTS files with the same SoC
> in two different folders marvell/* and synaptics/*
> it's a bit meh.

All I really care about here is things are organized by maintainers.
Someone care to write a script to ensure all 1800 files have a
maintainer attached to them (that is not me)?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
