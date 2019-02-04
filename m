Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:24:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C234620821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F/zuBc8U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOLYThAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C234620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F4JkF4F1qqsi9R4fBmyo9QZvKIITHekTPPC6Lm/kPpA=; b=F/zuBc8UD7kvRXHCjetq34Z+I
	Sw9zvKZYkko6gWR5AleuRcj6Mk3yNs8tz8Rfnd1Sb+0BjpmI3Wn23Kb5NL/+17bzQwBg0IVRCGmdw
	2quFQgTXfGgorUDjbodty9oq8sbDm4oWdIpaCktOs7fpl5MDliPRl2C8gDeTmYqt+UQKao631UQEd
	AOtQq/u2UqRZDsZPYBI5K8tcJJ/WmELEoGOFq7GjjeZGQqfd6YJ3TRj7XRUbqnDtSfZ53ntMf7A7k
	RnQTHh/WLl1WJa7JjuDWOdomxzzdqdT8dnZobDVibw8xrj5ujLEcVmO37CCNhlCGK5zuhQN8MT6Zh
	WT+QGZrLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZY2-0004jz-Sj; Mon, 04 Feb 2019 08:24:10 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZXv-0004dI-32
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:24:07 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so13358751wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vOjBSW+ZLWQaT8OqLHDOmNs1QPmx0zzPtqpclZFjnJs=;
 b=nOLYThAAGTEwgIqbEn8NIUwD5Xf6jy9czb2+jY+YuwT1QL7V7OV3Z1zk35ik0IFFV2
 nOXAyptosH6u+yLQ38I4arKog+2FLSfvInDairTLUeCf02pkWDUJ/Cw/nT54VM1EnGyS
 qHoX8W7SQ1bLYurkpIwM2U5RzbQk3omyovQzBlDCKkcmHvAMnYFktVK1LhgKa0epmUuH
 MJEw3YnEo0GW0hTfqDHLIIL8rm8xLdVCx9TBFPH43nVs8cktb8lOdBkhe1wR4Cr+dvzY
 QoqE2BlO+L5cnl8bPSCj2OYgMVVfv8xdqIrjDy+CHu1ollBCIE8nwzAty0n6KkjCciQ+
 h2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vOjBSW+ZLWQaT8OqLHDOmNs1QPmx0zzPtqpclZFjnJs=;
 b=JdTQ7qh6Z4dG3tKa305fUwxqWv61DGg7phxz2GDWzhHpFhXTgKRiVH9YNwTMftO38Y
 XbWSzbUcBx85zBNhfb/f6s76hVNO6c+cLp6+PZaABaXYUG2aQrSQAFeIqVPvzF79gO7l
 fwsulMZIQFIOPCe1xMOHBGNxkP4yXlkTshgfKEFUn+vDas7JsJy84UxISlFIwp87ahA5
 elAEgy3may7Kx/lI8lJEY1lxqOSoBTVm2ILWHE6smxtnPaawIPCzbbhyU84wSFE5Nk0D
 ZLrw146ypCRrsywEbfPn8UyZo5oyHQQ/BcNkj2owLc554o3ybkb/y03rM5kIGGR7g6Wa
 Y4og==
X-Gm-Message-State: AHQUAuYjmpY6LdPuxXFWAOAXfKIxNucF61gEBaVWLgtUm5rhJO8GiQny
 aX6c/NX/jJ09VfZhEMf1o9w=
X-Google-Smtp-Source: AHgI3IaORJ9I4EkWbNDOGpt+d8ycnJTXwWzTLBtYXGVL88Nr3AGJgzcJ+/+/NH31EsDiqkwJGuUdCw==
X-Received: by 2002:adf:8484:: with SMTP id 4mr41512132wrg.249.1549268641365; 
 Mon, 04 Feb 2019 00:24:01 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id a6sm12627008wmh.10.2019.02.04.00.24.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 00:24:00 -0800 (PST)
Date: Mon, 4 Feb 2019 09:23:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v2 08/12] dt-bindings: add binding for generic eDP
 panel
Message-ID: <20190204082353.GE19087@ulmo>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-9-anarsoul@gmail.com>
 <20190204074350.GC16448@ulmo>
 <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E=qVecudACOEXt74Kf=UA_F-uuHgEqHzKpYAq1ocMx3Sx+eQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_002403_710808_615E04D9 
X-CRM114-Status: GOOD (  23.83  )
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
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============8666668862730932039=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8666668862730932039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 12:13:55AM -0800, Vasily Khoruzhick wrote:
> On Sun, Feb 3, 2019 at 11:43 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Sun, Feb 03, 2019 at 10:54:57AM -0800, Vasily Khoruzhick wrote:
> > > eDP panels usually have EDID EEPROM, so there's no need to define pan=
el
> > > width/height or any modes/timings in dts. But this panel still may ha=
ve
> > > regulator and/or backlight.
> > >
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../devicetree/bindings/display/panel/panel-edp.txt        | 7 +++++=
++
> > >  1 file changed, 7 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/p=
anel-edp.txt
> >
> > Please don't try to make panels look more generic than they really are.
> > You're going to have to provide a compatible string for your device that
> > is more specific than "panel-edp". You claim that you don't need any
> > extra information that is panel specific, but you don't know that now.
> > We have in the past thought that we didn't need things like prepare
> > delay, but then we ran into situations where we did need them.
> >
> > Just do what everybody else does. Provide a specific compatible string
> > and match on that in the panel-simple driver. Even if you can read all
> > the video timings from an EDID EEPROM, you can still provide a mode in
> > the panel descriptor to serve as a fallback if for example the EEPROM
> > is faulty on some device.
>=20
> Pinebook used several 768p panels that have slightly different timings
> and recent batch uses 1080p panel.
>=20
> What panel descriptor should I use as fallback?

You don't use panel descriptors as fallback. The simple-panel driver
will bind to a panel device and use the corresponding descriptor. If
your device tree contains the correct information, the descriptor is
correct for the panel you have.

In other words you need to ensure that you have the correct panel in
device tree for the board that you're using. This is exactly the same
thing as for other devices.

One way to to this is to have separate device trees for each variant
of the board that you want to support. Another variant may be to have
a common device tree and then have some early firmware update the DTB
with the correct panel information.

Thierry

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX9p8ACgkQ3SOs138+
s6EQqA//XNIE1w9xULylqbDtZ89gX9FIKxP1+3SqVO3DKAdTo48kUBGXBp/1wBSC
l6ilKWgrbSNuPFsPEGddLhBLNA73AEjerQ3ANfb8581AoDwa2Z/rSJwJhbUXtv4Q
Ec5f2OlSKH2wuRoZuVoKI7nedcuV9V0zSFxEgu1rqEZVACVleAaQD6ClfPsSJSVx
qIU0aP9GZx7dWsJU+aAvNqWle5HtzbuQokrDcZ7PgN5rI/GGyk74NdyJefBbzhdt
0ePiEmea5CJaWh7XK17ZGH2oocOUdFVQt6auz0dosx+v5jjw8STP/r2/CmVSuSrm
GlECmK3lsqDjIidAapRKc7iLHrI7BRq2pt8Xry/BeOpgQguxnIb8Q2X5T2Hnf+bk
Hds0uWi2tJNVc5/R5BV493t8UOMkvppR4EqbOf89e3kc20LFZsWwI+94j7R1+F7G
ovNo2GGhBlA7UQgliihXY/x8vufWITKczU6nLx8Y0Bm5XCvcH7ITA5ptbhvh+WUq
81ciZTtxepaRJhboOcMidVBuQFPzpDRnNLisusm7D+Z73EAU2EqQaLUJeyi9EQnx
VPyo1cJom5gqJ8xL9UrfBFfZ7zV7t7HX7P1bwwMeQ7yuDySre7cXvNtPoUdooD0T
RB8z1V0h7g0ePQ7DWC/ooNg3wF1VfJqfxxieDlt9OwqfYy2iOqY=
=dowY
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--


--===============8666668862730932039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8666668862730932039==--

