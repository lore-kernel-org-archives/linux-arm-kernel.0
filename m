Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1778C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:12:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A3E20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dnu1Lz//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A3E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oWrJ2PPoVwGZpm3AD85+yTB+k5b8C+848/ogB360G9w=; b=Dnu1Lz//I1APapUuWK+4xkYCB
	LNGT5TuvoBdWUaie1aPyrTnhFKS32rapDk1WrBRZSuam1HQ32j19Hdy1lngr2Ec9VFxb3VD6pPCa3
	oy05KqiZcsS3zi7O4XvI5UNZJOrQFz48nuDowrDIPIVhSFalbSziKw06U6+Mg+nQ3N3cRv4Jt/3DD
	4X2MtBusC0Dc8emL32jpoyfaR1teuea/is5Z/TlxAOLX/5rLWCJbB3aNjRpxrKS6wan90Sr++lf4Q
	TzbRS4FlVHEohThuhkzdRk1n+hRV5LNyoJ9ZQfUAUBaoSQUnwWAwW6qSm8hAEPDDYXLpG2HiecIGl
	KPZbjE6qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNwP-0004e7-63; Wed, 06 Feb 2019 14:12:41 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNwK-0004dV-PA
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:12:38 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D461F1C0007;
 Wed,  6 Feb 2019 14:12:30 +0000 (UTC)
Date: Wed, 6 Feb 2019 15:12:30 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/4] drm/sun4i: dsi: Change the start delay calculation
Message-ID: <20190206141230.k3sngyad2k5rdmrx@flea>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <624512bb9665e0b15244c2bdf230bcfada3a3b98.1548236066.git-series.maxime.ripard@bootlin.com>
 <CAGb2v6702pRt-=SrOLqfxO5CBQT+bxFgQ6fugA=4SP_vWdqcBw@mail.gmail.com>
 <CAGb2v66h67zmGB9jZ4QxUN1mU-pZy4kPRzvSxu1ECOi4SqETUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v66h67zmGB9jZ4QxUN1mU-pZy4kPRzvSxu1ECOi4SqETUA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_061237_114729_FB744E5F 
X-CRM114-Status: GOOD (  30.76  )
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
 dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============4470405644041183318=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4470405644041183318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtfffd23oijtmm3s"
Content-Disposition: inline


--vtfffd23oijtmm3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Wed, Feb 06, 2019 at 12:48:21AM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 30, 2019 at 11:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Wed, Jan 23, 2019 at 11:54 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > The current calculation for the video start delay in the current DSI =
driver
> > > is that it is the total vertical size, minus the backporch and sync l=
ength,
> > > plus 1.
> > >
> > > However, the Allwinner code has it as the active vertical size, plus =
the
> > > back porch and the sync length. This doesn't make any difference on t=
he
> > > only panel it has been tested with so far, since in that particular c=
ase
> > > the front porch is equal to the sum of the back porch and sync length.
> > >
> > > This is not the case for all panels, obviously, so we need to fix it.=
 Since
> > > the Allwinner code has a bunch of extra code to deal with out of boun=
ds
> > > values, so let's add them as well.
> > >
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm=
/sun4i/sun6i_mipi_dsi.c
> > > index 380fc527a707..e3e4ba90c059 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -357,7 +357,12 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi=
 *dsi,
> > >  static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > >                                            struct drm_display_mode *m=
ode)
> > >  {
> > > -       return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
> >
> > According to the diagram in include/drm/drm_modes.h ,
> > This is active region plus back porch plus 1, as
> >
> >     sync_end - display =3D length of front porch and sync
> >
> > > +       u16 delay =3D (mode->vsync_end + 1) % mode->vtotal;
> >
> > And this actually means
> >
> >     (length of active region and front porch and sync pulse plus 1) %
> > total length
> >
> > So I don't really understand what's happening here. And the modulus
> > is unexplained.
>=20
> Attempting to make sense of this.

Sorry for dragging you into this

> Allwinner's A64 BSP the following which uses their definitions for
> y, vbp, vt:
>=20
>     s32 start_delay =3D panel->lcd_vt - panel->lcd_y -10;
>     u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
>     u32 dsi_start_delay;
>=20
>     /* put start_delay to tcon. set ready sync early to dramfreq, so
> set start_delay 1 */
>     start_delay =3D 1;
>=20
>     dsi_start_delay =3D panel->lcd_vt - vfp + start_delay;
>     if (dsi_start_delay > panel->lcd_vt)
>            dsi_start_delay -=3D panel->lcd_vt;
>     if (dsi_start_delay=3D=3D0)
>            dsi_start_delay =3D 1;
>=20
> This can be converted to
>=20
>     dsi_start_delay =3D max(1, (mode->vtotal - (mode->vtotal -
> mode->vdisplay - (mode->vtotal - mode->vsync_start)) + 1) %
> mode->vtotal)
>=20
> and simplified to
>=20
>     dsi_start_delay =3D max(1, (mode->vtotal + mode->vdisplay -
> mode->vsync_start) + 1) % mode->vtotal)
>=20
> and reordered to the following
>=20
>     dsi_start_delay =3D max(1, (mode->vtotal - (mode->vsync_start -
> mode->vdisplay) + 1) % mode->vtotal)

Where did you find that Allwinner's back porch is including the sync
length?

If we treat the bp as vtotal - vsync_end as we should (and yet I often
fail to), then we end up with (leaving out the modulo for now):

dsi_start_delay =3D max(1, mode->vtotal - (mode->vtotal - mode->vdisplay -
                                         (mode->vtotal - mode->vsync_end)) =
+ 1)

which equals (if we remove the first mode->vtotal - mode->vtotal)

dsi_start_delay =3D max(1, mode->vdisplay + (mode->vtotal - mode->vsync_end=
) + 1)

Otherwise,

Then yeah, I end up with the same results than you, and on the Rondo
display I have, the start delay difference is of one between the
formula in this patch and the one you came up with, so I think we're
good.

The BPI-M2M display timings would need to be adjusted as well, since
the timings were created from the FEX file and the BP was assumed to
be only the BP. We don't have the datasheet for this one though, so
it's difficult to check.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vtfffd23oijtmm3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrrTgAKCRDj7w1vZxhR
xRP3AQCB4QT2Kfkgw/sLwNeurp/85xZGuPNgLNhnwA3xStXVqwEA0bLghEYVmoM5
4FZegMn/x/O6pFh0z9fg7gL1k2t0JQo=
=txq4
-----END PGP SIGNATURE-----

--vtfffd23oijtmm3s--


--===============4470405644041183318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4470405644041183318==--

