Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C47C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A6A2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZjL1qBlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A6A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=413j45S8HNfZ64i3ACHJnLteTgv/rkM00HchAcqqrag=; b=ZjL1qBlqeKdwDYmhiX5yp2HAv
	nkXGM6mejUXcpY8hnYsGC3kKG0jm7OAJe8+JmtYjsZ63MB/LCPbyieoVgpa6L4KLlAA0ZD+jJyejI
	F/DwoqMGbbE47LytOFXTiXs2DWv6jge/4A5DAQcnuXoDpdew6qnS2LAHkj8fNRx7pzOgD/gOXd2lw
	TLuaSk/YP96qBJcHepfisP43y9WD1yOZQIIYBEAN5nGNr1vA3HC2i07tuixuiQxbzSItkJlcNtLbD
	46cAdYldFSG/zDxrj3DVkE9WpH7b1OtDM3aefgy2yfID3RCgR1uJd57YchwZV6etKPFYCYN/syoXr
	GNVHI6B9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCgN-00039t-Vy; Tue, 04 Dec 2018 15:32:19 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCfi-0002Hn-6u
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:32:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 98E98207B0; Tue,  4 Dec 2018 16:31:26 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id B24CE206D8;
 Tue,  4 Dec 2018 16:30:54 +0100 (CET)
Date: Tue, 4 Dec 2018 16:30:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 09/21] drm/sun4i: frontend: Add support for planar YUV
 input formats
Message-ID: <20181204153054.sdckfazc2cfu6tmo@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-10-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-10-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073138_827050_EBCB5C5B 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1242315933662209243=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1242315933662209243==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ucojaxrqyohjhg53"
Content-Disposition: inline


--ucojaxrqyohjhg53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:06PM +0100, Paul Kocialkowski wrote:
> Planar YUV formats come with 3 distinct planes, which requires
> configuring the frontend line stride and address registers for the
> third plane.
>=20
> Our hardware only supports the YUV planes order and in order to support
> formats with a YVU plane order, a helper is introduced to indicate
> whether to invert the address of the two chroma planes.
>=20
> Missing definitions for YUV411 and YUV444 input format configuration are
> also introduced as support is added for these formats. For the input
> sequence part, no configuration is required for planar YUV formats so
> zero is returned in that case.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ucojaxrqyohjhg53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAadrgAKCRDj7w1vZxhR
xaY+AQCMuRQHAsb1fFHeIiq3YjZTcCsIu0L/G8NyH1crXqfGmwD+PZi2dJD3tmwE
l897gR4O0lHx/ghX5Uf3XbdeLsrhSQQ=
=s1WY
-----END PGP SIGNATURE-----

--ucojaxrqyohjhg53--


--===============1242315933662209243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1242315933662209243==--

