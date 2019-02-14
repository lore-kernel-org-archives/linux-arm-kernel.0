Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98693222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tC7b8iBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98693222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L3AT/OVf5yE/74Pu5Cf/aw0Ri/8HAuRP88G5b0HJvTA=; b=tC7b8iBJwvzoVBCN1pX9/8ysj
	wImiH2hJm0hLH786SeGfwFuWhxjokdj0Ds4SoPAeyrVCeztfGuZnTSv3H3eotHDeCEdH85RFOJXln
	AuGoaVKYBUjNhwMgjib0F4Mnk0yr97NOWfkeaR5zhxuPF+JtfJd82ENpr4XUnL4h0VcrEeAy8xWjz
	PNPWa+UhMCJfkwA7MCx15QusSAXrOfKI6l97QgRmK81KVuZhQhpkJ+sTP7eD22yf61Puj8JQdDCLD
	DnDt9abqOBPT+YOB8pFF1N+8SxlqV9JguuRGEiRdLsE+OjnCXQLpgWRm3ibTaFitetmaypgdPl8OS
	M6VTO6Psg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guD7M-0003KD-L1; Thu, 14 Feb 2019 09:15:40 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guD7I-0003Jm-JD
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:15:38 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AD7791BF206;
 Thu, 14 Feb 2019 09:15:26 +0000 (UTC)
Date: Thu, 14 Feb 2019 10:15:26 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 7/8] drm/sun4i: dsi: Add burst support
Message-ID: <20190214091526.voqgvazgh42zq4ca@flea>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <1dcabf2b38d3f0d3387b1cf02575e3d14e3ecd4e.1549896081.git-series.maxime.ripard@bootlin.com>
 <ec69feeda5ec2b09f87c81b555f664e562276803.camel@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <ec69feeda5ec2b09f87c81b555f664e562276803.camel@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_011536_969939_DAF1EBA0 
X-CRM114-Status: GOOD (  19.73  )
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
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0926825480010848348=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0926825480010848348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgqe2bwwxg7qzp55"
Content-Disposition: inline


--xgqe2bwwxg7qzp55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 03:36:48PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Mon, 2019-02-11 at 15:41 +0100, Maxime Ripard wrote:
> > From: Konstantin Sudakov <k.sudakov@integrasources.com>
> >=20
> > The current driver doesn't support the DSI burst operation mode.
> >=20
> > Let's add the needed quirks to make it work.
> >=20
> > Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 171 ++++++++++++++++++++------
> >  1 file changed, 132 insertions(+), 39 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/s=
un4i/sun6i_mipi_dsi.c
> > index e0288e7dc64e..4cb715dc9100 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>=20
> [...]
>=20
> > @@ -457,52 +531,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_=
dsi *dsi,
> >  	struct mipi_dsi_device *device =3D dsi->device;
> >  	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> >  	u16 hbp, hfp, hsa, hblk, vblk;
> > +	u32 basic_ctl =3D 0;
> >  	size_t bytes;
> >  	u8 *buffer;
> > =20
> >  	/* Do all timing calculations up front to allocate buffer space */
> > =20
> > -	/*
> > -	 * A sync period is composed of a blanking packet (4 bytes +
> > -	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> > -	 * minimal size is therefore 10 bytes
> > -	 */
> > +	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > +		hsa =3D 0;
> > +		hbp =3D 0;
> > +		hfp =3D 0;
> > +		hblk =3D mode->hdisplay * Bpp;
> > +		vblk =3D 0;
>=20
> It looks a bit strange to zero these variables here while basic_ctl is
> initialized to zero when declared. I think it would be more consistent
> to have these variables set to zero in the same fashion.

You're right, I've fixed this while applying.

> With that fixed:
>=20
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xgqe2bwwxg7qzp55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGUxrgAKCRDj7w1vZxhR
xdGcAP9ehkddS4gh/RYOTky4z1h5KhIsbCoJPstc7AJ8vLRqsAD+PlUtwkTUBJAi
8SX6Fb5RuECNt4i0LPKzRCOLXDL/vwE=
=+vtF
-----END PGP SIGNATURE-----

--xgqe2bwwxg7qzp55--


--===============0926825480010848348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0926825480010848348==--

