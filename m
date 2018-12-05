Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB66CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6022084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwN+SqwB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMBqqgMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6022084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iLycxaaEF3HW1hMHlFZwUZxED9mcIcBbx87b44tbw70=; b=HwN+SqwB9lZ6BA
	eWGn1caV4+yIulIer7u6oQUuXjdNHGyCLOrcwfJ6GWVXhb8hN9OSQno8PM6ZtRtwYE2d1n4jkUiH1
	sBTBPb6JhIfc2jJ7+DmC8xNBGs7OniZewH+6onBIeyY9tux3Jp9xIH+LTa5bIShRbUXI4uas9GJu5
	o3EL4vVNQ4y3z6kRqeIi5AmcuKRf2TGHY+CD1g0+BtK3oEp4cD6DuQOZ9Wm+4i+bQUoCeXQvZBwRj
	0ImMF7BXFJq7xqT60Q6eZ/KMW+uoEgbAJumRy65nfB9Gys1d86IVqAgh8yM8dM4bdGEMMZ72cxpiN
	IMPqoXSjPh6Khda7URvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUR7T-0000XF-Tj; Wed, 05 Dec 2018 06:57:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUR7Q-0000W7-Sh
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 06:57:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 825DE2082B;
 Wed,  5 Dec 2018 06:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543993021;
 bh=MXVtmHQq94SWCQYLefz10K5B8VAwOS1nSQUhUkkghzQ=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=aMBqqgMo2okdua5jyGp1OTVc0xbZa9oZyVyyE1FOao0zQyDbbk0D0jN6XPTZ6dJMS
 O93LRhyYlNR1rSURs1ns6JnnZVC7VE1gnIBcIbD2R7QRzBTK1yMNiaIhIyp7oxG+7S
 gxmhCzGXmV2xCsZSsYKDEJPrXOa+ckQb8YjwKU1Y=
MIME-Version: 1.0
To: Masahiro Yamada <yamada.masahiro@socionext.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <CAK7LNAQEeLo=PW=DygyVxVHyn5jgRP18nb0cK+u1wGNd4BUh7Q@mail.gmail.com>
 <154394724886.88331.4940706362054124931@swboyd.mtv.corp.google.com>
 <CAK7LNARwq7Qc527L8P8_=taApi-UE3knHceKBUosi5Yx97+row@mail.gmail.com>
Message-ID: <154399302077.88331.14221169169421246205@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 04 Dec 2018 22:57:00 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_225712_959446_76309D6F 
X-CRM114-Status: GOOD (  23.70  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, sugaya.taichi@socionext.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Masahiro Yamada (2018-12-04 20:26:06)
> On Wed, Dec 5, 2018 at 3:14 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Masahiro Yamada (2018-12-04 03:03:53)
> > > Hi Stephen,
> > >
> > >
> > > On Fri, Nov 30, 2018 at 5:31 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> > > > > Add Milbeaut M10V clock ( including PLL ) control.
> > > >
> > > > Please give some more details here.
> > > >
> > > > >
> > > > > Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > > > > ---
> > > > >  drivers/clk/Makefile   |   1 +
> > > > >  drivers/clk/clk-m10v.c | 671 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >
> > > > And this is different from Uniphier? Maybe we need a socionext
> > > > directory under drivers/clk/.
> > >
> > >
> > >
> > > This is always a difficult question,
> > > and I do not have a strong opinion.
> > >
> > >
> > > I am fine with moving the files to drivers/clk/socionext
> > > although no file would be shared.
> > >
> > >
> > > FYI
> > >
> > > UniPhier and Milbeaut are completely different platforms
> > > developed/maintained by different teams.
> > >
> > > They happen to live in the same company now
> > > just because Socionext merged the LSI business from Panasonic and Fujitsu.
> > >
> > > UniPhier originates in Panasonic, while Milbeaut in Fujitsu.
> > >
> >
> > Thanks for the background info. I'd prefer to defer to however the dts
> > files are getting split up into directories. If they're all put under
> > arch/arm64/boot/dts/socionext/ then I would say combine the two clk
> > drivers into a socionext directory. Otherwise, keep them split out.
> 
> 
> If you want to align with the DT directory structure,
> the answer is clear.
> 
> 
> Milbeaut DT files will be put together with UniPhier ones
> into socionext directory.
> 
> 
> For arm64, DT directories are already sorted out by vendors.
> 
> Even 32-bit ARM is going to that way.
> 
> Rob Herring just posted a python script
> to move all DT files in arch/arm/boot/dts/
> into vendor subdirectories.
> 
> 
> Please let me know if you want me to
> move drivers/clk/uniphier/* to drivers/clk/socionext/*.
> 

Maybe the dts needs to be split up instead? Looks like the gpio drivers
are in a uniphier directory and there is some precedence to keep the
"taken over" company name when vendors are merged into other vendors.
Maybe that's how things have happened here? It would be nice to be
consistent, but I leave the decision up to you to figure out if that
really matters to you. I'll be fine either way.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
