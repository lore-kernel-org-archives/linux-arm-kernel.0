Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65AC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:45:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C41E222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyXM7KvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C41E222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sgJ+cIvEJxq5CeeF9ygPfoawUyOKf7F7LZg/Hsg4DCk=; b=lyXM7KvLfdWf/YPocDK3cdpjb
	vgtrO2p4asusNm6HXL7En2UWzBSmFiXL3jUdZfHfSs6hACO3Wcf1NvW0dy69HU5pRuBIpoEotuyaV
	daIHAouvarMAFYihTzAvkm7BjPolXtY+3kW94RTbhCjSeeDzcgUrRLbZF4AXcq+knSf/E9zBCt/8E
	M/otjd55DuLjv090YymCQnYLwubdxDkgdrIAXTuQZ3zGWI+YcRXUMFlZlyfzfdJXxUm8cL1E/WT+v
	RNx7IBqyLJ/L8Rdl+8/IgLUTOEAIgH2WywFLxfLKdwGtzSFHFWHoYfWRoke36wZtCA6GOQy0mu/kK
	DI6Ju4PeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtr6E-0004w0-5N; Wed, 13 Feb 2019 09:45:02 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtr69-0004vW-F2
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:45:00 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2822DFF809;
 Wed, 13 Feb 2019 09:44:42 +0000 (UTC)
Date: Wed, 13 Feb 2019 10:44:42 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190213094442.da2dy6d5bb527nft@flea>
References: <20190211111245.GA18147@lst.de>
 <E1gtBlV-0000Wl-Cv@stardust.g4.wien.funkfeuer.at>
 <20190211153945.e34fpwkuk67l7lc6@flea>
 <E1gtHJj-0000iY-G8@stardust.g4.wien.funkfeuer.at>
 <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
 <20190212100929.iqsxu443qrkl6myf@flea>
 <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
In-Reply-To: <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_014457_801219_733DB15F 
X-CRM114-Status: GOOD (  40.55  )
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
Content-Type: multipart/mixed; boundary="===============8096033062538905620=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8096033062538905620==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5xaxtwbz6nm3a4l"
Content-Disposition: inline


--z5xaxtwbz6nm3a4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Tue, Feb 12, 2019 at 08:37:36PM +0100, Harald Geyer wrote:
> Maxime Ripard writes:
> > > > And pinctrl can be used dynamically as well if you need to
> > >
> > > Can you explain or point me to the relevant explanation in the docs? I
> > > don't seem to know about it.
> >=20
> > pinctrl_select_state is what you would want to call,
> > you would have a good example of that runtime change in
> > drivers/i2c/muxes/i2c-mux-pinctrl.c.
>=20
> I believe we have misunderstood each other somewhere. The above example
> seems to be about one device (mux driver) requesting a set of pins and th=
en
> switching between different pinconfig states thereby activating
> different subsets of pins.

Not quite, it's supposed to drive two set of pins (with different
muxings) connected to a single i2c controller. It's a 1-N relationship

> I don't see a way to have two devices request the same set of pins.
> I could write gpio-mux-pinctrl, but I don't see how this helps much
> either.

You can't at the same time. But precisely, pinctrl provides the
guarantee and the synchronisation needed for two devices to operate on
the same set of pins
>=20
> > > > > Instead I just got the original patch working, by implementing
> > > > > "output-high" DT property in sunxi-pinctrl. I'll send a patch for
> > > > > review soon.
> > > >
> > > > What do you want to do with output-high exactly?
> > >
> > > Exactly what I do in the patch that started this thread. (I'll resend
> > > when wens' cpvdd patch is available for me to rebase onto.)
> >=20
> > There's a few issues with that approach as well:
> >=20
> >   - We're actively trying to remove the pinctrl nodes for the GPIOs
>=20
> For what reason? Maybe it doesn't apply to this usecase?

This is kind of separate. At the moment, on all our SoCs but the H6,
requesting a pin to a separate state using pinctrl doesn't mark the
GPIO muxed on that pin as reserved, so through the GPIO userspace
interface (or calling gpio_request from within the kernel, but that
seems less of a risk) anyone is free to just request a GPIO on a pin
already requested, behind the consumer drivers' back. Which is pretty
bad.

There's support for such a check in pinctrl, and we did enable it for
the H6. However, one of its side effect is that you can't have a
pinctrl node for a GPIO anymore (at least without significantly
reworking the GPIO API in the kernel).

We did enable it for the H6, since it didn't have any backward
compatibility to take care of, but it's disabled at the moment for all
the other SoCs to be able to flip that switch at some point. And
that's why we're moving away from it as well.

> >   - It's completely static: if one only wants to use the UART all the
> >   time, they would have to change the DTB, which might or might not be
> >   possible. Note that this could be trickier: why would you prevent the
> >   console from working for example if the audio support isn't built in?
> >   or as a module that might or might not be loaded?
>=20
> No, it's not that static:
> * Before the audio device probes, UART is active. (You want UART all the
>   time: Just prevent the audio module from loading.)

If the bootloader configured it that way, if the audio support was
compiled as a module and not builtin, or if no-one fiddles with that
pin for whatever reason. 1 and (especially) 2 are pretty big ifs.=20

> * When you have used audio and suddenly want to have UART instead: Just
>   unbind the audio device and set the gpio to low or input from userspace.
>   (I intended unbinding to be sufficient, but it seems pinctrl doesn't
>    set the pin back to input when it is freed and I don't see a straight
>    forward way to force that. I guess it is okay however: Somebody
>    switching between UART and audio regularly has to know about the
>    details anyway.)

And this one is going to be a nightmare for distros to discover :/

> I also tested suspend/resume/poweroff and it mostly works. The only
> glitch is, that during suspend there is a short period of UART noise
> on the HP. (But no such problem during resume or poweroff.) I suspect
> the regulator supplying the gpio bank is shut down quite early when
> suspending. It doesn't matter for this discussion: There likely would
> be the same behaviour with any other approach too.
>=20
> I think the real downside of this approach is, that using the UART
> makes the internal speakers/mic unuseable too.

That's also a pretty big issue.

> But we need a way to control the mux from userspace and aside from
> unbinding the ideas proposed thus far are:
>
> a) control the gpio directly
> b) control the gpio via leds-gpio
>=20
> (a) was dismissed because we can't set a default from DT
> (b) was dismissed because some rogue app might try to blink it
>=20
> The clean solution might be to write mux-gpio, which is actually
> identical to leds-gpio but lives in /sys/class/mux_switches/ and
> uses different filenames. But that's going down the "invent a new
> subsystem road", which I believe is overkill for what is a debugging
> facility for a single board.

I still believe we should aim at supporting this through pinctrl, and
adding an userspace API is definitely easier than a full subsystem.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z5xaxtwbz6nm3a4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGPnCgAKCRDj7w1vZxhR
xRYVAP9aN5xv6piEdObz9wKlMqZ8DWwYC6JTFtm2zks6oHaQlQD8CZd80xxbTYBf
qCIGLU7fxc+n9jaOzQF6MRmuoNjpAgk=
=D9Us
-----END PGP SIGNATURE-----

--z5xaxtwbz6nm3a4l--


--===============8096033062538905620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8096033062538905620==--

