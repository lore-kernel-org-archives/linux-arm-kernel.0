Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C972082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQtCrcto";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qkhwh+vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C972082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZgVDr9Q0xFoIfmSKlfGff0LotVcMGlO+yeFYX5QQts=; b=gQtCrctooIP59d
	GPXufGXxYv50GcfUdoEafGMEV1wH54+ZCo2igZjZSUdi7Xcx15wIvvYOLjKPW7lHqBfDDP0RwNc2E
	NfIXXacN6j2/QrPBOJrxnsrgtRbyb7T40iF8gRiHMUPdzXdmIkoyzxruznk2tRWsZOD9MCFRAFVO1
	fxB26HxDYQZAWuvIFcxUM5NTHDkgHx6o41+C8wVNh0XCZb4TbHxkpEOJD1vsfF1kJzmpRnfr34CfB
	KhB723l6IS2s/PwBQudEpTXCRd9Slwpf6gbLPUKn4IkJq5jmcKgdwiu7mw4HrduLKWJxFSwfGV1Ue
	gVoyPvIsPzdYLe3jKFtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1uO-0000on-T9; Thu, 06 Dec 2018 22:14:12 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1sq-0007WY-4Y
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:12:51 +0000
Received: by mail-lf1-x12e.google.com with SMTP id i26so1583572lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 14:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DAxIOQ+UCc/rx5Xj+Qqnz/zHtW5HptCT4y+X6FCh0kk=;
 b=Qkhwh+vUi9VaebPZZSbd0XyqtFMR6kSmOw/Rdd3F6NgXVIXlBJB/a1pWpmLlsh4N8t
 ycc7X+/xRMYM7TtgZkTmdYfINtlhoY9j4Akfv1s8Iq5dYXbL8QQvDNiqKxbzlGzrByFK
 hU7tnarQCKUzpXF5mcXDo30ZkgC4EhLFYsR5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DAxIOQ+UCc/rx5Xj+Qqnz/zHtW5HptCT4y+X6FCh0kk=;
 b=LpQM6cMT+KhqiRRWyQDADrytMVlOb+5bONMdaKiYWfyE9OGdSQ4sYIGF5UpGBrLTtO
 Cgf6wgDOWmn37W1rQW4IyzzyBkgZlNlW9yLa+Fxg5oyoXX1QcjXbW0IoFlmnxxbWO9Dj
 F7uTAOh+jel6IuDfEm+GA8NZhjzIEK8tZzJQvfBD2B6sUc7Nldk1OOOsl5c90cflhAPC
 FfPraJf/vgL/St7uDQWb6iDdQWFBAoaXyeslqHll76hfEIkoVWWeVogmRd9b+kGfoD9z
 lwNFyLV4UU0gi/F4JXdlkeMaDzEajlF7WaRQkm7fOGe4SFQNKYe9kn4t8YS8A2FxTIEe
 fBLw==
X-Gm-Message-State: AA+aEWbNK0qqBdt5Y2W8mTazX1z6P5kVOpKv8ean/YZ+R4g9+LrdpPg/
 p14uw4B/7SiEkU2Y28TVDdC9SKG4RjqKDTawsYnL6A==
X-Google-Smtp-Source: AFSGD/UbWksaj5NwmEYw7EPLBPX4SwYpEaNCp5pKDlPzbhIGBttZO71DDNMpuoNlO4DB1prnXr4ne+GXfWl0GtonghM=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17407409lfa.62.1544134343533; 
 Thu, 06 Dec 2018 14:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
 <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
 <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
 <20181206140531.GX8952@piout.net>
 <CACRpkdbzyZD23JapAxEKc24jSwmZws5LqWS8O2Y4-VA3smgYyQ@mail.gmail.com>
 <CAL_JsqL7Rnb5Tt5ZAm9TDqgcenkkMEzM6STfwKXMDMKkkxqQvg@mail.gmail.com>
In-Reply-To: <CAL_JsqL7Rnb5Tt5ZAm9TDqgcenkkMEzM6STfwKXMDMKkkxqQvg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 23:12:11 +0100
Message-ID: <CACRpkdZ3X1BZtkjofftX2j4Z1FUdwGeU0swxLCyCQ844_h_-Nw@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141236_835815_D1D40603 
X-CRM114-Status: GOOD (  11.07  )
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
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Dec 6, 2018 at 8:30 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > We discussed merging all ARM reference design mach-* to one dir
> > if I just name that mach-arm then we get a convergence to the
> > vendor name in some organic way.
>
> TBC, you want .../boot/dts/arm/* for all the ARM, Ltd boards? Just
> making sure as you were arguing against vendor names. :)

I am not against vendor names, but I am also for SoC
names because I think whatever makes most sense should
be the rule, so both/and not either/or. One does not exclude
the other. It's just a name.

In this case what
I meant was that while we (me and Arnd) originally discussed
merging it all into mach-versatile (how would you know)
if I instead merge it all into mach-arm, we get a 1:1 correspondence
between mach-dir and vendor name and DTS dir so everyone
is happy.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
