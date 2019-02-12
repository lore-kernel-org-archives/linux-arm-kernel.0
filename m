Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C975DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928DA2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nvLajt58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928DA2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FR3AIYNXvc7N/0y7G9lYrrL49bXemvuH3xp7FXxB4h4=; b=nvLajt58+0yPjGSpQpwdHF1cJ
	4zPLwjT0BYBWWSNuVbFfnfDvWvDGI3BJw2le9zdFXiSLnnrHaYRFS5oB0TqI9oh+qG5E/hWTsNuNZ
	iSbkGTlaRVgd7qekJy7uYe22PbdjPkmAD3Dm2+1kMjZ8stuFLpkEE9JOCswbqWLxB7Uiv3pXpr8lm
	NZiUt7pTAu+3JBenUVcdI/gVkVJruz5gjbHrxOVX7t1UYmt1THmJFpzTydEv4b2E/pX1DrYH+aX4q
	1RXg4JkqfggWzZDrnCrFeJKDgvMwycEYgFiC1UnzjX0dDov+niEdlC6HaipvmHA3c2S4nccAQ48ac
	YrzcYyG1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtV0b-0003mW-OS; Tue, 12 Feb 2019 10:09:45 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtV0X-0003m0-6k
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:09:43 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D81D260015;
 Tue, 12 Feb 2019 10:09:29 +0000 (UTC)
Date: Tue, 12 Feb 2019 11:09:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190212100929.iqsxu443qrkl6myf@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
In-Reply-To: <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_020941_546149_35F610DB 
X-CRM114-Status: GOOD (  30.45  )
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
Content-Type: multipart/mixed; boundary="===============7882474693559003522=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7882474693559003522==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="klwiwpgyagqv7dfc"
Content-Disposition: inline


--klwiwpgyagqv7dfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 10:42:03AM +0100, Harald Geyer wrote:
> Maxime Ripard writes:
> > On Mon, Feb 11, 2019 at 08:32:35PM +0100, Harald Geyer wrote:
> > > > We want to model this properly. I guess using a pinctrl driver
> > > > controlled through GPIO (similar to what regulator-gpio is) would b=
e a
> > > > good first step.
> > >=20
> > > I considered this too, but didn't like it:
> > >=20
> > > 1) Seems like a bit of overkill.
> > >
> > > 2) The HW at hand is a rather different kind of multiplexer than
> > > what pinctrl assumes. We don't want two mutually exclusive devices,
> > > (Ie don't make the kernel unbind /dev/console for the sake of audio.)
> > > but we want switch the jack between two devices, that might both be
> > > active at the same time. This looks more like the channel multiplexers
> > > used with many ADCs and such. I guess, I could start a new subsystem
> > > around this. Seems like even more overkill.
> >=20
> > I'm not quite sure about how that's different from what pinctrl
> > assumes. pinctrl assumes to handle devices that have multiple signals
> > as input, and one as output. Isn't that exactly what you have?
>=20
> I think the pinctrl way would be to have the audio card device
> request the HP jack and the uart node request the HP jack and only
> once device could probe successfully. Ie it is about ressource
> allocation, not true multiplexing where both devices can use the
> ressource at the same time. Am I wrong?

By default, it's what happens yes, but you can definitely have more
complex behaviour that would support changing dynamically back and
forth that muxing.

> Or course we don't actually want true multiplexing for audio quality
> reasons, but I don't see how we could use pinctrl without doing nasty
> things to /dev/console ...

You can't have multiplexing, because that device doesn't allow you to:
it allows only a single signal out at a given time. If you're using
audio, you will not be able to get your logs out of the UART.

And /dev/console is always there as far as I'm aware.

> > And pinctrl can be used dynamically as well if you need to
>=20
> Can you explain or point me to the relevant explanation in the docs?
> I don't seem to know about it.

pinctrl_select_state is what you would want to call, you would have a
good example of that runtime change in
drivers/i2c/muxes/i2c-mux-pinctrl.c.

> > > Instead I just got the original patch working, by implementing
> > > "output-high" DT property in sunxi-pinctrl. I'll send a patch for
> > > review soon.
> >=20
> > What do you want to do with output-high exactly?
>=20
> Exactly what I do in the patch that started this thread.
> (I'll resend when wens' cpvdd patch is available for me to rebase onto.)

There's a few issues with that approach as well:

  - We're actively trying to remove the pinctrl nodes for the GPIOs

  - It's completely static: if one only wants to use the UART all the
    time, they would have to change the DTB, which might or might not
    be possible. Note that this could be trickier: why would you
    prevent the console from working for example if the audio support
    isn't built in? or as a module that might or might not be loaded?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--klwiwpgyagqv7dfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKbWQAKCRDj7w1vZxhR
xTIoAQDVB/ZfluKsNODvSEtdPz9xyCAf/Bbel0opVkWTEvc+7wD/f8gggAmApmZq
7FGTkqGgxpxk4bmMPBmuKL4EiVDDNQw=
=Y85k
-----END PGP SIGNATURE-----

--klwiwpgyagqv7dfc--


--===============7882474693559003522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7882474693559003522==--

