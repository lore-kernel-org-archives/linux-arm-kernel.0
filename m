Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403C72175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHqESZU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403C72175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ekAzrwlzzguQ+U+EHOFDoyW4qF0N3DNHkPlspFPxAJw=; b=SHqESZU1buMbc3FpZ0UirBmj4
	IFSd+ZJw7ajuYzriysPvYglSDWnmO1H1juWL3jSsM0oEYHolnmbp9wErjntzYYSeD1ThFYsD0DzG1
	wkWCvk5VDfe9rhd0tZ5CRIXGDKHMNbGE5bRMcPwv12lr4F7yqp6mlYyI5B6RlMi1hqM6epJhz+2SZ
	Thcre/JRsYm8RT1a4I2NZXXRYwbIT3H775+U4QWMbCd6UKFLmFbk6vQZNAM81exxJk8sedLTGYXJD
	aaqreUnwx1DBGNVCa1Qd6bY8jsDDVG9iGDUxnAAR3LH0zcc/nBw0J96yJr3DycJy7CuS+lpWjNWM4
	akmbYjdAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJJi-0002dt-9l; Wed, 06 Feb 2019 09:16:26 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJJf-0002dP-AH
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:16:25 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0479C1C0010;
 Wed,  6 Feb 2019 09:16:08 +0000 (UTC)
Date: Wed, 6 Feb 2019 10:16:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1%
 tolerance to dclk frequency check when bridge is connected
Message-ID: <20190206091608.yvws7iyjuhw3xsdk@flea>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
 <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
 <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
 <CA+E=qVd7yh=JNZSvrfY4Diu+VJWFK6yLUJ5MavBcZ8Cftn6f-Q@mail.gmail.com>
 <20190205154156.o3aa4cy6uxenkwol@flea>
 <CA+E=qVePKnQLwObfu=ya7-GcUiUkjyFg2p-rmg=FiJJUhQBvxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E=qVePKnQLwObfu=ya7-GcUiUkjyFg2p-rmg=FiJJUhQBvxw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_011623_503620_1289F6F5 
X-CRM114-Status: GOOD (  17.29  )
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
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 Chen-Yu Tsai <wens@csie.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============5793425596158131481=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5793425596158131481==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6mbqqqmv7k77dcll"
Content-Disposition: inline


--6mbqqqmv7k77dcll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 09:49:17AM -0800, Vasily Khoruzhick wrote:
> On Tue, Feb 5, 2019 at 7:42 AM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Mon, Feb 04, 2019 at 10:50:17AM -0800, Vasily Khoruzhick wrote:
> > > On Mon, Feb 4, 2019 at 8:29 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> > > > >> IIRC, from the previous discussion, HDMI had a tolerancy require=
ment
> > > > >> in the standard. Do you know if there's such a thing for eDP? Th=
at
> > > > >> would solve the issue for all the eDP displays at once.
> > > > >
> > > > >I don't have access to eDP standard - vesa.org says it's available=
 to
> > > > >members only.
> > > >
> > > > Try out to grab an old version?
> > > >
> > > > I remember 1.0 is open.
> > >
> > > I can't find anything regarding dot clock tolerance in DisplayPort
> > > specification.
> >
> > I guess since the DP is a VESA spec, it's probably .5%, just like on
> > the EDID (well, CVT).
>=20
> Unfortunately that's not enough for Pinebook. It needs 1% for 768p
> panel.

And that mode is stored in the EDID as a standard (or established)
timing, or a detailed timing?

If the latter, then it should also provide the tolerancies as part of
the panel timing description.

If the former, then what would be the advertised pixel clock and the
one we can compute? Maybe we have a bug somewhere.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6mbqqqmv7k77dcll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFql0gAKCRDj7w1vZxhR
xWGpAP9D/c/QkTM7RkEmYqX278PgTsD6DZQS9V3WGIvI9bLJXgEAm3+HDc3qJQPA
0HQwnjxRf6y79VXPkZBpd2H0cw1tdQY=
=vBLL
-----END PGP SIGNATURE-----

--6mbqqqmv7k77dcll--


--===============5793425596158131481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5793425596158131481==--

