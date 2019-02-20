Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4D520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uLBexp1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4D520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/IW37H42pyQb/C7iVY3fUdxV0iQTyhyNrnJknjINP7c=; b=uLBexp1VlS87FD79nr4jPpycR
	7PIdAkWIfg+hdEKBY0ZSGsAoWla8ywlP7uiBDO16EO+9AZ3LToIxx/QqyXdZxhZt/Mq0h9bVa9zdz
	qYUk+RSQxPss8WffYx/l5KQ0INBAeemo12h8ARU50rMp5jMQbriYoz8sUyobVsdJdj4jV+Zx8DkIU
	c1K+q5nrlTCbYm1NrGpuZa6o+upmERszClzI1rEW4e3spMHaOs2VdXhmbVGyWLDOyXsNW+e3WFm6q
	xulGFW52fJ5n5aD6i71M/MyLFON1QedGGUP5yXvd3LpcRQRyKo0wG4pSF7rxvs1p0R3BIcw9qQTi/
	ZxugN5QJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPCV-0005h0-Bf; Wed, 20 Feb 2019 10:34:03 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPCQ-0005gO-HB
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 10:34:00 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 451441BF21F;
 Wed, 20 Feb 2019 10:33:48 +0000 (UTC)
Date: Wed, 20 Feb 2019 11:33:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
Message-ID: <20190220103347.74wqu2btdti2myi7@flea>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
 <20190218182629.GA14714@bogus>
 <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
 <20190219085626.7poutwvm3lrilnon@flea>
 <CA+E=qVfV8ds-zb0oG1-g8c-ReCSnZjfUjvAHbZf1zBf8H-xUcw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E=qVfV8ds-zb0oG1-g8c-ReCSnZjfUjvAHbZf1zBf8H-xUcw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_023358_865218_2DCAF5B9 
X-CRM114-Status: GOOD (  38.01  )
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
Content-Type: multipart/mixed; boundary="===============7522271037609828726=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7522271037609828726==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5pzj3icjzfrpvm6r"
Content-Disposition: inline


--5pzj3icjzfrpvm6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 07:44:56AM -0800, Vasily Khoruzhick wrote:
> On Tue, Feb 19, 2019 at 12:56 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Feb 18, 2019 at 11:33:05AM -0800, Vasily Khoruzhick wrote:
> > > On Mon, Feb 18, 2019 at 10:26 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Feb 14, 2019 at 09:09:52PM -0800, Vasily Khoruzhick wrote:
> > > > > Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4=
i: rgb:
> > > > > Validate the clock rate") prevents some panel and bridges from wo=
rking with
> > > > > sun4i driver.
> > > >
> > > > Sounds lile a regression that should be reverted. The fix is not a
> > > > backwards compatible change either.
> > >
> > > anx6345 driver isn't mainlined yet and I'm not sure if this change
> > > breaks any mainlined boards. So likely there's not enough
> > > justification to revert it.
> > >
> > > > > Unfortunately, dotclock frequency for some modes are not achievab=
le on
> > > > > sunxi hardware, and there's a slight deviation in rate returned by
> > > > > clk_round_rate(), so they fail this check.
> > > > >
> > > > > Experiments show that panels and bridges work fine with this slig=
ht
> > > > > deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP p=
anel
> > > > > requests 73 MHz, gets 72.296MHz instead (0.96% difference) and wo=
rks just
> > > > > fine.
> > > > >
> > > > > This patch adds DT property to disable strict clock rate check
> > > > >
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2=
 ++
> > > > >  drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5=
 +++++
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3=
 +++
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1=
 +
> > > > >  4 files changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4=
i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > > index f426bdb42f18..18c8b053a28d 100644
> > > > > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.t=
xt
> > > > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.t=
xt
> > > > > @@ -63,6 +63,8 @@ Required properties:
> > > > >      Documentation/devicetree/bindings/media/video-interfaces.txt=
=2E The
> > > > >      first port should be the input endpoint. The second should b=
e the
> > > > >      output, usually to an HDMI connector.
> > > > > +  - no-strict-clock-check: don't reject timings if exact dot clo=
ck can't be
> > > > > +    reached.
> > > >
> > > > This should be the default IMO. Most panels are a single timing, so=
 if
> > > > we reject it the fallback no display?
> > >
> > > As far as I remember the change was introduced to reject some modes
> > > for which dotclock can't be reached when driver is used with VGA
> > > bridge. So if we make it default it'll break boards with VGA bridge
> > > and old DT.
> > >
> > > > I thought we had some mechanism already to allow some range of
> > > > frequencies. I think the chromeos guys needed something IIRC.
> > >
> > > You can specify frequency range for panels, but there's nothing for
> > > bridges. In my case EDID doesn't specify clock tolerance.
> >
> > I gave it some more though, and came up with the following patch. The
> > basic idea is to leave the boundary check for the bridges that will
> > have EDID and we need to filter out the modes that have no chance of
> > being supported. The tolerancy used is the one defined in VESA specs,
> > but I added a module parameter if you wanted to tune that.
> >
> > And finally, since most of our panels are single timings without any
> > tolerancy, we just try our best in this case and that's it, while
> > leaving the door open to support display_timings and being able to do
> > more once we have an idea of what the tolerancies are.
> >
> > If that works for you, I'll submit it.
>=20
> Maxime, thanks for your patch but  it doesn't work for me. Pinebook
> needs 1% tolerance. Having it as a module parameter means that no
> distro will be able to boot on Pinebook out of the box.

I don't really know what to tell you, the VESA spec defines everywhere
that tolerance, and if we're not able to provide that, then we're not
compliant and I don't want us to not be compliant just because one
panel needed to be a bit more flexible, and especially since what
could work on one panel might fail on another one.

If you want alternate solutions, then please answer to:
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/630441.=
html

or provide the EDID blob.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5pzj3icjzfrpvm6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG0tCwAKCRDj7w1vZxhR
xcPdAQD3QK+JgtMVF7zAZamVJQ5eyWerSJoI2PTgf92lJjyBQgD/YpdqqtVy4t7b
jb22/lSRTvnPq1MoiYrbLL64GdDOJQs=
=XNrV
-----END PGP SIGNATURE-----

--5pzj3icjzfrpvm6r--


--===============7522271037609828726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7522271037609828726==--

