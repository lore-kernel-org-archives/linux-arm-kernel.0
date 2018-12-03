Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:07:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E0220848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VyliWCPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E0220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/1TPSABkBlvdJv51hRt0wO/eYg0dsm+98VE9/J90L5U=; b=VyliWCPEZo+jpUrvDGZ1mQ0M5
	zjPSJ6JAJ86oiLJPM1K+TEGDcd1eLddDVwNipCEbTntVPGqLbr/8KITNBeI3wOgLhC0zC7bIhUa3L
	o76L9c6EVnnxxFwxOhpimPlPXA2HjMuN/axBZdvVorhZ8Ls7bIuFkWsOLYe7L3vEARhfYiOJDhEjT
	dalRawgnr8+E4C/Oqrv6d3DSY1479kTYMc10qKP/bsdf8xhf6AGBTF6Q4+Et1MC8CuvqbKL7CpR5D
	Z9qyXZikeeFSll2libFEdjnE/0ZqsolubAhSQ2mPh/Rbp4Vz/nC1MO78GPyLCEauBExv3vSnBu8/I
	DBMp+3toA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkBs-00063Q-Ln; Mon, 03 Dec 2018 09:06:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkBb-000629-U4
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:06:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3623220787; Mon,  3 Dec 2018 10:06:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id EEA002071D;
 Mon,  3 Dec 2018 10:06:17 +0100 (CET)
Date: Mon, 3 Dec 2018 10:06:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 04/15] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
Message-ID: <20181203090618.u4bi3owfpk2kcqik@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-5-wens@csie.org>
 <20181128103219.b625lttcgoluhgz5@flea>
 <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v67jPi-RFFkVrzHeh2XHeZV7ZN0tPCE=cOTpd6RQayH_Kg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_010640_314325_6C4D3892 
X-CRM114-Status: GOOD (  26.09  )
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
 Alessandro Zummo <a.zummo@towertech.it>, alexandre.belloni@bootlin.com,
 devicetree <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Mike Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi@googlegroups.com,
 Rob Herring <robh+dt@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rtc@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0476941539819645742=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0476941539819645742==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="krs5icnvo4odeegk"
Content-Disposition: inline


--krs5icnvo4odeegk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 07:18:26PM +0800, Chen-Yu Tsai wrote:
> On Wed, Nov 28, 2018 at 6:33 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Wed, Nov 28, 2018 at 05:30:01PM +0800, Chen-Yu Tsai wrote:
> > > Experiments showed that on at least the H3/H5/A64 the RTC's internal
> > > oscillator also feeds the CPUS mux in the PRCM.
> > >
> > > Export this clock through the device tree, instead of having to use
> > > a dummy fixed-clock device node, for the PRCM to consume. This will
> > > properly describe the relationship between the clocks.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Do=
cumentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > index 78c4fb472eb7..1bd37faadecb 100644
> > > --- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
> > > @@ -24,7 +24,7 @@ Required properties:
> > >
> > >  Required properties for new device trees
> > >  - clocks     : phandle to the 32kHz external oscillator
> > > -- clock-output-names : names of the two clock outputs. See below.
> > > +- clock-output-names : names of the three clock outputs. See below.
> > >  - #clock-cells  : must be equal to 1.
> > >
> > >  The RTC provides the following clocks at the given indices:
> > > @@ -32,6 +32,7 @@ The RTC provides the following clocks at the given =
indices:
> > >  - 1: LOSC external output, known as X32KFOUT in the datasheet.
> > >       This clock is not available on the A31 and is deprecated for old
> > >       device trees still using the "allwinner,sun6i-a31-rtc" compatib=
le.
> > > +- 2: InternalOSC, or internal RC oscillator
> >
> > It seems to be required only for a few RTC though (H3, H5 and R40?)
>=20
> IMO there's no harm in exporting it for all SoCs. I still don't know
> if it's needed for the A31 either. And we don't have documents for the
> PRCM stuff for any of the SoCs involved.

I'm still a bit worried about this, since that means that we can't
ever remove it from the DT interface, even though we find out it might
cause some issues in the future.

If we don't really have a need for it right now, I'd prefer not to
expose it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--krs5icnvo4odeegk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXATyCgAKCRDj7w1vZxhR
xTq/AP9WIRb7HtqNFrFkdfV6uGu037o83NPO7KzWey4u31t85QEAvW7U3/PGul6i
mu4yDZZYaKjr9keZ6pW1XNH0scK/MwY=
=nsv4
-----END PGP SIGNATURE-----

--krs5icnvo4odeegk--


--===============0476941539819645742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0476941539819645742==--

