Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E3BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7E52186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HHSSJdsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7E52186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Content-ID:MIME-Version
	:References:In-reply-to:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jGYXKYUDvaneHzQ6iNiDGbqiCEAU8bpGoIzI9qUODKw=; b=HHSSJdsl3RSj4x
	KNyPomOWmtQZ+cM2QNXXajYPteFC/k7xHKq2IbS4bNowdF11hThcmxWGetv2YIRoJnWZ4W4GbGYjl
	9HdSmaAG0wJ1T+FyijSbTVmdhMXfJqkfQX7eQMTE/0mlxpEaiVCDNi0IKl5gR/t0rFOIL73+GanHy
	5rp7JAaDIMxacp37kOo2TG9EmCdmQ+Jp1VRgcUlFzCBJZwXPAemyT9Nj3vcVqCc4hPQIPRNj47xqF
	qKMxcRRh55xL5BBAMhdv17TMxGE8ZCAoF//U4Fuuxw1GbVDbV14IroFRKsKdlMSu07G8v+6lmqcY/
	YKP6h4ioSnJKgZjWFPtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHKC-0007ES-KC; Mon, 11 Feb 2019 19:33:04 +0000
Received: from mail.cosmopool.net ([2a01:4f8:160:20c1::10:107])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHJq-0006w4-2M
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 19:33:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id 4C586902667;
 Mon, 11 Feb 2019 20:32:40 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWp4cddhpg9B; Mon, 11 Feb 2019 20:32:39 +0100 (CET)
Received: from stardust.g4.wien.funkfeuer.at
 (178.113.214.5.wireless.dyn.drei.com [178.113.214.5])
 by mail.cosmopool.net (Postfix) with ESMTPSA id DC33A900B0F;
 Mon, 11 Feb 2019 20:32:38 +0100 (CET)
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
 (envelope-from <harald@ccbib.org>)
 id 1gtHJj-0000iY-G8; Mon, 11 Feb 2019 20:32:35 +0100
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
In-reply-to: <20190211153945.e34fpwkuk67l7lc6@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
 message dated "Mon, 11 Feb 2019 16:39:45 +0100."
MIME-Version: 1.0
Content-ID: <2760.1549913555.1@stardust.g4.wien.funkfeuer.at>
Date: Mon, 11 Feb 2019 20:32:35 +0100
Message-Id: <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_113242_757794_8632FF9C 
X-CRM114-Status: GOOD (  21.88  )
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
 info@olimex.com, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Maxime Ripard writes:
> On Mon, Feb 11, 2019 at 02:36:53PM +0100, Harald Geyer wrote:
> > > > debug console multiplexing:
> > > > Olimex have a userspace script that controls gpio PL9 during boot,
> > > > to select between HP and serial console. I guess this is not acceptable
> > > > for mainline.
> > > >
> > > > The best solution I can see is to switch the HP jack from serial console
> > > > to audio once the audio drivers load. With this people can still capture
> > > > the bootlogs but everybody gets audio once the system is up and
> > > > switching back to console output is as simple as unloading the audio
> > > > drivers.
> > >
> > > IMO it is really not the audio driver's business to mess with this switch.
> > > You could argue as well that the serial driver should get a flag to claim
> > > the HP jack, which would be similarily unjustified.
> >
> > Not the audio driver's business, but perheps the audio card's DT node.
> > Which is why I came up with the pinctrl idea.
> > 
> > I know that the nexus7 is quite well supported, and iirc they were using
> > a similar trick on their UART. Have you looked at how they were doing
> > that?

I didn't know that. Thanks for the info, it was quite interessting reading.
Alas it seems it doesn't help us:
1) I couldn't find proof that audio support is actually in mainline.
2) Their HW works differently: Their debug cable uses external voltage
on the mic pin to drive the switch. (They also have a GPIO, but it's
input to detect the debug adapter in software, not output as in the
case of the teres.)
 
> We want to model this properly. I guess using a pinctrl driver
> controlled through GPIO (similar to what regulator-gpio is) would be a
> good first step.

I considered this too, but didn't like it:

1) Seems like a bit of overkill.

2) The HW at hand is a rather different kind of multiplexer than
what pinctrl assumes. We don't want two mutually exclusive devices,
(Ie don't make the kernel unbind /dev/console for the sake of audio.)
but we want switch the jack between two devices, that might both be
active at the same time. This looks more like the channel multiplexers
used with many ADCs and such. I guess, I could start a new subsystem
around this. Seems like even more overkill.

Instead I just got the original patch working, by implementing
"output-high" DT property in sunxi-pinctrl. I'll send a patch for
review soon.

Harald

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
