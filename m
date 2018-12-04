Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EEDC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC732081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mz1rDTDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC732081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X07PqNJbScpS5ZJDIj7sV4fSuLB2eIBM+86NaAJrQ+o=; b=mz1rDTDuO05c5kkOPCSE6Eikq
	zjzd7sO0Tr+GOL3m9mh8TtbxiqHVKVfZeIddXbLkxezPlGbyYK17ETISOWLAu/H45yH6AvENOMa2j
	VInjTbyI/HKaJ+JbFXibq0U79MUKuF1PTsPx0kuwHYSDq/s3aytJHO75q20ujdXES4bhWfTauIEZt
	4zMplzhk2FrSefhtwKegTCupHurUvjqVR9Z9r9SxQ5/41Q+6Co5n2VjiwHMyUAdpVcnqOL+NQEZ34
	hakXeP8mN7TEGumBNWE1bxpkUbtfuzQU6uzUB8HFckq7/YmGLCQnbJvy6OasS1MRwUmohAlsb+aLm
	WiaD+JENQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCwi-0006Ry-RW; Tue, 04 Dec 2018 15:49:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCwf-0006H2-Ba
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:49:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 03ABA2074D; Tue,  4 Dec 2018 16:48:58 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id B12D420736;
 Tue,  4 Dec 2018 16:48:47 +0100 (CET)
Date: Tue, 4 Dec 2018 16:48:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 4/9] phy: dphy: Add configuration helpers
Message-ID: <20181204154847.f2cclpxa6a7v2ffx@flea>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4d44460c4ecbd47f4cbd9141c6bf2632b6c21e1e.1541516029.git-series.maxime.ripard@bootlin.com>
 <20181119134357.743nskpkqqfkrjux@valkosipuli.retiisi.org.uk>
 <20181121093353.p3gnj4ebel4h4ya4@flea>
 <01829f2e-871e-cdea-afab-0ae1360464a4@ti.com>
MIME-Version: 1.0
In-Reply-To: <01829f2e-871e-cdea-afab-0ae1360464a4@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_074909_674984_2577C2E1 
X-CRM114-Status: GOOD (  21.85  )
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
Cc: Archit Taneja <architt@codeaurora.org>,
 Krzysztof Witos <kwitos@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sakari Ailus <sakari.ailus@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0979136024404541145=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0979136024404541145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oliesnrm3ovw6vm"
Content-Disposition: inline


--5oliesnrm3ovw6vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 11:28:37AM +0530, Kishon Vijay Abraham I wrote:
> Hi Maxime,
>=20
> On 21/11/18 3:03 PM, Maxime Ripard wrote:
> > Hi Sakari,
> >=20
> > Thanks for your review.
> >=20
> > On Mon, Nov 19, 2018 at 03:43:57PM +0200, Sakari Ailus wrote:
> >>> +/*
> >>> + * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
> >>> + * from the valid ranges specified in Section 6.9, Table 14, Page 41
> >>> + * of the D-PHY specification (v2.1).
> >>
> >> I assume these values are compliant with the earlier spec releases.
> >=20
> > I have access to the versions 1.2 and 2.1 of the spec and as far as I
> > can tell, they match here. I can't really say for other releases, but
> > I wouldn't expect any changes (and it can always be adjusted later on
> > if needed).
> >=20
> >>> + */
> >>> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> >>
> >> How about using the bus frequency instead of the pixel clock? Chances =
are
> >> that the caller already has that information, instead of calculating it
> >> here?
> >=20
> > I went for the pixel clock since it's something that all drivers will
> > have access too without any computation. The bus frequency can be
> > available as well in v4l2, but won't be in DRM, and that would require
> > for all drivers to duplicate that computation, which doesn't seem like
> > a good choice.
> >=20
> >>> +				     unsigned int bpp,
> >>> +				     unsigned int lanes,
> >>> +				     struct phy_configure_opts_mipi_dphy *cfg)
> >>> +{
> >>> +	unsigned long hs_clk_rate;
> >>> +	unsigned long ui;
> >>> +
> >>> +	if (!cfg)
> >>> +		return -EINVAL;
> >>> +
> >>> +	hs_clk_rate =3D pixel_clock * bpp / lanes;
> >>> +	ui =3D DIV_ROUND_UP(NSEC_PER_SEC, hs_clk_rate);
> >>
> >> Nanoseconds may not be precise enough for practical computations on th=
ese
> >> values. At 1 GHz, this ends up being precisely 1. At least Intel hardw=
are
> >> has some more precision, I presume others do, too. How about using
> >> picoseconds instead?
> >=20
> > Sounds like a good idea.
>=20
> Would you be fixing this? Or this can be a later patch?

I have fixed this locally, but I wanted to wait a bit for more
feedback. I can send a new version if you prefer.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5oliesnrm3ovw6vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAah3wAKCRDj7w1vZxhR
xQ0DAQCq/Z7HwPgo9Em4i2reOkIJK2X0mOhO3ckssP8Qk+5gIwD/QWh2B62EiAp7
UcfddZ+Zj6+oKYSH+/U77jyhEjqyQA4=
=H7cv
-----END PGP SIGNATURE-----

--5oliesnrm3ovw6vm--


--===============0979136024404541145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0979136024404541145==--

