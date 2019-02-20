Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E90EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:55:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507802183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OD3KWYlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507802183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DhzjF+FtAz7n9Y4BQn+JMNjUYH7o7/UNoOWgfK9GZcY=; b=OD3KWYlWVrBc//H4a1uAOfe4r
	MaaIJL/5kal58zZNhgg4oAyDXtzCs0dGFl7m7pPjjd11aJMVcckhCQdxJe42Xp85IyU6L1+lnMx4X
	lnVxQaPvnqq3pUZyv3YSzLbYmNEgASuTirU5E3CpZqO7B6fbBa1rkbshzylrkD1PdBbWHeaacKBfk
	1wl+GeQsnYOn4rr3XI3AjcD0xVY7p7V+sA4pYWcRbdDv3yl3gxbCnNezkA6RMGn4IgYIQ4YwP91Nl
	SkwBbb7op3hyOyL5WDFsR6QhjkZD9COkaRwpm3L/MGrQ73QMlM5J3A3qoQKu/B/ob3zviPevIHI1r
	/KPcfXy1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTHg-0003cA-B4; Wed, 20 Feb 2019 14:55:40 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTHc-0003bA-6L
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:55:38 +0000
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id D6BA5100011;
 Wed, 20 Feb 2019 14:55:31 +0000 (UTC)
Date: Wed, 20 Feb 2019 15:55:31 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: Allwinner SID THS calibration data cell representation?
Message-ID: <20190220145531.xu2t5gklnien7a3i@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_065536_380051_00D1942F 
X-CRM114-Status: GOOD (  18.32  )
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
 Emmanuel Vadot <manu@bidouilliste.com>,
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-iio@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Philipp Rossak <embed3d@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============1031341261809492301=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1031341261809492301==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pfmyvb5oulioawsq"
Content-Disposition: inline


--pfmyvb5oulioawsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 03:54:00PM +0800, Chen-Yu Tsai wrote:
> Sorry for resurrecting an old discussion, but since someone posted patches
> for H5 and H6, I thought we should resolve this. I'm working on patches to
> fix / replace the big-endian issue.
>=20
> On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> > > On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > > > +                 /* Data cells */
> > > > > +                 thermal_calibration: calib@234 {
> > > > > +                         reg =3D <0x234 0x8>;
> > > > > +                 };
> > > >   You are declaring 8 bytes of calibration data but to my knowledge=
 it's
> > > > only 2 bytes per sensor, so 2 bytes for H3.
> > > >   Am I missing something ?
> > > >
> > > >   Thanks,
> > >
> > > Emmanuel you are right, it is 2 bytes per Sensor and should be 2 byte=
s for
> > > H3, but the thermal calibration data field is on all chips 64 bit wid=
e - so
> > > 8 bytes. So I'm reading here the complete calibration data field.
> >
> > Having one cell per channel would make more sense I guess.
>=20
> Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 =
in
> the THS. As far as the SID is concerned, their is just one consumer for t=
his
> data, the thermal sensor. How the thermal sensor uses that data is really=
 not
> its concern. And the thermal sensor is really just copying the data from =
the
> e-fuses into its registers. Nothing more.
>=20
> Furthermore, with the register access interface, the e-fuses are read/wri=
te
> 32 bits at a time. Seems to me it would make more sense to enforce a 32-b=
it
> word size, so cells should be multiples of 32 bits.

I guess you convinced me :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pfmyvb5oulioawsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1qYwAKCRDj7w1vZxhR
xfquAQDelRqy0KSIwPv4oRKC2HvytiWLK3V5rOiAN3M29yfUdQD8CEnw/bd4nQ8r
EOdlVk5w/gtOyB8NmF9rMr4XR947xAU=
=G2bD
-----END PGP SIGNATURE-----

--pfmyvb5oulioawsq--


--===============1031341261809492301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1031341261809492301==--

