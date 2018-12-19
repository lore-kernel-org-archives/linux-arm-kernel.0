Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:25:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BE6218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkDagocL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BE6218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CZ8rp8X+Y8DgfWQI1HehZ4XwY+XgZqwG5pJYXZqam00=; b=HkDagocLrAeDZdzOqqvhtANi0
	r+ldivK24l+cGFvmT99cvpL8MN9+2FxLrVd7OP1kWh6zxkETb2SE/CmcV30VbfYZ6AwvSygDl3dT2
	wwiiOZxOMN/3j7e5JhWd9Ar33+3xJYRCUnYAKopCzRsMNdI+WIQOwPSMlZrxcxlq3hEOIDoY8xdQ1
	dFJ8zo8Mvo3S1eAkHuSGvuvwClLBQ5FP915p/Kw8hVQFv+f9w2IfN2PxWUkX3vL4SOWqrYzSzZSzo
	d71kawu6FDspIRIxFUiGS96/XakLC6i6qTcK4ihIBlATPYYrP/97kC3LMZPtWw2VQgzxmXWfc2GI6
	CVLQYbgGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZ2R-00015b-DG; Wed, 19 Dec 2018 10:25:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZ2O-0008H7-6c
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:25:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A390E206FF; Wed, 19 Dec 2018 11:25:00 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 72087206FF;
 Wed, 19 Dec 2018 11:24:50 +0100 (CET)
Date: Wed, 19 Dec 2018 11:24:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support
Message-ID: <20181219102450.picswsg3yevba23j@flea>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218152122.4zj6wgbukhrl6ly6@flea>
 <CAMty3ZA4xXVLKx-yj+2_iJ700+yTLesjEAgS8Wu2i8otPScpaw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZA4xXVLKx-yj+2_iJ700+yTLesjEAgS8Wu2i8otPScpaw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_022512_408269_9AB613DD 
X-CRM114-Status: GOOD (  16.23  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6610118453289805078=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6610118453289805078==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gprmpvsw3todifnc"
Content-Disposition: inline


--gprmpvsw3todifnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 08:58:22PM +0530, Jagan Teki wrote:
> On Tue, Dec 18, 2018 at 8:51 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Tue, Dec 18, 2018 at 05:03:14PM +0530, Jagan Teki wrote:
> > > This series support CSI on Allwinner A64.
> > >
> > > Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.
> > >
> > > Changes for v4:
> > > - update the compatible string order
> > > - add proper commit message
> > > - included BPI-M64 patch
> > > - skipped amarula-a64 patch
> > > Changes for v3:
> > > - update dt-bindings for A64
> > > - set mod clock via csi driver
> > > - remove assign clocks from dtsi
> > > - remove i2c-gpio opendrian
> > > - fix avdd and dovdd supplies
> > > - remove vcc-csi pin group supply
> > >
> > > Note: This series created on top of H3 changes [1]
> > >
> > > [1] https://patchwork.kernel.org/cover/10705905/
> >
> > You had memory corruption before, how was this fixed?
>=20
> Memory corruption observed with default 600MHz on 1080p. It worked
> fine on BPI-M64 (with 300MHz)

I don't get it. In the previous version of those patches, you were
mentionning you were still having this issue, even though you had the
clock running at 300MHz, and then you tried to convince us to merge
the patches nonetheless.

Why would you say that then if that issue was fixed?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gprmpvsw3todifnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBoccgAKCRDj7w1vZxhR
xYbqAQCxVTXkyDdcJa6zDRqgmBiXZ3Jc9evGSylu/TcV1AimPQEA1z9bxZBj1MFo
yYU1xgy8xsWMXjylYcsY0PzFdEE33ww=
=wmSB
-----END PGP SIGNATURE-----

--gprmpvsw3todifnc--


--===============6610118453289805078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6610118453289805078==--

