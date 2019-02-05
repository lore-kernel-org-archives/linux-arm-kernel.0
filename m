Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE3EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:31:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBF20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHgSf/84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xs/rVb+Emj+d65bhLayNJLwK9jcRO7DOgwczF3grfHY=; b=fHgSf/84UZtQw07vQXq0rmtgw
	gRQ8zKUnCqJ1oA8q4CXi6W17xcQEzmte0jL/2Yiwz+PR49lO63TZ/c9nBJ2Li+wSiCSjBTx8KFKXo
	9jXZW+gWM+jB3CU6IoWHUiGVk8gSLBEChMRStAxWNhrSQjAFvWdzlgScEKWrtt/hGyeNEwcYbTm8b
	NzKa+XRsWRjFFoHa02CCaewmJtdPGlk5zLf6KNL07sPHP5lKtraxrt4gHYSR0OZODL5JMZdi2LdSL
	IxODe5wNA1BMomWCALTKg5aL0TRVgifAcdXBKOU9yAJBpM2w+yffo3yjP9mwpm+gHYy03eetfxCS2
	OIAV5J3dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2hT-0007Na-Hg; Tue, 05 Feb 2019 15:31:51 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2hQ-0007NB-6E
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:31:50 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3BF31FF806;
 Tue,  5 Feb 2019 15:31:39 +0000 (UTC)
Date: Tue, 5 Feb 2019 16:31:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 4/4] drm/panel: Add Rondo RB070D30 panel
Message-ID: <20190205153138.ofvsxbajmm44natx@flea>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <15b81a58eddd5d3fbfa418293cf1c817ef46423a.1548236066.git-series.maxime.ripard@bootlin.com>
 <20190126153946.GB17756@ravnborg.org>
 <20190129153748.4jpx4kkortmlgq4r@flea>
 <20190129154833.GA22238@ravnborg.org>
MIME-Version: 1.0
In-Reply-To: <20190129154833.GA22238@ravnborg.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_073148_380149_B0B55393 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7321606609440243290=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7321606609440243290==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fur4zl6sdynv7n6b"
Content-Disposition: inline


--fur4zl6sdynv7n6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Tue, Jan 29, 2019 at 04:48:33PM +0100, Sam Ravnborg wrote:
> > > > +	}
> > > > +
> > > > +	drm_mode_set_name(mode);
> > > > +
> > > > +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > > > +	drm_mode_probed_add(connector, mode);
> > > > +
> > > > +	panel->connector->display_info.bpc =3D 8;
> > > > +	panel->connector->display_info.width_mm =3D 154;
> > > > +	panel->connector->display_info.height_mm =3D 85;
> > > See comment on height above.
> > > Same goes for bpc
> >=20
> > Sorry, I'm not sure to follow you here. bpc and height are both set?
>=20
> I assumed that if we had specified height and width in display_mode
> then we did not have to do it here. But I may be wrong.

It looks like it's not done by the core, but panel-simple simply
copies it, so I'll do it as well.

Thanks for the suggestion!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fur4zl6sdynv7n6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFmsWgAKCRDj7w1vZxhR
xScVAQDpdrNCJQJrJsogvF71LeaoutFHtNdkfVooENKBFCGPlwEArOJmMvMcPMsM
ntGFnTeclFzQgSva9F75LlgKuKje2AQ=
=NQ8z
-----END PGP SIGNATURE-----

--fur4zl6sdynv7n6b--


--===============7321606609440243290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7321606609440243290==--

