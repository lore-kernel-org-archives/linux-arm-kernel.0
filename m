Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70947C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358BA20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NyMJgH79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358BA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Content-ID:MIME-Version
	:References:In-reply-to:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YMFEJhp5QQzKiVYKRNrTveNCj83xb8Y3VTdwyKYlaZQ=; b=NyMJgH79JfNgOW
	TYPjJjq0YnzX8r2FfdApd7PTrcdTv13VmE3WWdt29cloixwqyUGlGIHaRzjSNZck/Yi6gcnMTbAfP
	1YUihzU7nOSNirdw3W8oiRWRaSmrRLlbniJ31LeSDVnsJaDXVJtuj/I5NzcsYp2b+/Fh2pmRdezYs
	9W2/MHETCSCLZGofkrT9SzKm9u/xb8ReXfpNyhWS+DDnkchafZoOtAxGkqtBaoO+RypaQ3dAC9hBW
	vA3kjJaLRfet/5T2kdFDkcH8AWQ5UfAol8iv46VjZ+sp+TpLXmZr1hshkO/EyNLM7aq2DXlFrhzTM
	KcbM3xKj2I5hAvLvbWrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUa1-00027W-1u; Tue, 12 Feb 2019 09:42:17 +0000
Received: from h1.radempa.de ([176.9.142.194] helo=mail.cosmopool.net)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUZv-000214-2n
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:42:13 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.cosmopool.net (Postfix) with ESMTP id D9779902669;
 Tue, 12 Feb 2019 10:42:08 +0100 (CET)
Received: from mail.cosmopool.net ([127.0.0.1])
 by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YU14BxBnHfwO; Tue, 12 Feb 2019 10:42:08 +0100 (CET)
Received: from stardust.g4.wien.funkfeuer.at
 (178.112.134.42.wireless.dyn.drei.com [178.112.134.42])
 by mail.cosmopool.net (Postfix) with ESMTPSA id 0F772901323;
 Tue, 12 Feb 2019 10:42:07 +0100 (CET)
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
 (envelope-from <harald@ccbib.org>)
 id 1gtUZn-0000NW-MA; Tue, 12 Feb 2019 10:42:03 +0100
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
In-reply-to: <20190212083850.7genwc6ipnxtl7eo@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
Comments: In-reply-to Maxime Ripard <maxime.ripard@bootlin.com>
 message dated "Tue, 12 Feb 2019 09:38:50 +0100."
MIME-Version: 1.0
Content-ID: <1456.1549964523.1@stardust.g4.wien.funkfeuer.at>
Date: Tue, 12 Feb 2019 10:42:03 +0100
Message-Id: <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_014211_369020_24541141 
X-CRM114-Status: GOOD (  20.07  )
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
> On Mon, Feb 11, 2019 at 08:32:35PM +0100, Harald Geyer wrote:
> > > We want to model this properly. I guess using a pinctrl driver
> > > controlled through GPIO (similar to what regulator-gpio is) would be a
> > > good first step.
> > 
> > I considered this too, but didn't like it:
> > 
> > 1) Seems like a bit of overkill.
> >
> > 2) The HW at hand is a rather different kind of multiplexer than
> > what pinctrl assumes. We don't want two mutually exclusive devices,
> > (Ie don't make the kernel unbind /dev/console for the sake of audio.)
> > but we want switch the jack between two devices, that might both be
> > active at the same time. This looks more like the channel multiplexers
> > used with many ADCs and such. I guess, I could start a new subsystem
> > around this. Seems like even more overkill.
> 
> I'm not quite sure about how that's different from what pinctrl
> assumes. pinctrl assumes to handle devices that have multiple signals
> as input, and one as output. Isn't that exactly what you have?

I think the pinctrl way would be to have the audio card device
request the HP jack and the uart node request the HP jack and only
once device could probe successfully. Ie it is about ressource
allocation, not true multiplexing where both devices can use the
ressource at the same time. Am I wrong?

Or course we don't actually want true multiplexing for audio quality
reasons, but I don't see how we could use pinctrl without doing nasty
things to /dev/console ...
 
> And pinctrl can be used dynamically as well if you need to

Can you explain or point me to the relevant explanation in the docs?
I don't seem to know about it.

> > Instead I just got the original patch working, by implementing
> > "output-high" DT property in sunxi-pinctrl. I'll send a patch for
> > review soon.
> 
> What do you want to do with output-high exactly?

Exactly what I do in the patch that started this thread.
(I'll resend when wens' cpvdd patch is available for me to rebase onto.)

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
