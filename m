Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8303DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:52:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407F92175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9Smeox6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407F92175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K5pZC+NINgyeDw1Vcw7OdfG2k6S2N2a3pQu1yrdV43Q=; b=k9Smeox6BP+KWrGb0xOsR7IqV
	JPjsDu3NrLNWiWpfDsasANz1GMTf0E3G4Gf9gJnP65Ys07Puuirh5WhhIVETYwOuBWDe91qox8c4c
	zu2+Ng/hjA3sbvK5q0JEttpyUcOeq5KBoCNfYGc429wkxF0bBgne71IXbt1g3LxZmkykRGtpwdRGV
	1mpnd8YTOYB71Swub+jrXzaLSGc19YtL21swJvCpq/Ol288TC/6CqSqBPVoqmbbBgQ7Od2hxW+j3n
	vpjLtf5AM5+nI5cDw37kRaSGehC/5pL9/MYge3BHQF+Qk6WOi5L7DeIhl3eUEORhz59g1QGfYdT+a
	iR/GRUwdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grPVC-0001pX-45; Wed, 06 Feb 2019 15:52:42 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grPV7-0001om-Vi
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:52:40 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2CD3B60015;
 Wed,  6 Feb 2019 15:52:27 +0000 (UTC)
Date: Wed, 6 Feb 2019 16:52:27 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190206155227.wbkzvsdgykir4wn5@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_075238_172424_959D8459 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5148186560037103263=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5148186560037103263==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="icccueyyr555murp"
Content-Disposition: inline


--icccueyyr555murp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > all of them, except the HRTIMER, expect the clock rate to stay
> > > the same and not change underneath them. And SATA expects it to
> > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > reduced rate of 50 MHz just fine.
> > >=20
> > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > should be using the old code (now in the if conditional block),
> > > i.e. the behavior should not have changed.
> > >=20
> > > I don't think this actually "fixes" whatever bug was introduced,
> > > but only papers over the issue, and possible introduces further
> > > issues for other users.
> >=20
> > You're right, I've overlooked that it was pll-periph being
> > affected. I've dropped it for now.
>=20
> Any ideas what could be done. I currently have no time to debug it,
> but it affects existing systems.

I can't find what would change with that commit either if the flag
isn't set, so looking at the register state before and after that
commit would help I guess?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--icccueyyr555murp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFsCuwAKCRDj7w1vZxhR
xTU9AP9g4pbqlt+rpU7LjBo60zkNQyzMukc4S5jIrMWrBFyqpQEAj90+Ygl1XNH0
ouci5HXy93X8iohAAztclWA59L2xzA0=
=1KMn
-----END PGP SIGNATURE-----

--icccueyyr555murp--


--===============5148186560037103263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5148186560037103263==--

