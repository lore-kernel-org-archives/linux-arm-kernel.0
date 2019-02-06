Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:20:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D75B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="htyLHY3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D75B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RK3z27PeAK+5s7hoCHew/yKRAqTUnKuO8W0080VNIsw=; b=htyLHY3w3pJfCk8Hjizj9uS/2
	AXKExiX2UZaSsBYksuTVP73IiDvglOnfvmKxqhiaammFLysWQYmaMSXGsdChuCWaNX1p3dbl0yAwo
	ETUDc63oTX9VIhPLSnQOMDLsJ7wH0nEw67Y3TWmYsUmp5B6rDZyDlm7huNZjh4H/HeWcA3ryN9/DL
	zw9QNSGrZvp0htAbixfrdW6uFzKDujnTOX2m4m2o73H/f7n2h9c38UHI3nslDJQ7eYLJ8b/epdJbo
	ZlwkwK8dEbvq/t1U7dAD8mgIZfor0oiNMasDJLQP7uJnnR6bu65YGdgLY9lnXJ/izJ3Uz6RjNkhMe
	Si8ArFTew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJNQ-0004nP-Du; Wed, 06 Feb 2019 09:20:16 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJNM-0004mx-IG
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:20:14 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BC586240075;
 Wed,  6 Feb 2019 09:20:00 +0000 (UTC)
Date: Wed, 6 Feb 2019 10:20:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190206092000.f46nsn4fw2n4crub@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_012012_912978_732B12B3 
X-CRM114-Status: GOOD (  20.46  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Priit Laes <plaes@plaes.org>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============7991006909886842069=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7991006909886842069==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sl7pkaf3p7ikf3a2"
Content-Disposition: inline


--sl7pkaf3p7ikf3a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:44:02PM +0800, Chen-Yu Tsai wrote:
> On Tue, Feb 5, 2019 at 5:45 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> > > Recent patch of improving MP clock rate calculations by taking
> > > into account whether adjusting parent rate is allowed, have
> > > unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> > > boards which fail with following error:
> > >
> > > [snip]
> > > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > > sunxi-mmc 1c11000.mmc: send stop command failed
> > > [/snip]
> > >
> > > Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> > > clock rate with following parents:
>=20
> You mean 52 and 51.2 MHz.
>=20
> > > [snip]
> > > pll-ddr-base        2  2        0   768000000 0     0  50000
> > >    pll-ddr-other    1  1        0   768000000 0     0  50000
> > >       mmc2          0  0        0    51200000 0     0  50000
> > > [/snip]
> > >
> > > Now, after the improvements, requested and settled rate are both
> > > 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> > > ends up like this:
> > > [snip]
> > > pll-periph-base     3  3        0  1200000000 0     0  50000
> > >    pll-periph       6  6        0   600000000 0     0  50000
> > >       mmc2          3  3        0    50000000 0     0  50000
> > > [/snip]
> > >
> > > With this patch (allowing mmc2 to set parent rate), we end up with
> > > working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> > > [snip]
> > > pll-periph-base     3  3        0   312000000 0     0  50000
> > >    mbus             1  1        0    78000000 0     0  50000
> > >    pll-periph-sata  1  1        0    26000000 0     0  50000
> > >       sata          1  1        0    26000000 0     0  50000
> > >    pll-periph       5  5        0   156000000 0     0  50000
> > >       mmc2          0  0        0    52000000 0     0  50000
> > >       mmc0          0  0        0    39000000 0     0  50000
> > > [/snip]
> > >
> > > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when=
 allowed")
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> >
> > Applied, thanks!
> > Maxime
>=20
> I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> all of them, except the HRTIMER, expect the clock rate to stay
> the same and not change underneath them. And SATA expects it to
> be at 600 MHz, as the datasheet says. And while it may not directly
> apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> reduced rate of 50 MHz just fine.
>=20
> In the commit in question, clocks without CLK_SET_RATE_PARENT
> should be using the old code (now in the if conditional block),
> i.e. the behavior should not have changed.
>=20
> I don't think this actually "fixes" whatever bug was introduced,
> but only papers over the issue, and possible introduces further
> issues for other users.

You're right, I've overlooked that it was pll-periph being
affected. I've dropped it for now.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sl7pkaf3p7ikf3a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFqmvwAKCRDj7w1vZxhR
xSw7AQDHxqxuEw37JOpF6w0RMseJfomBli6NRTUeA+PWrP5ymAD+KJFoB88BMXPP
9BMD/2yvAg8+f+AtitKtK8nYtlhzVgM=
=Hlbo
-----END PGP SIGNATURE-----

--sl7pkaf3p7ikf3a2--


--===============7991006909886842069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7991006909886842069==--

