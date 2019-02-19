Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:43:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB86521479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ni39gGOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB86521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GhuA0oZzggegXEu4dNXfHB/kEzlZEWqGT18VFSa36t8=; b=ni39gGOfD0T5s2VIaN2t7SU2z
	ZlG+Jz11orBtfEqbhbhQimTKjBeOyNGXbeqVEolckHW3OyJ1hsondkzUEbtWGcdmRMhAiF46qvbx5
	R3XC7BbMUKYlZUfmWYav35opqkBj516XkqWCO3ZCAJ40lxbLy1tufcB4Jhrqj1dNeo1IvNyzemQq6
	r+RRNxQWAaDDOXd5XAgbB/XgaGj6n+biP/zNK8PUYj0T2vj6MTaFpCQ6P18fVagYQsHyzmB/gHs5h
	680Qj8h2RAEJQK6eo+C/63GENYhu+V74SfOMnB29jIxwg0H/9+HOcD1kBbhtdbfcjdutmZkejJdZA
	/GlV/p2cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwF2s-0002Lj-JI; Tue, 19 Feb 2019 23:43:26 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwF2p-0002Ke-1W
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:43:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 0851827FF96
Received: by earth.universe (Postfix, from userid 1000)
 id C09743C08DD; Wed, 20 Feb 2019 00:43:17 +0100 (CET)
Date: Wed, 20 Feb 2019 00:43:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60
 SoC
Message-ID: <20190219234317.2oyp3ktqp3cikh5l@earth.universe>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-3-nicolas.ferre@microchip.com>
 <20190208152435.GC23062@piout.net>
MIME-Version: 1.0
In-Reply-To: <20190208152435.GC23062@piout.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_154323_216785_49CCCB22 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7094335523764743152=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7094335523764743152==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tkplu3agw26zk46b"
Content-Disposition: inline


--tkplu3agw26zk46b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 08, 2019 at 04:24:35PM +0100, Alexandre Belloni wrote:
> On 06/02/2019 19:12:21+0100, Nicolas Ferre wrote:
> > Add support for additional reset causes and the proper compatibility
> > string for sam9x60 SoC. The restart function is the same as the samx7.
> >=20
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> > ---
> > v2: split series and collect tag
> >=20
> > Sebastian,
> > I add your Acked-by tag here but as I would like that you take the 3 pa=
tches on
> > your tree now, I let you modify it on your side. I'm expecting Alexandr=
e or
> > Ludovic to have a look as well.
> >=20
>=20
> Sebastian, please take this series through your tree. Thanks!

All right. I just merged them!

-- Sebastian

--tkplu3agw26zk46b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxslJIACgkQ2O7X88g7
+ppA5A/+IgJmgk73r39b7sVQDIRJzLpLKH/r6ioaFSbPCcC4owKjc0U4O0V+peRz
tZfwhfjeARci7EwVfrpmm9cXcoAtQ7A8uLrDjK/30zNZ6bIj/LymFzaF9YbuFo4P
A6N/7HfGPSMjc6a0V09jYWkQ7nHuvdoxocr4TKDg8JREAZVdih4gKtUoWnc26iQQ
gjWPx/yo4KAzHi9BbknO7z1LLxS4wmfjWlvLZTLJ6gv7oSEL48dM/KVsLXN5hWzn
vvpeHgbLl87DWRxFNHLjhO7IDPfVh01lGWnThvqP+1+O/qjCq6w0QPvVbSU7ERPj
qsyKE8ImbXOg8TBVswEord1chbOmCDbawL76vlOq7w1GN2B8Psedr/uu2vV+hS1c
wvSvIEL8f5m8E2OsyfssRjbtJqS+rWHcTuucHdRZa/xY3M+/OscVX8dQ3FLgB9bQ
2+V7AvAR7c8OHiXGF0nZZ4AHAwdb3XbkL/BUiD4+3ko3mpIHwId/EJXRCUlMPdCw
0bGzo9IQSJx50FzIA/3s1Oih1nBto9Gr4qidCD8clRIMvbsyesDiiRgYUl+MqMTh
RQd43y5CebvIchrYvIuM7xPnCHlwbb+7UM2wfHEaRMpoVVntr5HJcgaUlFRWavRs
icJF/h7BInttqAm0OFCo6UoP4wyJvHXWOrNBxQ21EPjD8EqzO18=
=oRbw
-----END PGP SIGNATURE-----

--tkplu3agw26zk46b--


--===============7094335523764743152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7094335523764743152==--

