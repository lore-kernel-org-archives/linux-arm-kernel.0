Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8195C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727E220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EPc1q0OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727E220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b/rUulWLq1ENrkxVWLiaIJYcyVxCx0MAz3hsXyeLMA8=; b=EPc1q0OT2OwHWSKyi4O233me/
	rSmbj1ZJgbz3ET1pFVnz995XneP+V9ZSWXtowyIh/Ov+Ye7dcqZEQ+FrlI30AjrLtMuXfR9c5k/FT
	bxqPk+RMdmfDl3E7cSyLxSB/s9nTr5Ui/h3BfcewxrODkdSuPOfBzPWFpd+BiydQF4u6XFtbOZPpZ
	bQhV/eOe+/NK7vxVEqCH/g44+TZk1mDL+fsRZL7rF+DOweGS6CvNxaVQzzUsVAqVnDKej7Ngsm2WT
	oIOhS5VHjKICogwwAxKYSGd8BO/GKvN+5PzjMvG6WPYGtG6au2b+MjrLEiiDKWWak90r+TwcYP8Tn
	bloCLzQWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVArK-0006io-8v; Fri, 07 Dec 2018 07:47:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVArG-0006hp-Mt
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 07:47:36 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7DADA2073D; Fri,  7 Dec 2018 08:47:23 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 41D9520701;
 Fri,  7 Dec 2018 08:47:23 +0100 (CET)
Date: Fri, 7 Dec 2018 08:47:23 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
Message-ID: <20181207074723.l3ykhqojfkd4y4ie@flea>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
 <20181206153445.kqu2pep5orktr6yv@flea>
 <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOf5uwk_k-Y8ZZFbtjUup5U27wN_E+fvqEDs5m3csnzdneN1KQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_234735_020610_88A564B0 
X-CRM114-Status: GOOD (  22.76  )
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
 devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============7442878578710773025=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7442878578710773025==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q57fppkqpm6lotdb"
Content-Disposition: inline


--q57fppkqpm6lotdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:07:59PM +0100, Michael Nazzareno Trimarchi wrote:
> On Thu, Dec 6, 2018 at 4:34 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> > On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> > > Allwinner A64 CSI controller has similar features as like in
> > > H3, So add support for A64 via H3 fallback.
> > >
> > > Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> > > the default clock 600MHz seems unable to drive the sensor(ov5640)
> > > to capture the image.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v2:
> > > - Use CSI_SCLK to 300MHz
> > >
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++=
++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm=
64/boot/dts/allwinner/sun50i-a64.dtsi
> > > index 384c417cb7a2..d7ab0006ebce 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > @@ -532,6 +532,12 @@
> > >                       interrupt-controller;
> > >                       #interrupt-cells =3D <3>;
> > >
> > > +                     csi_pins: csi-pins {
> > > +                             pins =3D "PE0", "PE2", "PE3", "PE4", "P=
E5", "PE6",
> > > +                                    "PE7", "PE8", "PE9", "PE10", "PE=
11";
> > > +                             function =3D "csi0";
> > > +                     };
> > > +
> > >                       i2c0_pins: i2c0_pins {
> > >                               pins =3D "PH0", "PH1";
> > >                               function =3D "i2c0";
> > > @@ -899,6 +905,23 @@
> > >                       status =3D "disabled";
> > >               };
> > >
> > > +             csi: csi@1cb0000 {
> > > +                     compatible =3D "allwinner,sun50i-a64-csi",
> > > +                                  "allwinner,sun8i-h3-csi";
> > > +                     reg =3D <0x01cb0000 0x1000>;
> > > +                     interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > +                     clocks =3D <&ccu CLK_BUS_CSI>,
> > > +                              <&ccu CLK_CSI_SCLK>,
> > > +                              <&ccu CLK_DRAM_CSI>;
> > > +                     clock-names =3D "bus", "mod", "ram";
> > > +                     resets =3D <&ccu RST_BUS_CSI>;
> > > +                     pinctrl-names =3D "default";
> > > +                     pinctrl-0 =3D <&csi_pins>;
> > > +                     assigned-clocks =3D <&ccu CLK_CSI_SCLK>;
> > > +                     assigned-clock-rates =3D <300000000>;
> >
> > That should be enforced in the driver.
> >
>=20
> We are not really sure what is the best here. Our first idea was to
> put in the board file and then Jagan
> decide to put in dtsi. We don't have enough coverage of camera on this
> CPU and I prefer to stay with this
> minimal change that does not impact the driver.

The thing is that:
  - in this commit log, you're stating that it depends on the sensor,
    which indicates that this would be a board level addition
  - In another patch series, Jagan reported IIRC that it actually
    depends on the resolution, so it doesn't belong in the DT at all
  - And then, you don't even have any guarantee on the clock rate. The
    sole guarantee you have is that when your driver will probe, the
    rate will be close to those 300MHz. That's it. It might completely
    change after the driver has probed, or be rounded to something
    else entirely, who knows.

So really, putting it in the DT is nothing but a hack.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--q57fppkqpm6lotdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAoliwAKCRDj7w1vZxhR
xbJmAPkBbeagcGDS3eBgc2WbrSNp5OJbl2fCL3tVsvnrFFTFuAD/c2rcynmQmY1Z
XStuyRJGuSt3w8eU/Y7g5To9pHbMCgk=
=huPr
-----END PGP SIGNATURE-----

--q57fppkqpm6lotdb--


--===============7442878578710773025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7442878578710773025==--

