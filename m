Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:06:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE609208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YMprE4aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE609208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DWcoM89PntFrCWERQ8CcuM+ihCgn1Or/Fyx7rcTEhe4=; b=YMprE4aqLteHoGlEFU40q9/eo
	p+5kBCp5CC0mH0XxEfDkDyEtioPTdvpFwyc7kOD/MLT3sxwlToXx2j6IQUZjeUN6ovdSzaVDYvUlY
	cYE4FtiFDH1LsOo+YMLJgO4X3E6QuGAw+ZXM8hBzegFdnb32ckVrZmZ5q/oS4eX+MhXd5pR+no3+k
	Zd5mJWP6bSgSoyLKTntuYpT9P2tWa+BHuUSdUxfYdk0xOrAX2ZljRiOfqTX05oHE29OKtUJKuaDGK
	/0dUoF8NoJS6rdLGhOYtyVN0GJeFnmYDwU5WGN4j/4AhgjtIbyuXC2/F9B4x/8yvUnuLniFHm5+9J
	HYp+Op3cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNpr-0004x0-KC; Wed, 20 Feb 2019 09:06:35 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNpn-0004w7-UC
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:06:34 +0000
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 0DAF2240016;
 Wed, 20 Feb 2019 09:06:17 +0000 (UTC)
Date: Wed, 20 Feb 2019 10:06:17 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
Message-ID: <20190220090617.aprfndnidcamwcvy@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66C6HFKgF8kERfp2UQ5XUyNS0-prgC3sX2iobkz7SjBcw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_010632_115109_0F01F453 
X-CRM114-Status: GOOD (  18.59  )
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
 devicetree <devicetree@vger.kernel.org>, Mans Rullgard <mans@mansr.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8089430017599951902=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8089430017599951902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="foh6urmif5xrrhfj"
Content-Disposition: inline


--foh6urmif5xrrhfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 04:58:49PM +0800, Chen-Yu Tsai wrote:
> On Sun, Feb 17, 2019 at 2:21 AM Mans Rullgard <mans@mansr.com> wrote:
> >
> > This adds pinctrl settings for various missing uart options.
> >
> > Signed-off-by: Mans Rullgard <mans@mansr.com>
> > ---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i=
-a20.dtsi
> > index af5b067a5f83..2295ff5adf48 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -944,6 +944,31 @@
> >                                 function =3D "uart0";
> >                         };
> >
> > +                       uart0_pf_pins: uart0-pf-pins {
> > +                               pins =3D "PF2", "PF4";
> > +                               function =3D "uart0";
> > +                       };
>=20
> We've had the policy of not adding pinctrl nodes that aren't used in-tree,
> to avoid bloating up the blob size. However DTC 1.4.7 introduced the new
> /omit-if-no-ref/ directive, which would make the compiler discard marked
> nodes if they aren't referenced.
>=20
> So please add this to all the new nodes. It seems to work regardless whet=
her
> you add it before or after the label, though having it after the label se=
ems
> to make vim syntax highlighting happier.

It also works (both for dtc and vim) if we put it on the previous
line, so something like:

/omit-if-no-ref/
uart0_pf_pins: uart0-pf-pins {
};

And it does have the advantage of keeping the same line width, which
could get pretty long on some nodes.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--foh6urmif5xrrhfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG0YiQAKCRDj7w1vZxhR
xXzVAP9ijrsG7dQ9ZkgmVB+wYx/3Y8mdnIpj0J1trQGPtzNyiQD/as1MQ3MQA2eo
/lMgL7JN23+8+YbQ3x8rN3XItEkscAw=
=rn9g
-----END PGP SIGNATURE-----

--foh6urmif5xrrhfj--


--===============8089430017599951902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8089430017599951902==--

