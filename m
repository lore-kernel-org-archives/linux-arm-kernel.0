Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:22:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0B8207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ege0UbUD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aptzt37u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0B8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vo+X6cLyUdS7jufW3Oy/hYZk1UF8Sj8ndT9/oSbbL1I=; b=Ege0UbUDqN8ovN7uY5YTnB7gT
	keXbufoJsxosBjYcdTDEpwId6Inrle2JzUN+7nNYUCFbzuotH8pXxJcCyHhgWynOVERyY3tDfgxr7
	zArrHXqqySNSJb3uZqq0Prjxfn9EgTU7ilOvWWyNClst74wxY50AeRrweRqYj6DlkLmaCrKOdCnzp
	cmSo+Tz99GBTi2THWVV2hAGFAYJZXGx3jrbS/fIaFU0HdUQwnwLPPX7u7C9drEHfL4EHbGE/Vh6Ti
	swzB20fWWMP9t9lRnOsmm9/mMekGH2oNrK6P9k8AnbpuhnS8rg7uwqGtKhxfx5zCJnOFErgIdpoQZ
	I+TVfVDYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcKY-0000t0-Uh; Mon, 04 Feb 2019 11:22:26 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqcKU-0000sY-P0
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:22:24 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so12746697wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 03:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=y+VrIkqhrK3ONaY6hDdJQYS1fmaonL9Fe457VZS+d2Q=;
 b=Aptzt37uqJXbTCnr5Veq56gV0ot4rawKfm8ahVk4LDlwD5O9VuwMsCqVwUOaEQcRbZ
 ZqR2hiOo2DmeezO9C5D1Qu0pVACJGTmbC3xqYwWSyuoNicfavWmzei0narPGg17TjRdL
 zEbrHwEoQ8POvH35gxEswhw0v/NY2WK1OswmKdzkjUzqvoMEcgV764Ym1ov9xY4o/j7k
 iE+gR87RwsoUDLd8dvEaoFmycv/EJG/3xyQX2/oivl12R51/udh1/gmJETDDu3Skx+QS
 XH6D/UUhGeZDkJJXeUhfRWPWIaXbwJSRAlywCKhXMOv9zgA+pKdgb+SUoT2wHDEV5Q/r
 idUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=y+VrIkqhrK3ONaY6hDdJQYS1fmaonL9Fe457VZS+d2Q=;
 b=UAk/7nOXmkMZozdfgh/ROTdQ4lueOM7qICq/1zgNB62C1KCaNprG5ng7ADayogX1Yn
 RuVxvetPGOYa/Z807qJoo9o92XqLie8pKQDtMCxkPflw+qjqAe1qFYmWRHWBUbXWUlJV
 H0BcQSCDVb/ATTAF2dEDl96D9cVyoZkRFUmqm73B6MDMyxP7VzEiSFSbdFpexpkVuBbI
 Lzg2RSMDJG3XHSnE/Fs67bTVHjFaKjPuRnv9CqmU7/Pie2BTNjl1+ul+KNZ4apnxaxe6
 l2Ft8ynCilaRsiUaBdbUlsH7JL0Qb22dpz8zvt3YwAjccS0w7MtRyx+aXBrAO6l74xiL
 Kueg==
X-Gm-Message-State: AHQUAuYigkKx0gKVYu/fNonyXQaifJ57sj2/w4C4URHqp2/WuYeSALhE
 Nu21YMsm5LsgIv+z0OKjwYE=
X-Google-Smtp-Source: AHgI3IYJIv5w7Fm4FCMICKls7aeqzpy5KMBMLsk0HObtUWuXCofyPO6qGEJtK6KNx1AXa9c/m7GSFg==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr12929829wmc.35.1549279340820; 
 Mon, 04 Feb 2019 03:22:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id h9sm2823080wrm.49.2019.02.04.03.22.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 03:22:19 -0800 (PST)
Date: Mon, 4 Feb 2019 12:22:18 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204112218.GB10412@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
 <20190204082353.GE19087@ulmo>
 <20190204094012.GP3271@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20190204094012.GP3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_032222_838210_3E752654 
X-CRM114-Status: GOOD (  38.96  )
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
Content-Type: multipart/mixed; boundary="===============6981248424008568308=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6981248424008568308==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 10:40:12AM +0100, Daniel Vetter wrote:
> On Mon, Feb 04, 2019 at 09:23:59AM +0100, Thierry Reding wrote:
> > On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> > > On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > > > eDP panels usually have EDID EEPROM, so there's no need to define=
 panel
> > > > > width/height or any modes/timings in dts. But this panel still ma=
y have
> > > > > regulator and/or backlight.
> > > > >
> > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +=
++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/pan=
el/panel-edp.txt
> > > >
> > > > Please don't try to make panels look more generic than they really =
are.
> > > > You're going to have to provide a compatible string for your device=
 that
> > > > is more specific than "panel-edp". You claim that you don't need any
> > > > extra information that is panel specific, but you don't know that n=
ow.
> > > > We have in the past thought that we didn't need things like prepare
> > > > delay, but then we ran into situations where we did need them.
> > > >
> > > > Just do what everybody else does. Provide a specific compatible str=
ing
> > > > and match on that in the panel-simple driver. Even if you can read =
all
> > > > the video timings from an EDID EEPROM, you can still provide a mode=
 in
> > > > the panel descriptor to serve as a fallback if for example the EEPR=
OM
> > > > is faulty on some device.
> > >=20
> > > Pinebook used several 768p panels that have slightly different timings
> > > and recent batch uses 1080p panel.
> > >=20
> > > What panel descriptor should I use as fallback?
> >=20
> > You don't use panel descriptors as fallback. The simple-panel driver
> > will bind to a panel device and use the corresponding descriptor. If
> > your device tree contains the correct information, the descriptor is
> > correct for the panel you have.
> >=20
> > In other words you need to ensure that you have the correct panel in
> > device tree for the board that you're using. This is exactly the same
> > thing as for other devices.
> >=20
> > One way to to this is to have separate device trees for each variant
> > of the board that you want to support. Another variant may be to have
> > a common device tree and then have some early firmware update the DTB
> > with the correct panel information.
>=20
> This would defeat the point of edp, which is to standardize the mess of
> panels (at least somewhat) and avoid having to change the DT/ACPI
> tables/firmware for every board you ship. Also, we do have DP quirking
> infrastructure already (using the OUI), I think if there's something that
> doesn't work then we should quirk it there.

The problem is that while the attempt may have been to standardize, it
failed. It doesn't take into account any of the details such as timing
between things like powering up the display and enabling the backlight
or similar. I don't know how you'd want to "quirk" those kinds of
requirements because they are highly panel specific.

> What does make sense though imo is if we try not to stuff the edp panel
> into panel-simple, because it's anything like a simple dumb panel. There's
> also some integration awkwardness since with this panel you need to do dp
> aux/i2c transactions to get at the information (edid alone isn't good
> enough for edp), and I'm not sure how exactly that's supposed to be
> instantiated. Maybe a special function to instantiate an edp panel, which
> takes both a DT node and the dp_aux controller would be much better,
> instead of trying to auto-match against a DT compatible string and load a
> panel driver which is almost all fake.
>=20
> Or we teach dp_aux to register itself and somehow teach panel-edp how it
> can get hold of the dp_aux channel it needs.

We already do that. drm_dp_aux registers as an I2C adapter that can be
used to read EDID EEPROMs using I2C-over-AUX transactions. We already
use that on some platforms.

Also note that simple-panel already supports getting video timings from
EDID. If a DDC link is present in DT, the driver will load the modes
=66rom EDID and use them.

> But fake mode in panel-simple sounds like the wrong approach. At least
> from our experience with i915 (and I think other drivers supporting edp),
> the standardization of panels for basic stuff at least worked.
> Self-refresh seems an entirely different story unfortunately ... but again
> quirking that for DP stuff should be done using the OUI I think.

I can imagine that on x86 platforms OEMs can also easily hide some of
the necessary quirks in ACPI. None of that exists on ARM or other
architectures that solely rely on device tree to describe the device.
Since there's no way of specifying power sequences in DT (there have
been attempts in the past to make that work, but they failed miserably)
all we can do is match on a compatible string and encode the necessary
logic in the driver. Luckily we haven't run into anything too fancy up
to now and we've been able to make things work mostly with just a couple
of fairly generic parameters.

Also note that initially people thought this wasn't going to be
necessary and we only added the various "delay" parameters later on
because it did turn out that not all panels are created equal.

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYIGcACgkQ3SOs138+
s6FXZxAAihsV/gpbdg7KzDhqxCCd3t9GKglIgxxfUqCmjhV2iqcgVNSFxkw3qmg9
pUNNo45CsyMYz89rJDMCUXsftThfBaa/kaV3JTC0uwgp7Mgnr3h8LQIUeqxFuIkU
YAqrNZ72l82TO1r5EErFtJKHZjryhjn9KpkgELwDJgaS8qb0cU2Of0FCh2Ol8GqR
4qy6Z6gXxEDZqOhr4CH2jdjV1hFlb3I/pPOayciyuYT624H4CLGRUfHgZPpSm5wa
L2RuhN+c8Ur6pOD2mkYIOiEwIfegIP4qIEzwfGc56virNnaMOao0QRhD47qrXzpx
zVsps2bB+qmobft6UK7+U+oARoZ2TJBFU3yqz98rnVbIZ6j4OTM4Zd77+bPv+hUI
dVWrxhoVN85sd9p/sX8ULgwcdVNav88ZG3ZsO8GYtbUDhoRDd2rc02gYPdJzBzFK
E24JrXGPoMxw3t9MfKFe8dGf3d9rC/h0mstnjwLnCSdxVaKeBYlCUHMIZFEgGIjs
c/MJrHe9fMjNII5nn7gvt+cfdM3KOESFwSGIrfre6fRiuY0jjze/BrKZCwfzwfcc
IjIgtQ6OWUI4W5ZxJkbc41QbgOpxhtC0sGz8H6v/pTIGEnne+LmhsZ+rYQ0WKcfS
+ffWUHOPSa4+Xhz3k3hYadzEEeROiOy2e8ovspp8L9D3k4eSzL0=
=LT7o
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--


--===============6981248424008568308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6981248424008568308==--

