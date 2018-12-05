Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E124C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:40:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA5A20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exI1RXpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA5A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BgLWGzAjkumWQabDMLKpkpNrvyNfQ4kEHlrwINFnVVI=; b=exI1RXpwrPq+AXa5gYiWwte+H
	urQypFcpDedxq9ivfrMEXG4oA/Plp1ytgvN5pVe5IXAfZ/QoRbqHRqQlQYuFcS916X0qZPmDbFUBf
	g1iBQqXOyr3/D7MqMXLBDQj356S0WIWe1cdhAad/DEeqibUPiSxzhIXsJVupiynWjeDknZRUhUf5X
	kygRbJFg3w7B5RQPIz71j7tfJ9InmEpoLZNxkjxEGRGxtbVTPUUVqHqSs7hF32jk42ZWS+SnNhD+i
	XLsfKuqtf3NqHz2ivOXBJimAyhmd2GUSk3X61W/jkppG0rJWmDLvlrgj9gV8/5Dd3egFdWKexNksB
	VjklfcsJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaDv-0008Dh-Nh; Wed, 05 Dec 2018 16:40:31 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaDr-0008Cd-80
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:40:29 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4394GN4jzyz1qwqW;
 Wed,  5 Dec 2018 17:40:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4394GN3yY6z1qqkc;
 Wed,  5 Dec 2018 17:40:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id cvHAHjcKQdw8; Wed,  5 Dec 2018 17:40:11 +0100 (CET)
X-Auth-Info: xGJCVNlhDAF4aOgyzEM4Q5QNTDar0kCVp367zsoigzk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  5 Dec 2018 17:40:11 +0100 (CET)
Date: Wed, 5 Dec 2018 17:40:04 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
Message-ID: <20181205174004.71f54042@jawa>
In-Reply-To: <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
References: <20181113121213.14296-1-lukma@denx.de>
 <20181126143619.GB31334@dragon> <20181203103333.111c2463@jawa>
 <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084027_440423_318E14A0 
X-CRM114-Status: GOOD (  16.59  )
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
Content-Type: multipart/mixed; boundary="===============6054926839621357430=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============6054926839621357430==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zBu5tezDSu05=agJwMr.Hrn"; protocol="application/pgp-signature"

--Sig_/zBu5tezDSu05=agJwMr.Hrn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Dec 3, 2018 at 7:33 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > > > +           72xx165@0 { =20
> > >
> > > Please use a generic name for the node. =20
> >
> > This is a bit tricky. =20
>=20
> What about using 'gpio@0' like described in
> Documentation/devicetree/bindings/gpio/gpio-pisosr.txt ?

Seems like a good idea. Thanks.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/zBu5tezDSu05=agJwMr.Hrn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwH/2QACgkQAR8vZIA0
zr0WLwgAvK6HXDHE6u5f/QF28kmiVcuLqopfyHnLPnGs/EMn/jrcq0Mfpjn9FJ7/
hlmmga8W+4W6bMb7mrdEkfTRRkeORISNn1Y5VXXTnfqFrbRw74L/ooxWcAE+cu0t
KidkntQwMxr6msaLQUy/bJKSHKmDT5YF720dusi3B6lJccmiqckV/23X1v45qE2j
yJL65GpaD3Yyx7eHlYekbipj58GkUYE16s/SxOBr9AyhIkUxWr2ZvtoChohI5ZBp
Xq1uo8mFSqLKmY4Ane1PWQeh3K+6g1jtP5ySa8pNs/VK55xXpkQe/nDuIi5fDT3Y
rYNee+BQ2vaaMbh4O9Hq67GCcx1cRg==
=4+TV
-----END PGP SIGNATURE-----

--Sig_/zBu5tezDSu05=agJwMr.Hrn--


--===============6054926839621357430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6054926839621357430==--

