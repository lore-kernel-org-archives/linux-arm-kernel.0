Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECB3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC1E21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Se6Pn7Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC1E21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sAQibtKrchG/0Uf1SmHYqR6AF1y/qWS7f9vr9Dd3Qf8=; b=Se6Pn7Km3uToDuXILc/3Gde4A
	bLBP+9s+dDh1Jz9Qi7gCHs4uIDB0GMOCZ2G2yyGiZaYI3DZnnYGrcRalWiDqfZvUsluULNkgFRp1o
	RuOcMokOnd2EbVOxHJ/zkZY604Q5X+qHxONa0JtwItXktYHtIQZ1fBiClTU9kBBKQc/OwndmUqfwN
	7ERyysIK+BV/ZSNL4zQIQ3IvwYFNh/Z20PpHIB3vGt0D1JBtFno4ZFL+bplhmcOmCuKPz5+WH2q2z
	TNI1uJ4xkQgrCMBHkJ/+13QwsVgv1v3FImHpM9Cy50duKSBqKSox7akZC3JLlQb8reXbVW30zSzuU
	wUVUSC/1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvg6g-0003U4-Je; Mon, 18 Feb 2019 10:25:02 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvg6b-0003Sz-Ib
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:24:59 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id A31F520001A;
 Mon, 18 Feb 2019 10:24:42 +0000 (UTC)
Date: Mon, 18 Feb 2019 11:24:42 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH RFC] arm64: dts: allwinner: a64: teres-i: Enable audio
Message-ID: <20190218102442.l3br2h3oqfe2atdv@flea>
References: <20190212083850.7genwc6ipnxtl7eo@flea>
 <E1gtUZn-0000NW-MA@stardust.g4.wien.funkfeuer.at>
 <20190212100929.iqsxu443qrkl6myf@flea>
 <E1gtds8-0000NB-Re@stardust.g4.wien.funkfeuer.at>
 <20190213094442.da2dy6d5bb527nft@flea>
 <E1gtsx9-0000RP-08@stardust.g4.wien.funkfeuer.at>
 <20190213155311.ovkpim3lxwyvuhhj@flea>
 <E1gu4dx-0000Sy-2B@stardust.g4.wien.funkfeuer.at>
 <20190215142029.GB32618@lst.de>
 <E1gv6rh-0000Km-U8@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
In-Reply-To: <E1gv6rh-0000Km-U8@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_022457_913754_423E6EF6 
X-CRM114-Status: GOOD (  21.89  )
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
 Rob Herring <robh+dt@kernel.org>, Torsten Duwe <duwe@lst.de>, ibu@radempa.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2050964039732922955=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2050964039732922955==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hokxk7gwa2n735je"
Content-Disposition: inline


--hokxk7gwa2n735je
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2019 at 09:47:13PM +0100, Harald Geyer wrote:
> Hi Torsten!
>=20
> Torsten Duwe writes:
>=20
> > > > > > > But we need a way to control the mux from userspace and aside=
 from
> > > > > > > unbinding the ideas proposed thus far are:
> > > > > > >
> > > > > > > a) control the gpio directly
> > > > > > > b) control the gpio via leds-gpio
> > > > > > >=20
> > > > > > > (a) was dismissed because we can't set a default from DT
> > > > > > > (b) was dismissed because some rogue app might try to blink it
> >=20
> > Hey, this is a debugging hack. If some rogue app tries to blink it, so =
be it.
> >=20
> > > I suspect some distributions will pick up the patch I posted anyway, =
if
> > > it doesn't get merged mainline. (This is how I forgot missing backlig=
ht
> > > support - it just worked for too many people ...) If we ship
> > > sun50i-a64-teres-i.dts with the proper nodes (but disabled), their
> > > patches will be much easier to maintain as the official DT evolves.
> >=20
> > As I wrote (held by the list admin), I consider the whole console mux
> > GPIO an U-Boot hack, and would put it into sun50i-a64-teres-i-u-boot.dt=
si.
> > (As a LED, see above :-)
>=20
> The thing is, one of the quite strict rules in kernel development is:
> Never break userspace. That means: If we provide a way to userspace to
> do something (ie switch between debug and audio), we are expected to
> keep it around forever. So since there is a decent chance that someday
> somebody might write a driver that handles this situation properly, we
> don't want chain ourselves to some dirty hack.
>=20
> (I'm not totally against writing such a driver myself, if there are
> enough use cases. However, I think that TERES alone is not enough.)
>=20
> > Would you care to submit a patch version without that GPIO handled?
> > I think it's very useful and has the potential to be agreed upon.
>=20
> That would enable audio from the internal speakers but select debug
> output on the HP jack by default. I would be okay with that, despite
> still thinking that audio on the head phones should be the default.
>=20
> Maxime and Wens are the maintainers, so it's their call in the end.

At this point, I'm not really convinced by the solution in that patch,
but I don't have really good ideas either. I think it would be good to
discuss this with Mark and Linus Walleij, they will probably have way
better solutions than what I can come up with.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hokxk7gwa2n735je
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGqH6gAKCRDj7w1vZxhR
xashAQDbjjYQHwqgbu1SqQX5qgkTWuLqt58lcPxbonZMhzMqJgEA5dOHZhZClyYd
ea3rdkxNgaOI5DJ3GAwd3ALzXhycTwE=
=n1ic
-----END PGP SIGNATURE-----

--hokxk7gwa2n735je--


--===============2050964039732922955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2050964039732922955==--

