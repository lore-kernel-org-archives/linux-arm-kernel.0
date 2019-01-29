Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B5C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628142184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F2ynsHIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628142184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KZvJjAixdh9tZqFk/eEhGZVljdexo92eQ+H+3MBOg4k=; b=F2ynsHInr0rTFT/Zacljhrt+O
	4E5DGSjd7cMHWuCeY63cxrB6uW37uFbtVq3N/rIaEV3ML45ZJ6MmY58qju5hpW7ccuP2Ymi5Dtm5C
	pkfYmJvqK+zmqjr9SbDg3FJFOdJ8Jo8ny5Brn5qD4NndwZurOLPs3Fh9KUl0jwhly/wNk9SoIwND+
	i5PFUBMDQXgSrSmwKmzM7n6hDd7pbHjDwnLAM9bSLIgg16REhaXDyd13iy37Wn9ueGTfToBLdkV6U
	ddcDPPtj+Ekng4riX8KzV4kQJKG+P0AZnHZ7eNVH+TMSxINw2SQQ6r707J1cdmTglw+MZw0+sO7NN
	0XdSIqu6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV5i-0001KI-0I; Tue, 29 Jan 2019 15:14:22 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV5N-0000xz-9w
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:14:07 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C6AE6240007;
 Tue, 29 Jan 2019 15:13:48 +0000 (UTC)
Date: Tue, 29 Jan 2019 16:13:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Message-ID: <20190129151348.mh27btttsqcmeban@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com>
 <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071402_248722_A11F4FE8 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1275299848126930843=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1275299848126930843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sk46bbi4mwes7v4f"
Content-Disposition: inline


--sk46bbi4mwes7v4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > lowering the min rate by 300MHz can result proper working
> > > nkms divider with the help of desired dclock rate from
> > > panel driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> >
> > Going 200MHz below the minimum doesn't seem really reasonable. What
> > is the issue that you are trying to fix here?
> >
> > It looks like it's picking bad dividers, but if that's the case, this
> > isn't the proper fix.
>=20
> As I stated in earlier patches, the whole idea is pick the desired
> dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_rate
> is unable to get the proper dclk divider at the end, so it eventually
> picking up wrong divider value and fired vblank timeout.
>=20
> So, we come-up with optimal and working min_rate 300MHz in pll-mipi to
> get the desired clock something like below.
> [    2.415773] [drm] No driver support for vblank timestamp query.
> [    2.424116] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, rate=
 =3D 55000000
> [    2.424172] ideal =3D 220000000, rounded =3D 0
> [    2.424176] ideal =3D 275000000, rounded =3D 0
> [    2.424194] ccu_nkm_round_rate: rate =3D 330000000
> [    2.424197] ideal =3D 330000000, rounded =3D 330000000
> [    2.424201] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> [    2.424205] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, rate=
 =3D 55000000
> [    2.424209] ideal =3D 220000000, rounded =3D 0
> [    2.424213] ideal =3D 275000000, rounded =3D 0
> [    2.424230] ccu_nkm_round_rate: rate =3D 330000000
> [    2.424233] ideal =3D 330000000, rounded =3D 330000000
> [    2.424236] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> [    2.424253] ccu_nkm_round_rate: rate =3D 330000000
> [    2.424270] ccu_nkm_round_rate: rate =3D 330000000
> [    2.424278] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000000
> [    2.424281] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000000
> [    2.424306] ccu_nkm_set_rate: rate =3D 330000000, parent_rate =3D 2970=
00000
> [    2.424309] ccu_nkm_set_rate: _nkm.n =3D 5
> [    2.424311] ccu_nkm_set_rate: _nkm.k =3D 2
> [    2.424313] ccu_nkm_set_rate: _nkm.m =3D 9
> [    2.424661] sun4i_dclk_set_rate div 6
> [    2.424668] sun4i_dclk_recalc_rate: val =3D 6, rate =3D 55000000
>=20
> But look like this wouldn't valid for all other dclock rates, say BPI
> panel has 30MHz clock that would failed with this logic.
>=20
> On the other side Allwinner BSP calculating dclk divider based on the
> SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> calculated based on the bpp/lanes.

It looks like the A64 has the same divider of 4:
https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers=
/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12

I think you're confusing it with the ratio between the pixel clock and
the dotclock, called dsi_div:
https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers=
/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sk46bbi4mwes7v4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFBtrAAKCRDj7w1vZxhR
xco4AQCH9Bj/Fh4K6JpkMNURQ6aa/uNB8nz26vDwypm9CjTEqQD+PvQ8bv+3ZJvs
FtMPlAuAcTjEhlOwANjzj2GWxLedgws=
=MpfU
-----END PGP SIGNATURE-----

--sk46bbi4mwes7v4f--


--===============1275299848126930843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1275299848126930843==--

