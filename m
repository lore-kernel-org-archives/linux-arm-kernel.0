Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:29:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DC12082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="scnSXwKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DC12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mn3vA4yQ+AsE2wvPqX+WH5iZvnEA2LPkD9znAr5ZyCg=; b=scnSXwKj4Z7X6hk+nrLr1o+/o
	rvse7+bIGDbOBjeQtdYZj05ziZSnxjPa8y8kXPrQzG940CoDz1GuLIyqzMxZovBNKxEXoHkpaYme8
	qWnctbDSVXrLUilk/XpZcxT/cV2b0S0CMdbUCszDeuig6EfC02ZdNY3zxwScvymMgGo+7YmvFg0Vt
	AjiTZUOfS082ipgO95E0E4PgtUqih/iWweIuYJoDs1SbYiXET7vEMAPFz4N3NkpGl3g1Z/LcBe/Tn
	xnOqw6rNkRNrmSoHMc41q4calClqvNlPoproLydXop2dKWlPc9rZIeFMpRav86p0+Uf5ZxWOWmtkr
	1/Yah7gSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU65T-0006yl-OJ; Tue, 04 Dec 2018 08:29:47 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU65P-0006xQ-L1
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:29:45 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B4332207BF; Tue,  4 Dec 2018 09:29:24 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8468B20723;
 Tue,  4 Dec 2018 09:29:14 +0100 (CET)
Date: Tue, 4 Dec 2018 09:29:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
Message-ID: <20181204082914.iyysctlftlgaffv3@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181105094341.qedt7jvnxooiojki@flea>
 <14295738.m69morCfDC@jernej-laptop>
MIME-Version: 1.0
In-Reply-To: <14295738.m69morCfDC@jernej-laptop>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_002943_818766_53BE6FE6 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
 sboyd@kernel.org, mturquette@baylibre.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 airlied@linux.ie, wens@csie.org, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4580209650357723266=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4580209650357723266==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nick2en3or4insev"
Content-Disposition: inline


--nick2en3or4insev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 07:09:50PM +0100, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisa=
l(a):
> > On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > > can be found on H6 SoC.
> > >=20
> > > Display Engine 3.0 in comparison to 2.0 mostly adds features needed f=
or
> > > displaying and processing 10-bit and AFBC formats, which are not yet
> > > supported by this series.
> > >=20
> > > H6 is also the first SoC which supports IOMMU, but support for it is
> > > not yet added.
> > >=20
> > > This series is based on linux-next at next-20181102.
> > >=20
> > > I suggest all patches go through allwinner tree, except DRM patches,
> > > which should go through drm-misc tree.
> >=20
> > Applied all patches up to the 26. The two last one however should not
> > use the clk bindings define you added in the first clk patches, since
> > clk and dt patches are going through different tree.
>=20
> I think you forgot to merge patch "drm/sun4i: Add compatible for H6 displ=
ay=20
> engine". At least it is not in linux-next.

Sorry, I just applied it. thanks!
Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nick2en3or4insev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAY62gAKCRDj7w1vZxhR
xccKAQDREKow//RUsju4juH/zjvD1TLHoS2siseRM84JC9rJNQEAx0PrxX1bzz1R
imBJVWh5FSLkywqxNMaZvX8zkPyE2wg=
=VwNa
-----END PGP SIGNATURE-----

--nick2en3or4insev--


--===============4580209650357723266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4580209650357723266==--

