Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B1420837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CYjYDGV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B1420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gDGmWE5BcTzcUDPIJ4WepZcMR3hyw6wZoEj9ZfXSh9k=; b=CYjYDGV4AVeXPE
	fhIr8OBmccdoq+slbFm0cegLQwropQjD5J/Wbx+seIEU1dUfQ6PsInNzGx4VoP7ZcTSwiYkX74nLA
	z4gRJ/p+7Ug77sEIREKwIAjFXKXsCx/hJ21JXeVbM5Rw+/yqRuXl9tuZAcl0tawc0Gy5Syy9MLYYk
	TuOeA1GNc4OYAXVTXv6aa9pFJUoUnUIFv59zgzvb16wSNp74rLo45WHl86fQTMnO3+tdP0Abuki2d
	jiNghMAILvCageOKd26T8vec0iNitsqMqg+Vg4ckoKgwIawCvXa5VPyywETPkKjzukdd3YhJq6Xe+
	W3xNd1HE4y2l/xvDnDhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPf2-00035o-Gk; Fri, 07 Dec 2018 23:35:56 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPez-00033l-0q
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:35:54 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 0979F8116;
 Fri,  7 Dec 2018 23:35:41 +0000 (UTC)
Date: Fri, 7 Dec 2018 15:35:36 -0800
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181207233536.GW6707@atomide.com>
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
 <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
 <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
 <20181206140531.GX8952@piout.net>
 <CACRpkdbzyZD23JapAxEKc24jSwmZws5LqWS8O2Y4-VA3smgYyQ@mail.gmail.com>
 <CAL_JsqL7Rnb5Tt5ZAm9TDqgcenkkMEzM6STfwKXMDMKkkxqQvg@mail.gmail.com>
 <CACRpkdZ3X1BZtkjofftX2j4Z1FUdwGeU0swxLCyCQ844_h_-Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdZ3X1BZtkjofftX2j4Z1FUdwGeU0swxLCyCQ844_h_-Nw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153553_098265_88B11187 
X-CRM114-Status: GOOD (  12.91  )
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
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [181206 22:12]:
> On Thu, Dec 6, 2018 at 5:57 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Dec 6, 2018 at 8:30 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > > We discussed merging all ARM reference design mach-* to one dir
> > > if I just name that mach-arm then we get a convergence to the
> > > vendor name in some organic way.
> >
> > TBC, you want .../boot/dts/arm/* for all the ARM, Ltd boards? Just
> > making sure as you were arguing against vendor names. :)
> 
> I am not against vendor names, but I am also for SoC
> names because I think whatever makes most sense should
> be the rule, so both/and not either/or. One does not exclude
> the other. It's just a name.
> 
> In this case what
> I meant was that while we (me and Arnd) originally discussed
> merging it all into mach-versatile (how would you know)
> if I instead merge it all into mach-arm, we get a 1:1 correspondence
> between mach-dir and vendor name and DTS dir so everyone
> is happy.

With the number of trade names we've already seen with
the TI SoCs, I'd probably prefer arch/arm/boot/dts/ti.
What used to be omap is now dra7 and am437x and so on.

And for timing, doing this just before -rc1 gets tagged
seems like a good time to do it. At least I have still
pending large dts changes waiting that I'd rather not
send a pull request out for until next week :)

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
