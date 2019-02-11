Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7611C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EFC222A7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ynil+BSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EFC222A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dN40EFVTPzjzue655WmHNWuCHAgcm2jcPGBk6QjNwoU=; b=Ynil+BSOlMvxEuQqJcHYTjusA
	IwG4Tiz0qhG8707S9TfMiEBmWJ+h0g38sMtImZDKm6avZGp5lZWwbUVR03vmUKSa2l7UlegYFxydg
	fe6CkWE/xFM+YCU4lgjuP08m5l65N7/KzjBlGqI5VtoFpNKoPLUg9FMq/gm8J36b0xuXnLE+BEqs1
	A35at7M5n1lj+sTrXl53+yycLyCoMmWZZhPRF//QLpfk9/FyWdf2T7d1LT+ILmJMbg3SjPL010avZ
	UpXuS5sHyXcfOcN6FioYxhKlA3tjOG3GCaOg+gRXriph1e8Ijf7eO/Z31ekU6dKg4dmsyJcMHZllW
	Dr+BAhthQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDb0-00018w-J1; Mon, 11 Feb 2019 15:34:10 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDaw-00018F-Hb
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:34:08 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 973E11C0013;
 Mon, 11 Feb 2019 15:34:02 +0000 (UTC)
Date: Mon, 11 Feb 2019 16:34:02 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190211153402.s5qij5idvhbtsw2y@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
 <20190206155227.wbkzvsdgykir4wn5@flea>
 <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_073406_892546_E0A69FC7 
X-CRM114-Status: GOOD (  21.65  )
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
Content-Type: multipart/mixed; boundary="===============1276349127354792614=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1276349127354792614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wbna365u3tl67kxz"
Content-Disposition: inline


--wbna365u3tl67kxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 02:35:52PM +0000, Priit Laes wrote:
> On Wed, Feb 06, 2019 at 04:52:27PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > > > all of them, except the HRTIMER, expect the clock rate to stay
> > > > > the same and not change underneath them. And SATA expects it to
> > > > > be at 600 MHz, as the datasheet says. And while it may not direct=
ly
> > > > > apply to the LIME2, eMMC on newer SoCs / boards run at the slight=
ly
> > > > > reduced rate of 50 MHz just fine.
> > > > >=20
> > > > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > > > should be using the old code (now in the if conditional block),
> > > > > i.e. the behavior should not have changed.
> > > > >=20
> > > > > I don't think this actually "fixes" whatever bug was introduced,
> > > > > but only papers over the issue, and possible introduces further
> > > > > issues for other users.
> > > >=20
> > > > You're right, I've overlooked that it was pll-periph being
> > > > affected. I've dropped it for now.
> > >=20
> > > Any ideas what could be done. I currently have no time to debug it,
> > > but it affects existing systems.
> >=20
> > I can't find what would change with that commit either if the flag
> > isn't set, so looking at the register state before and after that
> > commit would help I guess?
>=20
> Register dump without the patch:
>=20
> $ busybox devmem 0x01c20090
> 0x0250030E
>=20
> pll-ddr-base     2 2 0   768000000          0     0  50000
>    pll-ddr-other 1 1 0   768000000          0     0  50000
>       mmc2       3 3 0    51200000          0     0  50000
>=20
> Register dump with patch applied, booted from mmc0 and after mounting emm=
c:
>=20
> $ busybox devmem 0x01c20090
> 0x8140020B
>=20
> pll-periph-base  3 3 0  1200000000          0     0  50000
>    pll-periph    6 6 0   600000000          0     0  50000
>       mmc2       3 3 0    50000000          0     0  50000

I meant the whole Clock controller, ideally a diff between the two
states would be great.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wbna365u3tl67kxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGGV6gAKCRDj7w1vZxhR
xSb0AQD60HG8McEgeqDKFTSbYkbsOD8CLdNxRxAkFYF53Ne4OAD+Ml7PXxYFoTB5
cofsj/UmY7nxosZX0nApMceCtLp4Kwg=
=ryVE
-----END PGP SIGNATURE-----

--wbna365u3tl67kxz--


--===============1276349127354792614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1276349127354792614==--

