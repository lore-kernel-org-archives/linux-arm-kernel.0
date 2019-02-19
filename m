Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D3CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4642147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u4Y5Cc5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4642147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G0N020FciHbLcN2aI7FWRlIJcG+PLh8CZd7N8XysUd0=; b=u4Y5Cc5hRwXgruHgVMYo8BAMy
	xEXsuhOCopUeOWzN0kgyiDJGxxy98bVi5Ro2GX4Sc7atX3PteaUqFMipReQyKRqXgXx/6qf9m+xXf
	jGV2tCy9CHGt3zCIzvQc4aS+HygKXz1PhhvqeNj0YIwQBooJI4BfJVwshT4z8NGmTc7CbzvRrzP9P
	JNFb4OIBZHzUlIiKUpP55lPUEU+2sVzPRpjeEvh155nuGMlyugOVh1gcHp5M/neKIc5lGXAeBeR26
	p7ixdtf5W4b5aCYyMs9WscHKvqZ/ZvhxAufTG/aSg0mVsfUthrDOHYYMeJ3qu7+OdawIQ0MyJDOkf
	yeP7qmlCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1Cs-0006B0-OU; Tue, 19 Feb 2019 08:56:50 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1Cj-0005we-Dh
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 08:56:47 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id D335F200004;
 Tue, 19 Feb 2019 08:56:26 +0000 (UTC)
Date: Tue, 19 Feb 2019 09:56:26 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
Message-ID: <20190219085626.7poutwvm3lrilnon@flea>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
 <20190218182629.GA14714@bogus>
 <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_005641_987070_7E3D95E2 
X-CRM114-Status: GOOD (  38.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Archit Taneja <architt@codeaurora.org>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============4417097840011322059=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4417097840011322059==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dppndfprzkjywqmh"
Content-Disposition: inline


--dppndfprzkjywqmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 11:33:05AM -0800, Vasily Khoruzhick wrote:
> On Mon, Feb 18, 2019 at 10:26 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Feb 14, 2019 at 09:09:52PM -0800, Vasily Khoruzhick wrote:
> > > Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: r=
gb:
> > > Validate the clock rate") prevents some panel and bridges from workin=
g with
> > > sun4i driver.
> >
> > Sounds lile a regression that should be reverted. The fix is not a
> > backwards compatible change either.
>=20
> anx6345 driver isn't mainlined yet and I'm not sure if this change
> breaks any mainlined boards. So likely there's not enough
> justification to revert it.
>=20
> > > Unfortunately, dotclock frequency for some modes are not achievable on
> > > sunxi hardware, and there's a slight deviation in rate returned by
> > > clk_round_rate(), so they fail this check.
> > >
> > > Experiments show that panels and bridges work fine with this slight
> > > deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> > > requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works =
just
> > > fine.
> > >
> > > This patch adds DT property to disable strict clock rate check
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2 ++
> > >  drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5 +++=
++
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3 +++
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1 +
> > >  4 files changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-dr=
m.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > index f426bdb42f18..18c8b053a28d 100644
> > > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > @@ -63,6 +63,8 @@ Required properties:
> > >      Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > >      first port should be the input endpoint. The second should be the
> > >      output, usually to an HDMI connector.
> > > +  - no-strict-clock-check: don't reject timings if exact dot clock c=
an't be
> > > +    reached.
> >
> > This should be the default IMO. Most panels are a single timing, so if
> > we reject it the fallback no display?
>=20
> As far as I remember the change was introduced to reject some modes
> for which dotclock can't be reached when driver is used with VGA
> bridge. So if we make it default it'll break boards with VGA bridge
> and old DT.
>=20
> > I thought we had some mechanism already to allow some range of
> > frequencies. I think the chromeos guys needed something IIRC.
>=20
> You can specify frequency range for panels, but there's nothing for
> bridges. In my case EDID doesn't specify clock tolerance.

I gave it some more though, and came up with the following patch. The
basic idea is to leave the boundary check for the bridges that will
have EDID and we need to filter out the modes that have no chance of
being supported. The tolerancy used is the one defined in VESA specs,
but I added a module parameter if you wanted to tune that.

And finally, since most of our panels are single timings without any
tolerancy, we just try our best in this case and that's it, while
leaving the door open to support display_timings and being able to do
more once we have an idea of what the tolerancies are.

If that works for you, I'll submit it.

Maxime

--- >8 ---
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4=
i_rgb.c
index f4a22689eb54..0460146aab75 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -43,6 +43,25 @@ drm_encoder_to_sun4i_rgb(struct drm_encoder *encoder)
 			    encoder);
 }
=20
+static inline struct drm_connector *
+sun4i_rgb_get_connector_from_encoder(const struct drm_encoder *encoder)
+{
+	struct drm_connector *connector =3D NULL, *tmp;
+	struct drm_connector_list_iter iter;
+
+	drm_connector_list_iter_begin(encoder->dev, &iter);
+	drm_for_each_connector_iter(tmp, &iter)
+		if (tmp->encoder =3D=3D encoder) {
+			connector =3D tmp;
+			goto out;
+		}
+
+out:
+	drm_connector_list_iter_end(&iter);
+
+	return connector;
+}
+
 static int sun4i_rgb_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_rgb *rgb =3D
@@ -52,11 +71,22 @@ static int sun4i_rgb_get_modes(struct drm_connector *co=
nnector)
 	return drm_panel_get_modes(tcon->panel);
 }
=20
+/*
+ * VESA DMT defines a tolerancy of 0.5% on the pixel clock, while the
+ * CVT spec reuses that tolerancy in its examples, so it looks to be a
+ * good default tolerancy for the EDID-based modes.
+ */
+static unsigned int clock_tolerancy =3D 5;
+module_param(clock_tolerancy, uint, 0644);
+MODULE_PARM_DESC(clock_tolerancy,
+		 "Tolerancy of the pixel clock in per mille");
+
 static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 						 const struct drm_display_mode *mode)
 {
 	struct sun4i_rgb *rgb =3D drm_encoder_to_sun4i_rgb(crtc);
 	struct sun4i_tcon *tcon =3D rgb->tcon;
+	struct drm_connector *connector =3D sun4i_rgb_get_connector_from_encoder(=
crtc);
 	u32 hsync =3D mode->hsync_end - mode->hsync_start;
 	u32 vsync =3D mode->vsync_end - mode->vsync_start;
 	unsigned long rate =3D mode->clock * 1000;
@@ -92,15 +122,27 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struc=
t drm_encoder *crtc,
=20
 	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
=20
+	/*
+	 * TODO: We should use the struct display_timing if available
+	 * and / or trying to stretch the timings within that
+	 * tolerancy to take care of panels that we wouldn't be able
+	 * to have a exact match for.
+	 */
+	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown) {
+		DRM_DEBUG_DRIVER("RGB panel used, skipping clock rate checks");
+		goto out;
+	}
+
 	tcon->dclk_min_div =3D 6;
 	tcon->dclk_max_div =3D 127;
 	rounded_rate =3D clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
+	if (rounded_rate < (rate * (1000 - clock_tolerancy) / 1000))
 		return MODE_CLOCK_LOW;
=20
-	if (rounded_rate > rate)
+	if (rounded_rate > (rate * (1000 + clock_tolerancy) / 1000))
 		return MODE_CLOCK_HIGH;
=20
+out:
 	DRM_DEBUG_DRIVER("Clock rate OK\n");
=20
 	return MODE_OK;
--- >8 ---


--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dppndfprzkjywqmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGvEugAKCRDj7w1vZxhR
xeBKAP9MxZ1ltRUXmwrBSWt23kf049yyLPCpPRsyb7CwajnJvQEAlOGkxZSR8jlO
5+KD8ct/PVNMSJRQtDacxaSralb4egU=
=PMrF
-----END PGP SIGNATURE-----

--dppndfprzkjywqmh--


--===============4417097840011322059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4417097840011322059==--

