Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A10C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AC820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lmxk3FQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AC820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pqr+40Bjvei5z9vY/mKB/Ouznxp7BS6h6GM9MSNwU8o=; b=lmxk3FQtLG7UhtxRvZO+3/6GU
	jhBK8eBtO2MyAb88bHgXhv/8pucxjE+9EFMvJ4mjLnemDEHwv5i/wR+z/zbULCU9IDxA96fv0pHX3
	tc+1Oi2KAiXafQuXmDr7cGLqHh+a5T8jML6qV9raQzWUwjHbUbCDeiJ9wcZGTcrGzxyuniJLUmjOH
	OM9FAp0PNEPHls2ENgtGMBocBKN54+bBDheOwt8BV8MasBl0vG2ZO9v/kcrMsI2q8HsuSlogjwmv7
	Wwy8BmL6ZhcUVYco48D4vYE+XngytxdoqQ/L07kcKlRhecr09eU3NdLdmlR1ujWe8P9VY9w4BkOCU
	vM3l+EQVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtClI-0004Y1-Ia; Mon, 11 Feb 2019 14:40:44 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCkw-00041u-9c
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:40:42 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 829E91C0007;
 Mon, 11 Feb 2019 14:40:11 +0000 (UTC)
Date: Mon, 11 Feb 2019 15:40:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Konstantin Sudakov <k.sudakov@integrasources.com>
Subject: Re: [PATCH v2 9/9] drm/panel: Add Ronbo RB070D30 panel
Message-ID: <20190211144011.cm5r2lbfiwm6giya@flea>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
 <3eff6d6164845eee5636d7451b0fe08b09d1cf07.1549619502.git-series.maxime.ripard@bootlin.com>
 <1549628652.999919948@f417.i.mail.ru>
MIME-Version: 1.0
In-Reply-To: <1549628652.999919948@f417.i.mail.ru>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_064023_010209_01F44980 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1352496871295902771=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1352496871295902771==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yq2odd6vgyagrl2a"
Content-Disposition: inline


--yq2odd6vgyagrl2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Feb 08, 2019 at 03:24:12PM +0300, Konstantin Sudakov wrote:
> Hello, Maxime!
>=20
> >+mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> >+if (!mode) {
> >+DRM_DEV_ERROR(&ctx->dsi->dev,
> >+      "Failed to add mode " DRM_MODE_FMT "\n",
> >+      DRM_MODE_ARG(mode));
> >+return -EINVAL;
> >+}
>=20
> Just small fix: DRM_MODE_ARG(mode) -> DRM_MODE_ARG(&default_mode).
> The "mode" variable is NULL, it leads to the UB.

Good catch, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yq2odd6vgyagrl2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGGJSwAKCRDj7w1vZxhR
xUD8AP9Xo+azDG9eiCXY47mOqcW7SXPKCSh5RWw720edCQCkHgEA+iOhFAtTS3b4
lyus6u3axSxkcAj3pNDgIrhd7L/0vwM=
=GT3t
-----END PGP SIGNATURE-----

--yq2odd6vgyagrl2a--


--===============1352496871295902771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1352496871295902771==--

