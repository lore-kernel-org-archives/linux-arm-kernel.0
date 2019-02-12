Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CBC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F3D21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SRKqB8F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F3D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=66W5Z2EQmcdu0R5PYB1u5n8gd2SsW17VFhw8KyssYHI=; b=SRKqB8F76hnr9MgNvxS3xbe74
	wVj14OE/qoAk7ofp2J26mfVnxqLS1mka4PU3jH/haXTa9MPpiIzgJLbex1EQtmjk8vfTmYg6AgYvB
	KeLGa3tq8M8yzzDtkM6POw3gTx7pcy8XY5jo8w/7pdRIlTfl8f/bXagvw4/s7lxU/m949fW6UtsJ0
	m+xvXcdZO2CLyRgXSHBjwHGnAbJDZPcOffBBop0ZHkSd/DXB6x38qPb7inbMPinZIl6P32BVCn/wn
	zAj8Ku6jUpnXkeS1Dx0K+yslnqQNVs4q6s3FiXAlZqYUEfTf3i//BI5CNfY32Tg3Uzx7GClA7j72j
	Cekm3m1HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtaFr-000098-JT; Tue, 12 Feb 2019 15:45:51 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtaFn-00008i-F6
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:45:49 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 15C301C0018;
 Tue, 12 Feb 2019 15:45:32 +0000 (UTC)
Date: Tue, 12 Feb 2019 16:45:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 2/8] drm/sun4i: dsi: Change the start delay calculation
Message-ID: <20190212154532.uwntofq7hkm74xjv@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <6e5f72e68f47ca0223877464bf12f0c3f3978de8.1549896081.git-series.maxime.ripard@bootlin.com>
 <0f3247c920d1f5ce67cc7e024125c3a4d3ca0c81.camel@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <0f3247c920d1f5ce67cc7e024125c3a4d3ca0c81.camel@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_074547_801549_42129790 
X-CRM114-Status: GOOD (  25.56  )
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
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7908516399185536415=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7908516399185536415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4uzrhcaamb2hejep"
Content-Disposition: inline


--4uzrhcaamb2hejep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 04:28:13PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> > The current calculation for the video start delay in the current DSI dr=
iver
> > is that it is the total vertical size, minus the front porch and sync l=
ength,
> > plus 1. This equals to the active vertical size plus the back porch plu=
s 1.
> >=20
> > That 1 is coming in the Allwinner BSP from an variable that is set to 1.
> > However, if we look at the Allwinner BSP more closely, and especially in
> > the "legacy" code for the display (in drivers/video/sunxi/legacy/), we =
can
> > see that this variable is actually computed from the porches and the sy=
nc
> > minus 10, clamped between 8 and 100.
>=20
> For future reference, it look like there is a version of the BSP where
> this is clamped between 8 and 31 in the legacy ebios code:
> https://github.com/Icenowy/linux-kernel-lichee-a33/blob/master/drivers/vi=
deo/sunxi/legacy/disp/de_bsp/de/ebios/de_dsi.c#L687
>=20
> As well as in the A23 code:
> https://github.com/Icenowy/linux-kernel-lichee-a33/blob/master/drivers/vi=
deo/sunxi/disp/de/lowlevel_sun8iw3/de_dsi.c#L686
>=20
> > This fixes the start delay symptom we've seen on some panels (vblank
> > timeouts with vertical white stripes at the bottom of the panel).
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/s=
un4i/sun6i_mipi_dsi.c
> > index 380fc527a707..9471fa695ec7 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -357,7 +357,9 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *d=
si,
> >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> >  					   struct drm_display_mode *mode)
> >  {
> > -	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> > +	u16 start =3D clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
> > +
> > +	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
>=20
> Looking at the formula from the BSP, I get a different result from
> yours.
>=20
> From what I can see, the BSP formula is:
> start_delay =3D vtotal - vfp + start
> vfp =3D vtotal - y - vbp
>=20
> With vbp counting the back porch and sync length.

vbp is only the back porch.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4uzrhcaamb2hejep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGLqHAAKCRDj7w1vZxhR
xUSMAQC4LTp8gqnt5iC/7ksPG7XPYmOUGIP/Qs5Mwts/qUUiBAD9EPUjVe78jXiM
VpzeS8E66xnifs0JmaQDpSYdZDNsxwU=
=zHqD
-----END PGP SIGNATURE-----

--4uzrhcaamb2hejep--


--===============7908516399185536415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7908516399185536415==--

