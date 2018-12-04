Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA1C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1C62081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WbqNDjuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1C62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OT5niTZzuPn0OH/qV1AMg/kaOWIRvqWj/3quctwbda0=; b=WbqNDjuDIanDGL1HWNNm/vCHh
	sC1pZkV8DYDcnkGKEvktgQU0a5TvVAWq66xID2mG8k7vRv/1I/mCZ/PKplhbfPQ0z2pQrz5IgjDpy
	hgOytHWyJgo7KStBcUk4o6O2831BEAYn01r6hyiUlPfZ0f/QBorLAXpab4m7CHEFa/4++OYS8PHio
	k6Q7kr4wslDM+0hoyDbTGVK1tZAnVksMtVuqwuEfleq5PdGsks7OeMjITz+fx0DdPeM8dNQ+ObnUA
	vfEBHaHjkxeFaURErF+Q/v0nMZxjaQtk11MZvySchqArMUL7ZQegAQ11A/8N6FT8Ak1LNLknspBOJ
	Gvaz1A+/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCfE-0001xe-Jk; Tue, 04 Dec 2018 15:31:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCfB-0001vE-9e
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:31:06 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2BA4E20A58; Tue,  4 Dec 2018 16:30:54 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 200D5206D8;
 Tue,  4 Dec 2018 16:30:19 +0100 (CET)
Date: Tue, 4 Dec 2018 16:30:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 08/21] drm/sun4i: frontend: Add support for
 semi-planar YUV input formats
Message-ID: <20181204153019.cosrc2orkkenviyx@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-9-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-9-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_073105_481370_3E984C82 
X-CRM114-Status: GOOD (  11.85  )
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
Content-Type: multipart/mixed; boundary="===============8708804858044396750=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8708804858044396750==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m7i3f3pybjrzod7n"
Content-Disposition: inline


--m7i3f3pybjrzod7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:05PM +0100, Paul Kocialkowski wrote:
> Semi-planar YUV formats use two distinct planes, one for luminance and
> one for chrominance. To add support for them, we need to configure the
> second line stride and buffer address registers to setup the second YUV
> plane.
>=20
> New definitions are introduced to configure the input format register
> for the YUV420 and YUV422 semi-planar formats.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m7i3f3pybjrzod7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAadiwAKCRDj7w1vZxhR
xSCPAQC1N+LO8bndAFQ13mAC/xrsD0Re8gYZTnoWdgZhrvQfbgEAwd+xPuvjm3x2
ReBrePlOHXRJC+yGL/YZRT8PcsyKowE=
=vEa5
-----END PGP SIGNATURE-----

--m7i3f3pybjrzod7n--


--===============8708804858044396750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8708804858044396750==--

