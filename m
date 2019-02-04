Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB248C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954242082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tl5hxhyF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeZy50wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954242082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=37OkR26QgolbzIzhN2BC2F9iQV/PlooNYCrOKnjodQY=; b=tl5hxhyFy/cKme7McJMa3Lm17
	jCdR2FEscdZrFqXnO5sLZQtgm8oyktBJ+PB+S/CMADwb6T70QePI0bQmegt+gSg437khmWrRDslDm
	mKIFw+3LEkNwijjCDDwR60PjV2gYkPS2Bk2cufWKJ6kNIZ4f0WmeLg6a2Hh3xwaBM86mYYyqSgz0U
	p6SsKluxD8+YNV2GmYzhUM0lBruhWWt+ETKqNNLv1H2UjQJd46NwARi7YMOrKfcFjS3U7ZpFCFZY1
	hfseQf3YNBdBk5RxwkKz0S0o+XXLlTMXFpECZOQ+8I8QlP4PSyqU29lORXhNOcoZyktMMkD9eQ+qY
	QfkxpDkQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh1X-0007BS-TW; Mon, 04 Feb 2019 16:23:07 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh1T-0007B3-Ve
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:23:05 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so477224wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qlMxYKbW+lIcoJikjPuRdAirnjfH5Ms9/XwT22wDw4o=;
 b=HeZy50wtopM5RCFivwlF3FEaQdtfR99at3Eujdq+7aLO4ezavKv6+gR7PgZJlivgIj
 k6Fib0rNNNA5/ZfwElQYzYnwaxq17N9agmaOFlIyLJbZ/BFzhDkm3USJ+BDjGYNWVGJI
 PJeLX8BNa73wYRvr62EXtzYDRkiNjkjwcB2CdrZu8OnRaEeJ7a5Ud/EPay6wsfCNcK9Y
 /yZqfu7JvJ1urljOoBQoU93xtlDtsOrTqf/HsaXFpZ6dUvG02Z8KKOkdOmzcJQafZfsk
 zwLvm2RMLcO4IEIaR1S4DE538ZvhjJeiVBBLfc8auwPUD8yYS7giIDOIlDJqfw8+EWdx
 TbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qlMxYKbW+lIcoJikjPuRdAirnjfH5Ms9/XwT22wDw4o=;
 b=gMUiG8moBuadhCCyQHM8GnsbpCByn1SeJf55yzVSGXzo+5dmpQW13UEUnKQlOU9ibh
 IfsD1YsKmGAjonFwUkfpM7ZK5bQ1OY0UnhhWKGAQhbqOM8fmCr4a7dzIGgycTjKQdYiJ
 aXJT6gjtN0eETd9GxA7ibdDRliT2C3eUjAlHQLiPnEnDoUbwAmoonNivt0g1xDSAQQHE
 aKPO/IRTBYWM5RqeWiO+/ItPt6DVmbHBARJb4f71LD6YJ7P3SaA8JoDF1OAn9VL3zhPx
 vUxB//3+sjJYJ6PhqEHOTM2j1ZtIp8/yWo6WvRlhfDY0bGRUir+owKRheVFxaNH4UTcO
 Gxqg==
X-Gm-Message-State: AHQUAuYsrKJYka0MdmdkdxwtwYYa8gCfDhlX7YM3f/9ZAK6U/ADB3SkZ
 xRhKns2BYBlNLyC9fya765M=
X-Google-Smtp-Source: AHgI3IYUD7sr6goD86aErcgqDEh0fGVtPvyJqlU8yvU4zwj3/wfsL2rK30ovqNgEITdnWWr79KnQRg==
X-Received: by 2002:adf:c505:: with SMTP id q5mr160081wrf.84.1549297380717;
 Mon, 04 Feb 2019 08:23:00 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id w18sm7110550wmi.12.2019.02.04.08.22.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 08:22:59 -0800 (PST)
Date: Mon, 4 Feb 2019 17:22:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204162258.GB25476@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <20190204094012.GP3271@phenom.ffwll.local>
 <20190204112218.GB10412@ulmo>
 <20190204155909.GU3271@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20190204155909.GU3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_082304_048715_44D64EC6 
X-CRM114-Status: GOOD (  43.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============0443611249407403241=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0443611249407403241==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 04:59:09PM +0100, Daniel Vetter wrote:
> On Mon, Feb 04, 2019 at 12:22:18PM +0100, Thierry Reding wrote:
> > On Mon, Feb 04, 2019 at 10:40:12AM +0100, Daniel Vetter wrote:
> > > On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> > > > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > > > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wro=
te:
> > > > > > > eDP panels usually have EDID EEPROM, so there's no need to de=
fine panel
> > > > > > > width/height or any modes/timings in dts. But this panel stil=
l may have
> > > > > > > regulator and/or backlight.
> > > > > > >
> > > > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/display/panel/panel-edp.txt        |=
 7 +++++++
> > > > > > >  1 file changed, 7 insertions(+)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/display=
/panel/panel-edp.txt
> > > > > >
> > > > > > Please don't try to make panels look more generic than they rea=
lly are.
> > > > > > You're going to have to provide a compatible string for your de=
vice that
> > > > > > is more specific than "panel-edp". You claim that you don't nee=
d any
> > > > > > extra information that is panel specific, but you don't know th=
at now.
> > > > > > We have in the past thought that we didn't need things like pre=
pare
> > > > > > delay, but then we ran into situations where we did need them.
> > > > > >
> > > > > > Just do what everybody else does. Provide a specific compatible=
 string
> > > > > > and match on that in the panel-simple driver. Even if you can r=
ead all
> > > > > > the video timings from an EDID EEPROM, you can still provide a =
mode in
> > > > > > the panel descriptor to serve as a fallback if for example the =
EEPROM
> > > > > > is faulty on some device.
> > > > >=20
> > > > > Pinebook used several 768p panels that have slightly different ti=
mings
> > > > > and recent batch uses 1080p panel.
> > > > >=20
> > > > > What panel descriptor should I use as fallback?
> > > >=20
> > > > You don't use panel descriptors as fallback. The simple-panel driver
> > > > will bind to a panel device and use the corresponding descriptor. If
> > > > your device tree contains the correct information, the descriptor is
> > > > correct for the panel you have.
> > > >=20
> > > > In other words you need to ensure that you have the correct panel in
> > > > device tree for the board that you're using. This is exactly the sa=
me
> > > > thing as for other devices.
> > > >=20
> > > > One way to to this is to have separate device trees for each variant
> > > > of the board that you want to support. Another variant may be to ha=
ve
> > > > a common device tree and then have some early firmware update the D=
TB
> > > > with the correct panel information.
> > >=20
> > > This would defeat the point of edp, which is to standardize the mess =
of
> > > panels (at least somewhat) and avoid having to change the DT/ACPI
> > > tables/firmware for every board you ship. Also, we do have DP quirking
> > > infrastructure already (using the OUI), I think if there's something =
that
> > > doesn't work then we should quirk it there.
> >=20
> > The problem is that while the attempt may have been to standardize, it
> > failed. It doesn't take into account any of the details such as timing
> > between things like powering up the display and enabling the backlight
> > or similar. I don't know how you'd want to "quirk" those kinds of
> > requirements because they are highly panel specific.
>=20
> Hm right, we get these from some firmware tables (and mix them with the
> spec one, since some of the firmware values are nonsense). I don't even
> know whether we can read the timings over dp aux somehow (you can power up
> the panel with some pessimistic values to figure those out, and you only
> need dp aux to work, which is much simpler than the entire panel).
>=20
> > > What does make sense though imo is if we try not to stuff the edp pan=
el
> > > into panel-simple, because it's anything like a simple dumb panel. Th=
ere's
> > > also some integration awkwardness since with this panel you need to d=
o dp
> > > aux/i2c transactions to get at the information (edid alone isn't good
> > > enough for edp), and I'm not sure how exactly that's supposed to be
> > > instantiated. Maybe a special function to instantiate an edp panel, w=
hich
> > > takes both a DT node and the dp_aux controller would be much better,
> > > instead of trying to auto-match against a DT compatible string and lo=
ad a
> > > panel driver which is almost all fake.
> > >=20
> > > Or we teach dp_aux to register itself and somehow teach panel-edp how=
 it
> > > can get hold of the dp_aux channel it needs.
> >=20
> > We already do that. drm_dp_aux registers as an I2C adapter that can be
> > used to read EDID EEPROMs using I2C-over-AUX transactions. We already
> > use that on some platforms.
> >=20
> > Also note that simple-panel already supports getting video timings from
> > EDID. If a DDC link is present in DT, the driver will load the modes
> > from EDID and use them.
>=20
> Could we extend this to dp aux somehow? For edp you need the dp aux (which
> then gives you the ddc link automatically).

I suppose we could do that. We could introduce a new property that would
allow the panel driver to get at the struct drm_dp_aux that can access
the panel. I'm not sure how much that would buy us. I suppose the driver
could go and use that drm_dp_aux to do I2C-over-AUX and ignore any
ddc-bus property in device tree. A drm_dp_aux object could also be used
to access DPCD if that's helpful.

The driver proposed here doesn't need access to DPCD, so I'm not sure
that would immediately help.

Thierry

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYZuIACgkQ3SOs138+
s6GDGhAAvpL0OWSivc1uUfGLTYLa7FJfJtTwj/rN6gTuCeFazSnwNelpoLFwpTxl
oReblX7BE+kO2u1yAEll3dBEWXihPpUKnQLg9UYkAi+f9L3UkklnSpdC6Kyzy7Kc
41nkgqdW5VeCfSdwSysfWoyb7zV5i/n0As1jKw82DaO4YsO6k+rpunYl2uvqiAqf
MeH8IKPtG8xolbYvX5YksJXoAAHy/I6QbNjF+cbRcYLQyuhDSfRoqGnBVWEm5+AD
6m9m7OHxLwo68xff8QFmNGK/ON43yxpGM3ipy6KIVq5i7oWliUsBKiqm/ab3d1fa
4aqfJHe/FY3t8DfyBt0tCzuoPgry8lyjnS5t+cPByqtNkRm0oATVm7AOM/7BSJf2
3HZPvDiPlBhyyrcpXNBHMY0k99fn8E/urJcKaCFBKK0R8tiY7D2OacJE465q2K8A
236HWKNLLLErCVThpfH/z3LSIH3WWGTwS+v54SZds0Yjy0jKlQHbCurwtCqvO6tN
VVuHWhnebmqy7VDQ0HBUCn5H/k2xTQETOpqzcqskVV81/wex+pwe3LF4G5rpc755
vNyT1wJsvNbI4UqJOfB9DnMflHrYhSVS8JYyJdpfJCT/mwSIf28gwGfbJNhVuui5
QkV13BLCnqs+KZKjcYaRPR1ZqDYT7A9Jj/xpCfTlUSfI92dqJjA=
=M8tx
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--


--===============0443611249407403241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0443611249407403241==--

