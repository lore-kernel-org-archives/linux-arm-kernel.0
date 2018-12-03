Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:34:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FAF214D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MfcCuSs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FAF214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RX+b2zV8wv56FlvxmIHu29vOWJaIEwnPAaKEV2exuuE=; b=MfcCuSs1GXq1aCjtJkrVQYnPj
	bv+8Xl6aOrSWcbyCFYm/4bB8esfwFfsuJUrfHGPpTJOXYmGOq0GMRU+8k5nL2ksDFiJ5lqXpaxkiv
	1hzgNaywLBRJ9JmtI2PD2qeQ0utvFMJe0KsbFoHVVv8jwnE5+ecyXZVn+FSr8U49o9Rr3GYaBOeA4
	5jWkM/zSLjvCTR09lNlHf9nsbICLn4AY8Fk+5jjSAGjzwTqhYno2dN8YfZneQUV+E7JyKwEytujFT
	SXVVVTe5Db67VKkjPUm4w9qFfZjnzsMm1Os7unU1buMQIG5KwLzh+ajlWBRuVM4tswimYI55HA/rV
	ZPUoveLpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkc7-0001vv-6D; Mon, 03 Dec 2018 09:34:03 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkc2-0001lq-Qi
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:34:01 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 437fvD1DqBz1qxkG;
 Mon,  3 Dec 2018 10:33:44 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 437fvC6jR4z1qw61;
 Mon,  3 Dec 2018 10:33:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id DS0ps5AMs7us; Mon,  3 Dec 2018 10:33:42 +0100 (CET)
X-Auth-Info: q+CBZCsNybzeoxei96YH6J/qfVLomaVA1dHLaCx61uk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon,  3 Dec 2018 10:33:42 +0100 (CET)
Date: Mon, 3 Dec 2018 10:33:33 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
Message-ID: <20181203103333.111c2463@jawa>
In-Reply-To: <20181126143619.GB31334@dragon>
References: <20181113121213.14296-1-lukma@denx.de>
 <20181126143619.GB31334@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_013359_171188_C347E733 
X-CRM114-Status: GOOD (  24.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4143279247355126497=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============4143279247355126497==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4OQ7RAQWdTkk1qF09dh+./Q"; protocol="application/pgp-signature"

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thank you for the review.

> On Tue, Nov 13, 2018 at 01:12:13PM +0100, Lukasz Majewski wrote:
> > The procedure to read this ID value is as follows:
> >=20
> > rmmod spi_fsl_dspi
> > insmod spi-gpio.ko
> >=20
> > echo 504 > /sys/class/gpio/export
> > cat /sys/class/gpio/gpio504/value
> > ...
> > echo 511 > /sys/class/gpio/export
> > cat /sys/class/gpio/gpio511/value
> >=20
> > rmmod spi-gpio.ko
> > insmod spi_fsl_dspi
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
>=20
> A prefix like 'ARM: dts: vf610-bk4: ...' might be better.

Ok.

>=20
> > ---
> >  arch/arm/boot/dts/vf610-bk4.dts | 31
> > +++++++++++++++++++++++++++++++ 1 file changed, 31 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/vf610-bk4.dts
> > b/arch/arm/boot/dts/vf610-bk4.dts index cab95714c058..f01c735807ae
> > 100644 --- a/arch/arm/boot/dts/vf610-bk4.dts
> > +++ b/arch/arm/boot/dts/vf610-bk4.dts
> > @@ -59,6 +59,29 @@
> >  		regulator-min-microvolt =3D <3300000>;
> >  		regulator-max-microvolt =3D <3300000>;
> >  	};
> > +
> > +	spi_gpio {
>=20
> We recommend hyphen rather than underscore be used in node name.

Ok. I will change it to spi-gpio

>=20
> > +		compatible =3D "spi-gpio";
> > +		pinctrl-0 =3D <&pinctrl_gpio_spi>;
> > +		pinctrl-names =3D "default";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		/* PTD12 ->RPIO[91] */
> > +		sck-gpios  =3D <&gpio2 27 GPIO_ACTIVE_LOW>;
> > +		/* PTD10 ->RPIO[89] */
> > +		miso-gpios =3D <&gpio2 25 GPIO_ACTIVE_HIGH>;
> > +		num-chipselects =3D <0>;
> > +
> > +		72xx165@0 {
>=20
> Please use a generic name for the node.

This is a bit tricky.

Other DTS definitions for this compatible:

sn65hvs882: sn65hvs882@0 {
	compatible =3D "pisosr-gpio";
	...
	}

They use the exact used IC name - sn65hvs882, which IMHO is the way how
this node shall be described.

The reason is that the compatible is "pisosr-gpio" -> parallel input
serial output shift regsiter - gpio.

By adding the exact name of connected electronic IC - sn65hvs882 and in
my case IC from the 72xx165 family provides good description of the HW.

Maybe you have other idea how to provide the name of the IC connected?

>=20
> Shawn
>=20
> > +			compatible =3D "pisosr-gpio";
> > +			reg =3D <0>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			/* PTB18 -> RGPIO[40] */
> > +			load-gpios  =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> > +			spi-max-frequency =3D <100000>;
> > +		};
> > +	};
> >  };
> > =20
> >  &adc0 {
> > @@ -430,6 +453,14 @@
> >  		>;
> >  	};
> > =20
> > +	pinctrl_gpio_spi: pinctrl-gpio-spi {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB18__GPIO_40        0x1183
> > +			VF610_PAD_PTD10__GPIO_89        0x1183
> > +			VF610_PAD_PTD12__GPIO_91        0x1183
> > +		>;
> > +	};
> > +
> >  	pinctrl_i2c2: i2c2grp {
> >  		fsl,pins =3D <
> >  			VF610_PAD_PTA22__I2C2_SCL
> > 0x34df --=20
> > 2.11.0
> >=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwE+G4ACgkQAR8vZIA0
zr2v4gf+JOffL084LxwKXmYrHWohgLSaKYfGDIF/vVmqycfG1bzJIogeI73uM0bY
/9FtgeXd0P0IwRG8ugltg94fEN9itfWDeEHDt0TNvaSdcX0BNM1swp2JHNjINX/P
MdhHOj+geabFXHMahcu7Q5Pchr2u8Jfn0/7hMND9mY5bH5zqFiKlUSuNVuCacBaF
qHPp3TcXvFYnoo0nUKvPhnESvIGoxRHwZE99zpfeiFR15eLvvI5MSTYwsEd3nDNa
Zk78dT0tF3jpskE9bjsJSTXCFkbZuzIbFxHrgKSMCyoBhZZzkHZ91CqoSsLzKA+e
HMbXE1D9sjxiCtP2jBGJzUJKwj+DDA==
=85Ok
-----END PGP SIGNATURE-----

--Sig_/4OQ7RAQWdTkk1qF09dh+./Q--


--===============4143279247355126497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4143279247355126497==--

