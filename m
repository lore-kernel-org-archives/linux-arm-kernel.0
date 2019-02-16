Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0068C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:47:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC43221B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xx2lJrOQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ccbib.org header.i=@ccbib.org header.b="CW1pw5Cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC43221B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Content-ID:MIME-Version
	:References:In-reply-to:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9RpdC6Ve3GioIJBhVy7wuJEebMUT6dk+sE97o3JKtg=; b=Xx2lJrOQ4CI7QZ
	6MOSkcwl8jX4Skv+JHX/iP+o6s0XNJZIbyMd2mvQl1iqiImiiIBW6nkpK9RodTRhwywKGln5z0L4K
	OkN81JaT8sHmz2oxUrY6PTvcBQZKbgd+fc2XT3UaxrqZW9OZgu7mro9qtPmQOMFmJ8nKOFa+5eu7e
	/JSkA+Igq5nV28gQyX3hu65xNlIOTw1yYbNDh7WGJYWIzHbxoxVNFnyxzbf45GSuuiefun19HNhM/
	xxcGxm7AsZ3S+LfHUeIDyN0GrJwDRSKxss5dtnwub+pc73XQUjrwU9hHI7vwuQs2/Whh7A4jUTC3O
	HggKmXGNj8kqvdo2Dj0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6rv-0007xv-BV; Sat, 16 Feb 2019 20:47:27 +0000
Received: from mail.cosmopool.net ([2a01:4f8:160:20c1::10:107])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6rr-0007xI-ED
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 20:47:25 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id 7BDCA90279A;
 Sat, 16 Feb 2019 21:47:20 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEB-AAMvpIlV; Sat, 16 Feb 2019 21:47:19 +0100 (CET)
Received: from stardust.g4.wien.funkfeuer.at (213162072206.public.t-mobile.at
 [213.162.72.206])
 by mail.cosmopool.net (Postfix) with ESMTPSA id EB2789004DD;
 Sat, 16 Feb 2019 21:47:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ccbib.org; s=201902;
 t=1550350039; bh=tdcDAXssQeeYxbIohrk0ql0KxzaOzlkt01D+A5OYnMQ=;
 h=From:To:cc:Subject:In-reply-to:References:Date:From;
 b=CW1pw5CfHJ/YSgAoU9bkSCOeG/vcD72rQVgc3Ri8CqDGxBfk9dLUbo88C0HbfYauc
 NWFmq9weSF03hKA2r5ggXK/HnPzFbS87cDlpcvOi3Qca/qlpuQlshoRqrgW1OiBg7F
 uTBPwIfXZ/sbjFDl6En7DA0auiEOJT99HBQ4Mo9M=
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
 (envelope-from <harald@ccbib.org>)
 id 1gv6rh-0000Km-U8; Sat, 16 Feb 2019 21:47:13 +0100
From: Harald Geyer <harald@ccbib.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
In-reply-to: <20190215142029.GB32618@lst.de>
References: <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
 <20190212100929.iqsxu443qrkl6myf@flea>
 <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
 <20190213094442.da2dy6d5bb527nft@flea>
 <E1gtsx9-0000RP-08@stardust.g4.wien.funkfeuer.at>
 <20190213155311.ovkpim3lxwyvuhhj@flea>
 <E1gu4dx-0000Sy-2B@stardust.g4.wien.funkfeuer.at>
 <20190215142029.GB32618@lst.de>
Comments: In-reply-to Torsten Duwe <duwe@lst.de>
 message dated "Fri, 15 Feb 2019 15:20:29 +0100."
MIME-Version: 1.0
Content-ID: <1286.1550350033.1@stardust.g4.wien.funkfeuer.at>
Date: Sat, 16 Feb 2019 21:47:13 +0100
Message-Id: <E1gv6rh-0000Km-U8@stardust.g4.wien.funkfeuer.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_124723_940461_6AB76B91 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 info@olimex.com, Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Torsten!

Torsten Duwe writes:

> > > > > > But we need a way to control the mux from userspace and aside from
> > > > > > unbinding the ideas proposed thus far are:
> > > > > >
> > > > > > a) control the gpio directly
> > > > > > b) control the gpio via leds-gpio
> > > > > > 
> > > > > > (a) was dismissed because we can't set a default from DT
> > > > > > (b) was dismissed because some rogue app might try to blink it
> 
> Hey, this is a debugging hack. If some rogue app tries to blink it, so be it.
> 
> > I suspect some distributions will pick up the patch I posted anyway, if
> > it doesn't get merged mainline. (This is how I forgot missing backlight
> > support - it just worked for too many people ...) If we ship
> > sun50i-a64-teres-i.dts with the proper nodes (but disabled), their
> > patches will be much easier to maintain as the official DT evolves.
> 
> As I wrote (held by the list admin), I consider the whole console mux
> GPIO an U-Boot hack, and would put it into sun50i-a64-teres-i-u-boot.dtsi.
> (As a LED, see above :-)

The thing is, one of the quite strict rules in kernel development is:
Never break userspace. That means: If we provide a way to userspace to
do something (ie switch between debug and audio), we are expected to
keep it around forever. So since there is a decent chance that someday
somebody might write a driver that handles this situation properly, we
don't want chain ourselves to some dirty hack.

(I'm not totally against writing such a driver myself, if there are
enough use cases. However, I think that TERES alone is not enough.)

> Would you care to submit a patch version without that GPIO handled?
> I think it's very useful and has the potential to be agreed upon.

That would enable audio from the internal speakers but select debug
output on the HP jack by default. I would be okay with that, despite
still thinking that audio on the head phones should be the default.

Maxime and Wens are the maintainers, so it's their call in the end.

HTE,
Harald

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
