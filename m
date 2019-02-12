Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89ECC21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u90FUZOT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="noIlPoa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89ECC21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kvLo3Xw4TVMIF9zAYPJ7ugOMVQkkLLaJUHX8pLYjpic=; b=u90FUZOT3Mjn4oehhrQg+Q0Hg
	N2NODsp7wM/SmZClgZ69eps8NlkTTvJkOjHXbZhyt+LPz/U+bzR27Y3SPDReNaXuZzastDDvMuQmE
	VMaJJ5Mk/D6LbvXU4c2wPGSgeunbQFe+nzOTyqYZegPLFZSdi1zxMcemTzi61QC/QPkIJE4pVKUYS
	4rOcYK+6TxOMQGdSnX/hE33ptRHyMQj7mSu6xplAVrtM3CCbrf7QpKNqCsV5TthINGNflM+incR51
	PReEJt2qgEvAKLlynnzyx0KX6mkezu+8o3rFsK70hFKGSq81nSE62a3+mKZvKMvMbcG65Bi73sxH3
	kJOgYTE9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtViB-0002G1-K3; Tue, 12 Feb 2019 10:54:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVi9-0002Da-NY
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 10:54:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VvlNXaYvz2fDJ9OK4GMkXjdePmays14BtOpgwkDvFh4=; b=noIlPoa2NJVtElOWKd14XiGCk
 Pboq0oBDIoyAUQ9xPcX/hCcKFUcRG95R4UBrag/xWSPoalmHFL3axF7bh5LlXMdjUEkjXOPcUg9EP
 eHso/Y5EUUogsn9sOiJuWnp1Wkt7anSRhyU3iplm1P0lJu8dcaa96J0BKpHHPxvjqq2XOFbIi4+9Q
 +8JV9yn1ese2XUwKE1MITmt9a+JKVH1+Vsm1Yc62LrlH19bZqY/4rAn8dUbz9WYIY6wHrxroTAhUK
 7rzjj4MaHf5FWdB2fTIsM9EtpFUxrZWxlOqLyH3rYavod4ND8UhmxKzfK2K9DgJlJ6OJUXMK2IUu0
 weLXstA5g==;
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVXb-00044Z-RQ
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:43:53 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 1BED6100006;
 Tue, 12 Feb 2019 10:43:14 +0000 (UTC)
Date: Tue, 12 Feb 2019 11:43:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 2/2] media: cedrus: Add H264 decoding
 support
Message-ID: <20190212104314.slytpbufwhf5ujv7@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <4c00e1ab1e70adb1d94db59c37393250ca3791c5.1549895062.git-series.maxime.ripard@bootlin.com>
 <12916702.RFRCeC2GgE@jernej-laptop>
MIME-Version: 1.0
In-Reply-To: <12916702.RFRCeC2GgE@jernej-laptop>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_104351_930807_15843FB2 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 jonas@kwiboo.se, linux-kernel@vger.kernel.org, jenskuske@gmail.com,
 Chen-Yu Tsai <wens@csie.org>, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-sunxi@googlegroups.com, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, nicolas.dufresne@collabora.com,
 ezequiel@collabora.com, posciak@chromium.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0616956723059021477=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0616956723059021477==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5gdejtoqqa6qlisa"
Content-Disposition: inline


--5gdejtoqqa6qlisa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 11, 2019 at 08:21:31PM +0100, Jernej =C5=A0krabec wrote:
> > +	reg =3D 0;
> > +	/*
> > +	 * FIXME: This bit tells the video engine to use the default
> > +	 * quantization matrices. This will obviously need to be
> > +	 * changed to support the profiles supporting custom
> > +	 * quantization matrices.
> > +	 */
> > +	reg |=3D VE_H264_SHS_QP_SCALING_MATRIX_DEFAULT;
>=20
> This flag should not be needed anymore. From what I see, you correctly se=
t=20
> scaling matrix every time.

The scaling matrix control is optional, so I guess we should protect
that by a check on whether that control has been set or not. What do
you think?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5gdejtoqqa6qlisa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKjQgAKCRDj7w1vZxhR
xbGrAQDuJ3RI8iJRp2xbjnQ//F/tGuWwtz7PdNfWKUaQvNBr0AD8DA9cnLZ4F7c3
hTdzfxkMmPlsb+v5HUPlK14j1NWIRgY=
=LFLc
-----END PGP SIGNATURE-----

--5gdejtoqqa6qlisa--


--===============0616956723059021477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0616956723059021477==--

