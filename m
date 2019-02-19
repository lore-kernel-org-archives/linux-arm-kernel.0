Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D06C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C5421736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puzD4Ny3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C5421736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eAQVLgmJhJbYyc7+KuUt/mwt76glc+kD/vl1Lo+RfKQ=; b=puzD4Ny38Tt0ohBlKkWtcumn8
	kubp6RXrSc4+O11VFIbKwFIlJ7k6OzSQqgsLW1wYcYsq5VqqOSz5qPY4eps0r3yWItQhCrhKxYx1G
	ZxDnldS1CcigAglXFeWkaL3Wg5gBw7KPbZChJ8Vg8RsIkw0evEb9HZOo1w2w/Dc112vvRfGcn1qH3
	Bld3UtyR4q4fDsv8IRx0PhUksw8gPBHLFX9NMnmL/mp1QZuCDxtJ5yQJB00zyUBo2GRq9CZVoYbF6
	jnmaswIWik6+O872nHxWQlg5nD/RaBXVR2Csb4WmefKIq5+xHQwOGLrFhDqG27YZaUz08zZCrgcqj
	h9xYYSZgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6vf-0008AU-54; Tue, 19 Feb 2019 15:03:27 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6va-00089l-5h
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:03:25 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 81528FF811;
 Tue, 19 Feb 2019 15:03:12 +0000 (UTC)
Date: Tue, 19 Feb 2019 16:03:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
Message-ID: <20190219150311.yfqkr5svs6b3arjy@flea>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
 <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_070322_659555_7C1A2B2C 
X-CRM114-Status: GOOD (  24.18  )
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
 devicetree <devicetree@vger.kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============5678646953369122584=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5678646953369122584==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a5jbqqvrdaqbxyhn"
Content-Disposition: inline


--a5jbqqvrdaqbxyhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 18, 2019 at 05:19:40PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > > Add support for H5's SID controller.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > > index 570a2e354f30..036029e90921 100644
> > > --- a/drivers/nvmem/sunxi_sid.c
> > > +++ b/drivers/nvmem/sunxi_sid.c
> > > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cf=
g =3D {
> > >       .size =3D 0x100,
> > >  };
> > >
> > > +static const struct sunxi_sid_cfg sun50i_h5_cfg =3D {
> > > +     .value_offset =3D 0x200,
> > > +     .size =3D 0x100,
> > > +};
> >
> > IIRC, there was an endianness issue on the newer SoCs, with the driver
> > converting the data from big endian to little endian, while it's
> > actually stored little endian in the SID.
>=20
> About that, it seems the internals are either little endian or native (sa=
me
> as the bus). Either way the nvmem the driver currently exposes is wrong.

Do you mean that it can be configured either way, or it's little
endian and since you are running a little endian system you can't
tell?

> My idea is to keep the current one with the current name, but have it not
> associate itself with the DT node. We then register an extra one, called
> "sunxi-sid-native" which uses the native endian. This one will be associa=
ted
> with the DT node, so the THS driver can consume nvmem cells.
>=20
> What do you think?

I thought about this some more, and I don't think anyone really has
used the sysfs interface for it. Since the data are in an unusable
order (without an additional conversion at least), we would have had a
bug report by now (just like we had when someone tried to use it for
the thermal calibration).

So maybe the easy way out is just to disable the conversion on the
affected SoCs, and see if anyone complains?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--a5jbqqvrdaqbxyhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGwarwAKCRDj7w1vZxhR
xRlQAP9SuuNNe+uQxmVUomjF7GRR7ixRMF2zFKil/KKkT6MwzQD+LppkfKh/by7K
sUOXOlTBwGw8BGOtEByqkfFONxx9/wo=
=n1MX
-----END PGP SIGNATURE-----

--a5jbqqvrdaqbxyhn--


--===============5678646953369122584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5678646953369122584==--

