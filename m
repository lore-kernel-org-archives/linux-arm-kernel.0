Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8AB214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q9Tn3tfC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pr58t+k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8AB214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uQWimh5NKdY2qsIrVk/tu6a8HRLMu07cPCKfvwdnceU=; b=Q9Tn3tfC7nOR6z8Z8/rZ6NgUE
	iixJmKes7t3RJz4uNo5wvZTzUz5/r2ztiT11aNEFv5QKph9l1YHScAY9DF9QySVu660mH8elHkpvU
	9ykG/DG3OyLePrVnAi86qdhMqxmLSo3quFQarFoILq9G8gpFg7CVyQ+0c2anaoegzq7bQIuDoX8k1
	NS5JhJ7gIHR2OmzsQ/A02SnvKFSJagGJeDSmfwc0lGay/4N3KBv+ZeE8aD8+KQ9tDQJTbPi3MB/GQ
	cHGwKncNRDvO9pgvBfcWXxKb62cAhQjdbEsqd2LzKOec5A93Cw92kh1Gh7wbEsOTltXXSRVaVvRh0
	PzIOGzSAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVT0-0004N8-36; Tue, 29 Jan 2019 15:38:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVSy-0004Mz-5j
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 15:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=abl3Vn8v98oLNg01/YWT6V0pVV5M2UFeCgRXnzXF4i4=; b=Pr58t+k2zMGFN2/u+IzDlbs+M
 6j0v1nHQ5iMjkUfcW10jJwYj+6Gcl30NCZoBUqmMaP15G5bPmCnHgOBFtiWTswV5fsCvdbnYxwTnn
 NPotdDDYxiCCHygg6Qt2SwrC4CfsmsPQnFtsMmQEtyqWDY/onV+HNYN+qfIp9DVMVaYI5Lh8CZEnx
 hptZn910THH3/pveGPOpZdtKcD5znsZGthbwbr/r1rx6ZIHZ6SosoOEfqMZhP/h3EqKkPEy0DHE0i
 LnL1szq4UZ6nSa3OPFIXkD+KefO5DbLMlCFuT4zkcNTbu0JGTFGD+xQquIqymt75chha+3SCjDL0u
 dlfHK4BjQ==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVSu-0002yj-Iy
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:38:21 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 58C82C0002;
 Tue, 29 Jan 2019 15:37:49 +0000 (UTC)
Date: Tue, 29 Jan 2019 16:37:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 4/4] drm/panel: Add Rondo RB070D30 panel
Message-ID: <20190129153748.4jpx4kkortmlgq4r@flea>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <15b81a58eddd5d3fbfa418293cf1c817ef46423a.1548236066.git-series.maxime.ripard@bootlin.com>
 <20190126153946.GB17756@ravnborg.org>
MIME-Version: 1.0
In-Reply-To: <20190126153946.GB17756@ravnborg.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_103820_821630_BABFDB40 
X-CRM114-Status: GOOD (  18.60  )
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
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6816752333527057563=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6816752333527057563==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mfio26ejibuzu6kg"
Content-Disposition: inline


--mfio26ejibuzu6kg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Thanks for the review, I'll address the points left out.

On Sat, Jan 26, 2019 at 04:39:46PM +0100, Sam Ravnborg wrote:
> > +		return ret;
> > +	}
> > +
> > +	/* Reset */
> > +	msleep(20);
> > +	gpiod_set_value(ctx->gpios.power, 1);
> > +	msleep(20);
> > +	gpiod_set_value(ctx->gpios.reset, 1);
> > +	msleep(20);
> > +	return 0;
> > +}
> To verify the above pointer to a datasheet would be nice.

Unfortunately, it's not publicly available :/

> > +
> > +static int rb070d30_panel_unprepare(struct drm_panel *panel)
> > +{
> > +	struct rb070d30_panel *ctx =3D panel_to_rb070d30_panel(panel);
> > +
> > +	gpiod_set_value(ctx->gpios.power, 0);
> > +	gpiod_set_value(ctx->gpios.reset, 0);
> > +	regulator_disable(ctx->supply);
> > +
> > +	return 0;
> > +}
>
> There is sometimes timing constrains after deassert reset..
> The order is not strictly reverse of prepare - is that on purpose?

You're right about the order. I couldn't find any delay after a reset
though in the datasheet.

> > +/* Default timings */
> > +static const struct drm_display_mode default_mode =3D {
> > +	.clock		=3D 51206,
> > +	.hdisplay	=3D 1024,
> > +	.hsync_start	=3D 1024 + 160,
> > +	.hsync_end	=3D 1024 + 160 + 80,
> > +	.htotal		=3D 1024 + 160 + 80 + 80,
> > +	.vdisplay	=3D 600,
> > +	.vsync_start	=3D 600 + 12,
> > +	.vsync_end	=3D 600 + 12 + 10,
> > +	.vtotal		=3D 600 + 12 + 10 + 13,
> > +	.vrefresh	=3D 60,
> > +};
> height and width missing here. Seems better to add them here than hiding =
in code below.
> Is it on purpose that no flags are specified?
>=20
> > +
> > +static int rb070d30_panel_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_connector *connector =3D panel->connector;
> > +	struct rb070d30_panel *ctx =3D panel_to_rb070d30_panel(panel);
> > +	struct drm_display_mode *mode;
> > +	static const u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> > +
> > +	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> > +	if (!mode) {
> > +		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> > +			default_mode.hdisplay, default_mode.vdisplay,
> > +			default_mode.vrefresh);
> Use"
> 		DRM_DEV_ERROR(&ctx->dsi->dev,
> 			      "failed to add mode" DRM_MODE_FMT,
> 			      DRM_MODE_ARG(mode));
> > +		return -EINVAL;
> > +	}
> > +
> > +	drm_mode_set_name(mode);
> > +
> > +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> > +	drm_mode_probed_add(connector, mode);
> > +
> > +	panel->connector->display_info.bpc =3D 8;
> > +	panel->connector->display_info.width_mm =3D 154;
> > +	panel->connector->display_info.height_mm =3D 85;
> See comment on height above.
> Same goes for bpc

Sorry, I'm not sure to follow you here. bpc and height are both set?

Thanks!
Maxime


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mfio26ejibuzu6kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFBzTAAKCRDj7w1vZxhR
xT1/AP99hmq/AoCLtDfWQwaXRnTyDc+PDxlqD15n85//PKklRgEA9NEsPDm8XQtj
elH/kYzpOXuFFiiqPfsScp/LbRFAMgc=
=R6P5
-----END PGP SIGNATURE-----

--mfio26ejibuzu6kg--


--===============6816752333527057563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6816752333527057563==--

