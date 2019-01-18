Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD55C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8184420823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YCnYcdYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8184420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V4Bg1/6e6oKdQu4DyFk8g0G91bD371MaIvNbr3boISw=; b=YCnYcdYgjQXjiBNx1XanUhUC5
	EC0rbeiNB2dyLmV6wXea1v4zf/uPLLc9i9c821fSmAIl9bGTXgOWI4k40EBKzuVGIixWNO0O/TuVy
	e6QypesXPZvxoSi9LIXsFYpBF9lT/1eHe7sg2SKuXKRSPKenhw9ylC3epItJbnk5w9jHNwEdg19U0
	4EXkcdIQuZ3NdYLqjpzsAHIfI068qWT/VLVhybSZXvXRKhPEQGE5lzyMr8SkzIgkjCwToy245nsiK
	kwl/XXYyy6gIeWngGpWhKC1Mvl1iP6PFoucvXMv7HwvdROVmAPNotGEKd/XU50jDvEroNQSXrU9ND
	PF3rod1mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYlX-0003f6-OM; Fri, 18 Jan 2019 18:21:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYlT-0003eQ-Ds
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 18:21:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 125E220908; Fri, 18 Jan 2019 19:21:08 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
 by mail.bootlin.com (Postfix) with ESMTPSA id B3CA9206A6;
 Fri, 18 Jan 2019 19:20:57 +0100 (CET)
Date: Fri, 18 Jan 2019 19:20:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH RESEND v5 00/23] drm/sun4i: Support for linear and tiled
 YUV formats with the frontend
Message-ID: <20190118182057.uqohb7nkffgavezi@flea>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_102111_606107_97F9594F 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7964768997770166647=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7964768997770166647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mdijpnhgcdgczxm"
Content-Disposition: inline


--2mdijpnhgcdgczxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 03:51:10PM +0100, Paul Kocialkowski wrote:
> This series implements support for YUV formats using the display engine
> frontend in the sun4i DRM driver, with various fixes along the way.
> Scaling is supported for every format handled by the frontend.
>=20
> The tiling mode used by the VPU on Allwinner platforms is also supported
> by this series and a dedicated fourcc modifier is introduced, along with
> a specific ioctl for allocating tiled buffers.
>=20
> New common fourcc helpers are also introduced in this series, especially
> related to YUV formats.
>=20
> This was tested on the A33, A20 and A10 platforms and all supported
> features work properly on them. Framebuffer offsets and source
> positions are not supported at this point.

I've applied everything, however I can't see the ioctl you mentionned
anywhere?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2mdijpnhgcdgczxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEIZCQAKCRDj7w1vZxhR
xQvqAQCOW8mK24R3dEouhfkDZnIISvUQ68j2sNajP+pLz57F8AD/X0jDwBFXKUhP
Q5fEC43mQS90M+7hn81uMMk8o/fNIw8=
=KCbz
-----END PGP SIGNATURE-----

--2mdijpnhgcdgczxm--


--===============7964768997770166647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7964768997770166647==--

