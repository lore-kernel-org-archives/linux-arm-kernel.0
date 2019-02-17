Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:30:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7B621B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NVrRPTbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7B621B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uGOZy6s4kN88AfvwE8EvV8p6Re7+KZEZSRJ+ZMgt5g8=; b=NVrRPTbst3ZZpe
	mw527O3u1CP19dOx3VErBAFUJ8WzmeHls+WHYAc93iGkNVXwUSR/cwdwdgn6q3wudJtfe+Mnda/eO
	2dOzxUSNXIEq1rIduyQTLK3Yz53nfhfKut4BeoszomLSB6Mbyq/byPm7EDHRbHyQg/pI+JFbM38Mx
	/vD3Wk5ZM7mUK+VUGKh9r2UbJv62cWeRbdO6mVYxGYj+/dxw01g9sthXTw0fJkQtKCBZd+HXHOHHe
	jaSRsFQXx+Xa3oJtFw0eFOnw2g+ZeLA2TqyEgp88d3NF16sCiE92PTOprRRgzrwotgTyMPYvJbhWM
	DV/zezS9i4F67efqfqeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvKeg-0005p8-Ql; Sun, 17 Feb 2019 11:30:42 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvKed-0005oc-34
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 11:30:41 +0000
Received: by newverein.lst.de (Postfix, from userid 107)
 id 5003E7F2BF; Sun, 17 Feb 2019 12:30:32 +0100 (CET)
Received: from blackhole.lan (p5B33F5E9.dip0.t-ipconnect.de [91.51.245.233])
 by newverein.lst.de (Postfix) with ESMTPSA id 751527F29F;
 Sun, 17 Feb 2019 12:30:27 +0100 (CET)
Date: Sun, 17 Feb 2019 12:30:05 +0100
From: Torsten Duwe <duwe@lst.de>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190217123005.6684abf9@blackhole.lan>
In-Reply-To: <E1gv6rh-0000Km-U8@stardust.g4.wien.funkfeuer.at>
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
 <E1gv6rh-0000Km-U8@stardust.g4.wien.funkfeuer.at>
Organization: LST e.V.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_033039_280772_9BD4FE34 
X-CRM114-Status: GOOD (  15.54  )
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

On Sat, 16 Feb 2019 21:47:13 +0100
Harald Geyer <harald@ccbib.org> wrote:
> Torsten Duwe writes:

> > I consider the whole console
> > mux GPIO an U-Boot hack, and would put it into
> > sun50i-a64-teres-i-u-boot.dtsi. (As a LED, see above :-)
> 
> The thing is, one of the quite strict rules in kernel development is:
> Never break userspace. That means: If we provide a way to userspace to
> do something (ie switch between debug and audio), we are expected to
> keep it around forever.

No, that rule applies to mechanisms, not configuration. It's not a
problem if a device disappears completely, especially when it's
optional. For clarity's sake, imagine to drop a .dtbo on the fdt that
disables or removes it, after U-Boot has set it.

> > Would you care to submit a patch version without that GPIO handled?
> > I think it's very useful and has the potential to be agreed upon.
> 
> That would enable audio from the internal speakers but select debug
> output on the HP jack by default.

The kernel driver will use whatever the boot preset is; and a
production U-Boot should set that to audio.

> I would be okay with that, despite
> still thinking that audio on the head phones should be the default.

Yes, for production use. For kernel debugging, hack it in U-Boot.
The audio driver should be the last to care.

Imagine you are debugging a boot problem on the serial console and all
of a sudden it stops working just because the audio driver kicks in!

Should any driver ever be in control of that GPIO, it must not be
audio, IMO.

	Torsten


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
