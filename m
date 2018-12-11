Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E129C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:51:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E35820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bF1bAhbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h5iV7QFjKgEiPnscMQ3DA0cZd627M/5DulMqOZhh3Ok=; b=bF1bAhbUNcd+o2GtwbuGd8uIt
	UsxworzvKIDTG9wRdHQZ5Ur4rktXgPa7m8dSsT22buqHhYXtQZnBgbB2OpQL4j/9bcRtfDZvoYT0r
	4DDLNMYXqoKwHb/0n0mFrbxVQ2K56gWkdzBSDaIcKwoBpCtLAhwsRAVCeNkWTn/QfU+LYtb30b7BV
	3KXwk+gg5SaaioyFDU4gYmWmM7VwBZSxGMTBr3PiXffvs1xrs4HkicXKYvC+eu7WEKKbgDUNBbjoP
	EK8maeSxXyPYk6NnreEwk2mI8MSELVUzTltXnhjBADsqigj4zU40c394pLnfYsqTz4MN7b/S+iGun
	vliZkVRzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlFT-0000na-Hl; Tue, 11 Dec 2018 16:51:07 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlFP-0000OM-DZ
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:51:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E47D520C4D; Tue, 11 Dec 2018 17:50:51 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9F43520743;
 Tue, 11 Dec 2018 17:50:41 +0100 (CET)
Date: Tue, 11 Dec 2018 17:50:41 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@openedev.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 15/17] clk: sunxi-ng: a64: Add
 minimum rate for PLL_MIPI
Message-ID: <20181211165041.u75t6li6ympzq3mk@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-16-jagan@amarulasolutions.com>
 <20181211163222.hk647c24cjhmwrz4@flea>
 <14061728-2ca3-3342-2cf3-b8588b112f5f@openedev.com>
MIME-Version: 1.0
In-Reply-To: <14061728-2ca3-3342-2cf3-b8588b112f5f@openedev.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_085103_772941_311CF692 
X-CRM114-Status: GOOD (  19.04  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8711876899678558759=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8711876899678558759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2q3wpw76o4wgyupz"
Content-Disposition: inline


--2q3wpw76o4wgyupz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:05:43PM +0530, Jagan Teki wrote:
>=20
>=20
> On 11/12/18 10:02 PM, Maxime Ripard wrote:
> > On Mon, Dec 10, 2018 at 09:47:27PM +0530, Jagan Teki wrote:
> > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > lowering the min rate by 300MHz can result proper working
> > > nkms divider with the help of desired dclock rate from
> > > panel driver.
> > >=20
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> > >   drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunx=
i-ng/ccu-sun50i-a64.c
> > > index 181b599dc163..b623c8150b4f 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> > > @@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk =3D {
> > >   	.n		=3D _SUNXI_CCU_MULT(8, 4),
> > >   	.k		=3D _SUNXI_CCU_MULT_MIN(4, 2, 2),
> > >   	.m		=3D _SUNXI_CCU_DIV(0, 4),
> > > +	.min_rate	=3D 300000000,		/* Actual rate is 500MHz */
> >=20
> > That comment still doesn't make any sense. Is it running at 500MHz or 3=
00?
>=20
> It running in 300MHz, actual rate is 500MHz.

If it's running at 300MHz, its actual rate should be 300MHz...

> > Also, IIRC you had a patch adding support for maximum boundaries in
> > your previous patch, where did it go?
>=20
> Since I don't have any usecase to test I droped it. the same mentioned on
> the previous version.

Ok.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2q3wpw76o4wgyupz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/q4QAKCRDj7w1vZxhR
xc5xAP9NU7qTH3t2fXk0kZMIpaxASJhZYZ3t/1G38gffs4UA3wEAxd0/syHxubbV
aMACGKcluqKixGfJ/gp1y2UrEdppjQg=
=teNi
-----END PGP SIGNATURE-----

--2q3wpw76o4wgyupz--


--===============8711876899678558759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8711876899678558759==--

