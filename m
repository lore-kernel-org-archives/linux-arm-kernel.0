Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:23:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A229A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfrwxPdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A229A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NT2S4gfO4difG1Zl3TkE6lRkOsqdxRFx3tTyMhbdDY8=; b=VfrwxPdF6p+qHSUX1+DChUhRB
	hkMTQrgZwHxwOpAL+tcjjqEOJAEO7gV8nuwHFhb/HOeWW+1fgY1obw4Fu5+K7sdoJOvq53dE/R1jJ
	FjGaueZ+tssXvpkO3itqQ1UK1RsxsMLDBpJxXZ6WEfHH06SQV5VG6+xn1+UTNKv7+paPoxp84wq4e
	z3D6MbsuuYEX3DGF8E/ovREtwF7+pQ5NGwiD7NOs+0Tx30qYY80S08OgS1ttjHYde07GZYsw5oP7G
	/gwFJ8uFR1yAHfie3PQOuOl9VdT0OQdxp8xG5fFHMLqYC5ciJ3KMtGoR+ZCXpeFSrUfvB3e73GIbH
	sjYc8mqAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUowb-0001a2-Sz; Thu, 06 Dec 2018 08:23:37 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUowV-0001ZG-IO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 08:23:35 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 439TBZ4qF1z1qvvw;
 Thu,  6 Dec 2018 09:23:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 439TBZ3Swyz1qsKF;
 Thu,  6 Dec 2018 09:23:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id nNIHhw2-kvCa; Thu,  6 Dec 2018 09:23:14 +0100 (CET)
X-Auth-Info: LKrGr5vTkuxSQCQnQQjXo0+XTceINZBWkCIRzVP3kkY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Thu,  6 Dec 2018 09:23:14 +0100 (CET)
Date: Thu, 6 Dec 2018 09:22:55 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181206092255.2359f7e6@jawa>
In-Reply-To: <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_002331_917898_D54D401E 
X-CRM114-Status: GOOD (  20.23  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>,
 Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1999475028325104136=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============1999475028325104136==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fNAwIrkEodxHoPV9nxRzz8E"; protocol="application/pgp-signature"

--Sig_/fNAwIrkEodxHoPV9nxRzz8E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Dec 2018 21:12:46 -0200
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Lukasz/Rob,
>=20
> On Tue, Oct 9, 2018 at 7:50 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > +&dspi3 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_dspi3>;
> > +       bus-num =3D <3>;
> > +       status =3D "okay";
> > +       spi-slave;
> > +
> > +       slave@0 {
> > +               compatible =3D "lwn,bk4";
> > +               spi-max-frequency =3D <30000000>;
> > +               reg =3D <0>;
> > +       };
> > +}; =20
>=20
> This is causing the following dtc warning in linux-next:
>=20
>   DTC     arch/arm/boot/dts/vf610-bk4.dtb
> arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
> /soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
> bus
>   also defined at arch/arm/boot/dts/vf610-bk4.dts:106.8-118.3
> arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> prerequisite 'spi_bus_bridge'
>=20
> If spi-slave property is removed the warning is gone.

The spi-slave has been added according to review suggestion:
https://lkml.org/lkml/2018/9/26/836

That is the way to handle "slave" SPI operation mode across the kernel.=20

At the time of development - I've checked my NXP related patches with
W=3D1 passed to make. No warnings observed then.

>=20
> Looking at drivers/spi/spi-fsl-dspi.c I don't see the "spi-slave"
> property being handled there.
>=20
> Any ideas on how to fix this?

The *.dts file for Vybrid was sent and work on in parallel with the SPI
slave code implementation for Vybrid:

https://patchwork.kernel.org/patch/10680431/

Unfortunately, for the above patch I did not received any feedback
since mid September.

>=20
> Thanks




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/fNAwIrkEodxHoPV9nxRzz8E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwI3F8ACgkQAR8vZIA0
zr1XwAf6AzT3SWC4ta3Q1VnPdsJTyE+ICHtxvUx2K7CwI8Nr5Ccu05Z0X6SxIaKJ
I+IcpI9ywCPueOlcl1+ltTHGXY+K2xkQLqhqlPuWA7jWgkPIN56pXVD1ncB4+6LV
i9AR1KpaAM9MwJDzVx9wbP4wjOgNqi1jqfkFJ0T9goyC6zcjTNPFrU847krUGu+D
T9jO01LSxD3qszbIPEqfhoXF5VsE61oChuD0tmLJmerFP0+nJ2lXIN7pq1c80XBp
dPpRl7vWGjyc353QpaOp09re5iiYHzRihKvpLlgQeZqOz47UnL8/8YjI+dPHFgud
aqQW5e36WOm+E6Nn1tY4lszaIPredg==
=MIct
-----END PGP SIGNATURE-----

--Sig_/fNAwIrkEodxHoPV9nxRzz8E--


--===============1999475028325104136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1999475028325104136==--

