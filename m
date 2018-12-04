Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:22:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C54F2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ckrim/Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C54F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fszsUaA07MG98BOLKo2dFO8XT/b9EjKo5w+RkyMIdA8=; b=Ckrim/UftcAue2BAN62Mer+wt
	Xi+99mzWHRYcJOdBWrA9lZ+VqCBnri3w5CD2xEnA4rBL8/Ig2NXArs5AndMvfEV5z8IojgOVsHD4s
	pDiH4h7YzbBlxCvGI8/MORVyj2Sco+J8S5GJ5KvQCAq1tsAZKLKDppaWZ0ojueHulgpnQ1Jwq+e3Y
	dWvZYhOEaT3btOH+28uyYXtu4BJWmK5UxdHqsjuCkKPmfrX7VCrbuVLfzQb2fsxnkUJTywQqP8bYO
	7ues15+sBHRUpIlNZz6Pbzmqjilsxq9Dnn9iYy4AXmnineVFq8Z0a0jLOGDuu20ujtb9Ofc6k/pHQ
	NAOqGDElQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCWp-0005sI-RD; Tue, 04 Dec 2018 15:22:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCWi-0005rQ-G6
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:22:25 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 09BB620736; Tue,  4 Dec 2018 16:22:09 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id BB33F20711;
 Tue,  4 Dec 2018 16:21:58 +0100 (CET)
Date: Tue, 4 Dec 2018 16:21:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 04/21] drm/sun4i: frontend: Pass DRM format info to
 input mode helper
Message-ID: <20181204152158.rclvmyql6ct5jley@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181204142218.16284-5-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_072220_810300_224DA35A 
X-CRM114-Status: GOOD (  19.25  )
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
Content-Type: multipart/mixed; boundary="===============5109220288574363384=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5109220288574363384==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qmeysasvn3o4kko2"
Content-Disposition: inline


--qmeysasvn3o4kko2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:01PM +0100, Paul Kocialkowski wrote:
> The helper returning the input mode needs to know the number of planes
> for the provided format. Passing the fourcc requires iterating through
> the format info list in order to return the number of planes.
>=20
> Pass the DRM format info structure directly instead, since it's
> available to the caller. Also rename the input format in the caller
> function to keep things consistent.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 1a7ebc45747e..c436fa97928f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -116,9 +116,11 @@ static int sun4i_frontend_drm_format_to_input_fmt(ui=
nt32_t fmt, u32 *val)
>  	}
>  }
> =20
> -static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *va=
l)
> +static int
> +sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *fo=
rmat,
> +					u32 *val)
>  {
> -	if (drm_format_num_planes(fmt) =3D=3D 1)
> +	if (format->num_planes =3D=3D 1)
>  		*val =3D SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
>  	else
>  		return -EINVAL;
> @@ -183,12 +185,13 @@ int sun4i_frontend_update_formats(struct sun4i_fron=
tend *frontend,
>  {
>  	struct drm_plane_state *state =3D plane->state;
>  	struct drm_framebuffer *fb =3D state->fb;
> -	uint32_t format =3D fb->format->format;
> +	const struct drm_format_info *format =3D fb->format;
>  	u32 out_fmt_val;
>  	u32 in_fmt_val, in_mod_val, in_ps_val;
>  	int ret;
> =20
> -	ret =3D sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
> +	ret =3D sun4i_frontend_drm_format_to_input_fmt(format->format,
> +						     &in_fmt_val);
>  	if (ret) {
>  		DRM_DEBUG_DRIVER("Invalid input format\n");
>  		return ret;
> @@ -200,7 +203,8 @@ int sun4i_frontend_update_formats(struct sun4i_fronte=
nd *frontend,
>  		return ret;
>  	}
> =20
> -	ret =3D sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
> +	ret =3D sun4i_frontend_drm_format_to_input_sequence(format->format,
> +							  &in_ps_val);

To keep things really consistent, we should also convert those
functions to get a drm_format_info pointer instead of the fourcc :)

It can come as a later patch though.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qmeysasvn3o4kko2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAablgAKCRDj7w1vZxhR
xbaYAP9zYcfLDWwRHSXU8pqm4aNDYNt0WyMbJYv+h9Z/TWElbgEAupxGTM3QRuOO
3pk1BQlS5v4jeD7cuC0VLI563zlARAU=
=/Sxa
-----END PGP SIGNATURE-----

--qmeysasvn3o4kko2--


--===============5109220288574363384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5109220288574363384==--

