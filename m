Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF8C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B0920661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZFAI9zV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B0920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YszP/XQxnxQWkx8sZecJsKWfiBMl5W9wPQpnQenQODM=; b=ZFAI9zV/BgfI2Iy3uuflvbZio
	7w5wGMVPpUDvofa4cHvGizZPNkDWOLIqvX++zKRr/aNucduHyjeFGFnP6KmdmtDEgpKoz+esfGYwz
	yxrTdY/Q2ZoRdfJXiTUoUF4fUokFQ2IJ9AaPG4FBSFzR30DbZC0o98fMs6O06kIEsMGerAGqFL5oT
	vAms3FyIJLeYX3/VjIrWzFXBuqKtOItgGBZuGMFvZ0pkG7G53X+FIN9kRG4aT7zTVSSLD+BOLw4XU
	aGyJ7Z7pKjZ8RRODyJzGtbXKh0RMzj4M6/A225cl7ZJtvV00lQVnyEJG4nS9+brIL6CpE/IAMZ6mG
	+CpPRVW6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW7RG-0007fh-3E; Sun, 09 Dec 2018 22:20:38 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW7RC-0007e5-A5
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 22:20:36 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43Cgd13MVYz1qxPw;
 Sun,  9 Dec 2018 23:20:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43Cgd11tRYz1qqkh;
 Sun,  9 Dec 2018 23:20:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id TXsFragPXlSi; Sun,  9 Dec 2018 23:20:19 +0100 (CET)
X-Auth-Info: kWHZuvCncEicW9mqWW5NM83udzlezydgE24dPajHmSw=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun,  9 Dec 2018 23:20:18 +0100 (CET)
Date: Sun, 9 Dec 2018 23:20:11 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181209232011.715a32c0@jawa>
In-Reply-To: <20181207102950.68796cf0@jawa>
References: <20180921152726.31742-1-lukma@denx.de>
 <20181009105028.17971-1-lukma@denx.de>
 <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
 <20181206092255.2359f7e6@jawa>
 <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
 <20181206140840.53d49cd6@jawa>
 <CAOMZO5CUfN7uLf7bsw6Xg4+TNrRYodw11Ekg5ypqyXU6q-UFtg@mail.gmail.com>
 <20181207102950.68796cf0@jawa>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_142034_657455_C88CCFB3 
X-CRM114-Status: GOOD (  21.76  )
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
Content-Type: multipart/mixed; boundary="===============7558953064481000620=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============7558953064481000620==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tIsFC8=e+p_Q2_86C7zLMgM"; protocol="application/pgp-signature"

--Sig_/tIsFC8=e+p_Q2_86C7zLMgM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Fabio,
>=20
> > Hi Lukasz,
> >=20
> > On Thu, Dec 6, 2018 at 11:08 AM Lukasz Majewski <lukma@denx.de>
> > wrote:=20
> > > I will check this latter this week...   =20
> >=20
> > Reading the spi dt-binding it states that the spi slave node is
> > optional.
> >=20
> > If I remove it like this, then the warning is gone: =20
>=20
> Unfortunately, the "slave" node is necessary - the "lwn,bk4"
> compatible causes the spidev driver to be bound.=20
>=20
> Use space applications on this system use it to perform SPI
> transmission.
>=20
> IMHO, removing the node is not a solution - we shall discover why on
> current next we do see such errors.

It seems like those errors were present earlier:

https://www.lkml.org/lkml/2018/9/20/106

and=20

https://www.lkml.org/lkml/2018/9/20/669

It seems like the commit: 5a2ecf0de0d3d7a79e21397ad530904a72b903bb
seems to fix the issue.

But I don't know why it doesn't work in this case.

>=20
> >=20
> > --- a/arch/arm/boot/dts/vf610-bk4.dts
> > +++ b/arch/arm/boot/dts/vf610-bk4.dts
> > @@ -109,12 +109,6 @@
> >         bus-num =3D <3>;
> >         status =3D "okay";
> >         spi-slave;
> > -
> > -       slave@0 {
> > -               compatible =3D "lwn,bk4";
> > -               spi-max-frequency =3D <30000000>;
> > -               reg =3D <0>;
> > -       };
> >  };
> >=20
> >  &edma0 {
> >=20
> > Does spi slave still work without it? =20
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/tIsFC8=e+p_Q2_86C7zLMgM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwNlRsACgkQAR8vZIA0
zr3TKwf/XIc3zzc87BV7eEiUqLiYWK3uQOCnO+wNoP6NF4U0d8CLzKPNd09gBUw8
TVf2NXKsvfIf8xZnERTYhwf+Cwo7aW/1JpH4+76yVcZdA2zZ90vpiUMyqNH0Vup8
SzuDghi9N0fvkTqiH2Fm7hStjMPbstnw68UEbLPLipWPHQyo6WMsAU54NFVo9XJ+
5Hp2GScz5ziQRwjL4y/TdxokUMarKaEzPDM6j4pLBxJTYq7kwi645vXXOjbj2Ri1
pK/bHunfkEESw2YoXaYrxxH+GxUYNR8ylLBPPQOH1Ik6wxRLG5srmUlZ2ddQnUjs
nUUl+3thrFEioEquVAO83+Iwu4X2mA==
=srFS
-----END PGP SIGNATURE-----

--Sig_/tIsFC8=e+p_Q2_86C7zLMgM--


--===============7558953064481000620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7558953064481000620==--

